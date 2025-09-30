import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/repositories/auth_repository.dart';
import 'package:medibuk/domain/entities/auth_models.dart';
import 'package:medibuk/domain/entities/user_profile.dart';
import 'package:medibuk/presentation/utils/roles.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  requiresRoleSelection,
}

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final InitialLoginData? roleSelectionData;
  final UserProfile? userProfile;
  final String? username;
  final String? initialToken;

  AuthState({
    required this.status,
    this.errorMessage,
    this.roleSelectionData,
    this.userProfile,
    this.username,
    this.initialToken,
  });

  factory AuthState.initial() => AuthState(status: AuthStatus.initial);
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(AuthState.initial()) {
    _checkInitialStatus();
  }

  Future<void> _checkInitialStatus() async {
    final token = await _authRepository.getToken();
    if (token != null) {
      final profile = await _authRepository.getUserProfile();
      state = AuthState(status: AuthStatus.authenticated, userProfile: profile);
    } else {
      state = AuthState(status: AuthStatus.unauthenticated);
    }
  }

  // *** PERBAIKAN 2: Ubah total logika login ***
  Future<void> login(String username, String password) async {
    state = AuthState(status: AuthStatus.loading);
    try {
      final initialLoginData = await _authRepository.requestInitialLogin(
        username,
        password,
      );
      final initialToken = initialLoginData.token;

      final savedProfile = await _authRepository.getUserProfile();

      if (savedProfile != null) {
        final availableRoles = await _authRepository.getRoles(
          savedProfile.client.id,
          initialToken,
        );
        final isRoleStillValid = availableRoles.any(
          (role) => role.id == savedProfile.role.id,
        );

        if (isRoleStillValid) {
          await _authRepository.requestFinalTokenAndSaveProfile(
            username: savedProfile.username,
            client: savedProfile.client,
            role: savedProfile.role,
            organization: savedProfile.organization,
            warehouse: savedProfile.warehouse,
            initialToken: initialToken,
          );
          final profile = await _authRepository.getUserProfile();
          state = AuthState(
            status: AuthStatus.authenticated,
            userProfile: profile,
          );
          return;
        } else {
          await _authRepository.clearUserProfile();
        }
      }

      // Langkah 4B: Jika tidak ada profil atau role tidak valid, tampilkan halaman pilih peran
      state = AuthState(
        status: AuthStatus.requiresRoleSelection,
        roleSelectionData: initialLoginData,
        username: username,
        initialToken: initialToken,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.unauthenticated,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectRoleAndLogin({
    required RoleSelectionItem client,
    required RoleSelectionItem role,
    required RoleSelectionItem organization,
    required RoleSelectionItem warehouse,
  }) async {
    state = AuthState(
      status: AuthStatus.loading,
      roleSelectionData: state.roleSelectionData,
      username: state.username,
      initialToken: state.initialToken,
    );
    try {
      await _authRepository.requestFinalTokenAndSaveProfile(
        username: state.username!,
        client: client,
        role: role,
        organization: organization,
        warehouse: warehouse,
        initialToken: state.initialToken!,
      );

      final profile = await _authRepository.getUserProfile();
      state = AuthState(status: AuthStatus.authenticated, userProfile: profile);
    } catch (e) {
      state = AuthState(
        status: AuthStatus.requiresRoleSelection,
        roleSelectionData: state.roleSelectionData,
        username: state.username,
        initialToken: state.initialToken,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> changeRole() async {
    final savedClients = await _authRepository.getSavedClients();
    final currentProfile = await _authRepository.getUserProfile();
    final initialToken = await _authRepository.getInitialToken();

    if (savedClients.isNotEmpty &&
        currentProfile != null &&
        initialToken != null) {
      state = AuthState(
        status: AuthStatus.requiresRoleSelection,
        roleSelectionData: InitialLoginData(
          token: initialToken,
          clients: savedClients,
        ),
        username: currentProfile.username,
        initialToken: initialToken,
      );
    } else {
      logout();
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = AuthState(status: AuthStatus.unauthenticated);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

final currentUserRoleProvider = Provider<Role>((ref) {
  final authState = ref.watch(authProvider);

  final roleName = authState.userProfile?.role.name;

  if (roleName != null) {
    return getRoleFromString(roleName);
  }

  return Role.notSelected;
});
