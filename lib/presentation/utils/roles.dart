import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';

enum Role {
  key,
  bidan,
  admin,
  asisten,
  koordinatorK,
  koordinatorAA,
  notSelected,
}

const Map<Role, String> roleDescriptions = {
  Role.key: 'Key User',
  Role.bidan: 'Bidan',
  Role.admin: 'Admin Kasir',
  Role.asisten: 'Asisten Apoteker',
  Role.koordinatorK: 'Koordinator Klinik',
  Role.koordinatorAA: 'Koordinator Asisten Apoteker',
  Role.notSelected: 'Not Selected',
};

// Map untuk memetakan nama peran dari API (dalam huruf kecil) ke enum Role
const Map<String, Role> _roleMapping = {
  'nss admin (key user)': Role.key,
  'kss admin (key user)': Role.key,
  'sss admin (key user)': Role.key,
  'demo admin (key user)': Role.key,
  'kss group admin': Role.key,
  'admin kasir': Role.admin,
  'admin kasir nss': Role.admin,
  'admin kasir sss': Role.admin,
  'admin kasir demo': Role.admin,
  'bidan': Role.bidan,
  'bidan nss': Role.bidan,
  'bidan sss': Role.bidan,
  'bidan demo': Role.bidan,
  'asisten apoteker': Role.asisten,
  'asisten apoteker nss': Role.asisten,
  'asisten apoteker sss': Role.asisten,
  'asisten apoteker demo': Role.asisten,
  'koordinator klinik': Role.koordinatorK,
  'koordinator klinik nss': Role.koordinatorK,
  'koordinator klinik sss': Role.koordinatorK,
  'koordinator klinik demo': Role.koordinatorK,
  'koordinator asisten apoteker': Role.koordinatorAA,
  'koordinator asisten apoteker nss': Role.koordinatorAA,
  'koordinator asisten apoteker sss': Role.koordinatorAA,
  'koordinator asisten apoteker demo': Role.koordinatorAA,
};

/// Fungsi utilitas untuk mengubah nama peran dari String (API) menjadi enum Role.
///
/// Mengembalikan [Role] yang sesuai berdasarkan [roleName].
/// Jika tidak ada pemetaan yang ditemukan, akan mengembalikan [Role.not_selected].
Role getRoleFromString(String roleName) {
  // Ubah nama peran menjadi huruf kecil untuk pencocokan yang tidak sensitif terhadap huruf besar/kecil
  final normalizedRoleName = roleName.toLowerCase();
  return _roleMapping[normalizedRoleName] ?? Role.notSelected;
}

/// Memeriksa apakah peran pengguna saat ini termasuk dalam daftar peran yang diizinkan.
///
/// [ref] adalah WidgetRef dari widget Consumer.
/// [allowedRoles] adalah daftar `Role` yang diizinkan untuk melakukan aksi.
/// Mengembalikan `true` jika peran saat ini ada di dalam daftar, `false` jika tidak.
bool isRoles(WidgetRef ref, List<Role> allowedRoles) {
  // Dapatkan peran pengguna saat ini dari provider
  final currentRole = ref.watch(currentUserRoleProvider);
  // Periksa apakah peran saat ini ada di dalam daftar yang diizinkan
  return allowedRoles.contains(currentRole);
}
