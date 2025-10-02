import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/repositories/warehouse_repository.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';

final salesRegionIdProvider = FutureProvider<int>((ref) async {
  final userProfile = ref.watch(authProvider).userProfile;

  if (userProfile != null) {
    final warehouseId = userProfile.warehouse.id;

    final warehouseRepository = ref.read(warehouseRepositoryProvider);
    final salesRegionId = await warehouseRepository.getSalesRegion(warehouseId);

    return salesRegionId;
  }

  throw Exception("User profile tidak ditemukan untuk mengambil sales region.");
});
