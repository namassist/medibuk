import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/repositories/warehouse_repository.dart';
import 'package:medibuk/domain/entities/warehouse_record.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';

final salesRegionProvider = FutureProvider<GeneralInfo?>((ref) async {
  final userProfile = ref.watch(authProvider).userProfile;

  if (userProfile != null) {
    final warehouseId = userProfile.warehouse.id;
    final warehouseRepository = ref.read(warehouseRepositoryProvider);

    final salesRegionInfo = await warehouseRepository.getSalesRegion(
      warehouseId,
    );
    return salesRegionInfo;
  }

  return null;
});
