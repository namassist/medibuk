import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/api/api_client.dart';
import 'package:medibuk/domain/entities/warehouse_record.dart';
import 'package:medibuk/presentation/providers/api_client_provider.dart';

final warehouseRepositoryProvider = Provider((ref) {
  return WarehouseRepository(ref.watch(apiClientProvider));
});

class WarehouseRepository {
  final ApiClient _apiClient;

  WarehouseRepository(this._apiClient);

  Future<GeneralInfo?> getSalesRegion(int warehouseId) async {
    try {
      final response = await _apiClient.get('/models/M_Warehouse/$warehouseId');

      final warehouseRecord = WarehouseRecord.fromJson(response.data);

      return warehouseRecord.cSalesRegion;
    } catch (e) {
      rethrow;
    }
  }
}
