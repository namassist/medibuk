import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/api/api_client.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/domain/entities/product_info.dart';
import 'package:medibuk/presentation/providers/api_client_provider.dart';

abstract class SharedDataRepository {
  Future<List<GeneralInfo>> getGeneralInfoOptions(String modelName);
  Future<List<ProductInfo>> searchProducts(String query);
}

final sharedDataRepositoryProvider = Provider<SharedDataRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return SharedDataRepositoryImpl(apiClient);
});

class SharedDataRepositoryImpl implements SharedDataRepository {
  final ApiClient _apiClient;
  // Anda bisa menambahkan Dio di sini jika perlu, tapi lebih baik lewat ApiClient

  SharedDataRepositoryImpl(this._apiClient);

  @override
  Future<List<GeneralInfo>> getGeneralInfoOptions(String modelName) async {
    // Logika ini dipindahkan dari MedicalRecordRepositoryImpl
    if (modelName.toLowerCase().startsWith('ad_ref_list:')) {
      return _fetchAdRefList(modelName);
    }

    switch (modelName.toLowerCase()) {
      case 'c_bpartner':
        return [
          const GeneralInfo(
            propertyLabel: 'Doctor',
            id: 1000024,
            identifier: 'dr. Hasni Kemala Sari, Sp.OG',
            modelName: 'c_bpartner',
          ),
          const GeneralInfo(
            propertyLabel: 'Doctor',
            id: 1000025,
            identifier: 'dr. Ahmad Fauzi, Sp.OG',
            modelName: 'c_bpartner',
          ),
        ];
      case 'm_specialist':
        return [
          const GeneralInfo(
            propertyLabel: 'Specialist',
            id: 1000000,
            identifier: 'KANDUNGAN PALEM SEMI',
            modelName: 'm_specialist',
          ),
          const GeneralInfo(
            propertyLabel: 'Specialist',
            id: 1000001,
            identifier: 'GINEKOLOGI PALEM SEMI',
            modelName: 'm_specialist',
          ),
        ];
      // ... kasus lainnya
      default:
        return [];
    }
  }

  Future<List<GeneralInfo>> _fetchAdRefList(String modelName) async {
    // Implementasi _fetchAdRefList seperti sebelumnya
    // (Dapat menggunakan _apiClient jika sudah diimplementasikan di sana)
    return []; // Placeholder
  }

  @override
  Future<List<ProductInfo>> searchProducts(String query) async {
    if (query.isEmpty) return [];
    final parameters = json.encode({
      "name": "%${query.toLowerCase()}%",
      "M_WareHouse_ID": "1000013",
    });
    final records = await _apiClient.getNode('/infos/product-info', {
      'node': 'dev',
      r'$parameters': parameters,
      r'$order_by': 'QtyAvailable DESC',
    });
    return records.map((json) => ProductInfo.fromJson(json)).toList();
  }
}
