import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medibuk/data/api/api_client.dart';
import 'package:medibuk/domain/entities/auth_models.dart';
import 'package:medibuk/domain/entities/user_profile.dart';
import 'package:medibuk/presentation/providers/api_client_provider.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(ref.watch(apiClientProvider));
});

class AuthRepository {
  final ApiClient _apiClient;
  final _storage = const FlutterSecureStorage();
  static const _initialTokenKey = 'initial_auth_token';
  static const _tokenKey = 'auth_token';
  static const _userProfileKey = 'user_profile';
  static const _clientListKey = 'client_list';

  AuthRepository(this._apiClient);

  Future<String?> getInitialToken() => _storage.read(key: _initialTokenKey);
  Future<String?> getToken() => _storage.read(key: _tokenKey);

  Future<void> setTemporaryToken(String token) =>
      _storage.write(key: _tokenKey, value: token);

  Future<InitialLoginData> requestInitialLogin(
    String username,
    String password,
  ) async {
    final response = await _apiClient.post(
      '/auth/tokens',
      data: {'userName': username, 'password': password},
    );
    final initialData = InitialLoginData.fromJson(response.data);
    await _storage.write(key: _initialTokenKey, value: initialData.token);

    final clientListJson = json.encode(
      initialData.clients.map((c) => {'id': c.id, 'name': c.name}).toList(),
    );
    await _storage.write(key: _clientListKey, value: clientListJson);

    return initialData;
  }

  Future<List<RoleSelectionItem>> getSavedClients() async {
    final jsonString = await _storage.read(key: _clientListKey);
    if (jsonString != null) {
      final list = json.decode(jsonString) as List;
      return list.map((i) => RoleSelectionItem.fromJson(i)).toList();
    }
    return [];
  }

  Future<List<RoleSelectionItem>> getRoles(int clientId, String token) async {
    final response = await _apiClient.get(
      '/auth/roles?client=$clientId',
      token: token,
    );
    var list = response.data['roles'] as List;
    return list.map((i) => RoleSelectionItem.fromJson(i)).toList();
  }

  Future<List<RoleSelectionItem>> getOrganizations(
    int clientId,
    int roleId,
    String token,
  ) async {
    final response = await _apiClient.get(
      '/auth/organizations?client=$clientId&role=$roleId',
      token: token,
    );
    var list = response.data['organizations'] as List;
    return list.map((i) => RoleSelectionItem.fromJson(i)).toList();
  }

  Future<List<RoleSelectionItem>> getWarehouses(
    int clientId,
    int roleId,
    int orgId,
    String token,
  ) async {
    final response = await _apiClient.get(
      '/auth/warehouses?client=$clientId&role=$roleId&organization=$orgId',
      token: token,
    );
    var list = response.data['warehouses'] as List;
    return list.map((i) => RoleSelectionItem.fromJson(i)).toList();
  }

  Future<void> requestFinalTokenAndSaveProfile({
    required String username,
    required RoleSelectionItem client,
    required RoleSelectionItem role,
    required RoleSelectionItem organization,
    required RoleSelectionItem warehouse,
    required String initialToken,
  }) async {
    final response = await _apiClient.put(
      '/auth/tokens',
      data: {
        "clientId": client.id,
        "roleId": role.id,
        "organizationId": organization.id,
        "warehouseId": warehouse.id,
        "language": "en_US",
      },
      token: initialToken,
    );
    final finalToken = response.data['token'];
    final userId = response.data['userId'];

    final userProfile = UserProfile(
      userId: userId,
      username: username,
      client: client,
      role: role,
      organization: organization,
      warehouse: warehouse,
    );

    await _storage.write(key: _tokenKey, value: finalToken);
    await _storage.write(key: _userProfileKey, value: userProfile.toJson());
  }

  Future<UserProfile?> getUserProfile() async {
    final jsonString = await _storage.read(key: _userProfileKey);
    if (jsonString != null) {
      return UserProfile.fromJson(jsonString);
    }
    return null;
  }

  Future<void> logout({bool withUserProfile = false}) async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _initialTokenKey);
    if (withUserProfile) await _storage.delete(key: _userProfileKey);
  }

  Future<void> clearUserProfile() async {
    await _storage.delete(key: _userProfileKey);
  }
}
