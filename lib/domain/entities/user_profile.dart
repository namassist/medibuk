import 'dart:convert';
import 'package:medibuk/domain/entities/auth_models.dart';

class UserProfile {
  final int userId;
  final String username;
  final RoleSelectionItem client;
  final RoleSelectionItem role;
  final RoleSelectionItem organization;
  final RoleSelectionItem warehouse;

  UserProfile({
    required this.userId,
    required this.username,
    required this.client,
    required this.role,
    required this.organization,
    required this.warehouse,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'client': {'id': client.id, 'name': client.name},
      'role': {'id': role.id, 'name': role.name},
      'organization': {'id': organization.id, 'name': organization.name},
      'warehouse': {'id': warehouse.id, 'name': warehouse.name},
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userId: map['userId'],
      username: map['username'],
      client: RoleSelectionItem(
        id: map['client']['id'],
        name: map['client']['name'],
      ),
      role: RoleSelectionItem(id: map['role']['id'], name: map['role']['name']),
      organization: RoleSelectionItem(
        id: map['organization']['id'],
        name: map['organization']['name'],
      ),
      warehouse: RoleSelectionItem(
        id: map['warehouse']['id'],
        name: map['warehouse']['name'],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source));
}
