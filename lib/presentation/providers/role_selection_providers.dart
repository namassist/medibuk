import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:medibuk/data/repositories/auth_repository.dart';
import 'package:medibuk/domain/entities/auth_models.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';

part 'role_selection_providers.g.dart';

@riverpod
Future<List<RoleSelectionItem>> roles(RolesRef ref, int clientId) async {
  final authState = ref.watch(authProvider);
  final initialToken = authState.initialToken;
  if (initialToken == null) return [];

  final authRepo = ref.read(authRepositoryProvider);
  return authRepo.getRoles(clientId, initialToken);
}

@riverpod
Future<List<RoleSelectionItem>> organizations(
  OrganizationsRef ref,
  int roleId,
) async {
  final authState = ref.watch(authProvider);
  final initialToken = authState.initialToken;
  final client = authState.roleSelectionData?.clients.first;
  if (initialToken == null || client == null) return [];

  final authRepo = ref.read(authRepositoryProvider);
  return authRepo.getOrganizations(client.id, roleId, initialToken);
}

@riverpod
Future<List<RoleSelectionItem>> warehouses(WarehousesRef ref, int orgId) async {
  final authState = ref.watch(authProvider);
  final initialToken = authState.initialToken;
  // Dependensi ini perlu kita dapatkan dari state UI, jadi kita akan handle di UI
  // Untuk sementara, kita asumsikan sudah ada.
  // Ini akan lebih baik ditangani di UI layer.
  return [];
}
