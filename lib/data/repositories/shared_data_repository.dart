import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/api/api_client.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/domain/entities/product_info.dart';
import 'package:medibuk/presentation/providers/api_client_provider.dart';
// Import the parameter class
import 'package:medibuk/presentation/providers/shared_providers.dart';

abstract class SharedDataRepository {
  Future<List<GeneralInfo>> getGeneralInfoOptions(
    GeneralInfoParameter parameter,
  );
  Future<List<ProductInfo>> searchProducts(String query);
}

final sharedDataRepositoryProvider = Provider<SharedDataRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return SharedDataRepositoryImpl(apiClient);
});

class SharedDataRepositoryImpl implements SharedDataRepository {
  final ApiClient _apiClient;

  SharedDataRepositoryImpl(this._apiClient);

  @override
  // *** PERBAIKAN 2: Ubah tipe parameter di sini juga ***
  Future<List<GeneralInfo>> getGeneralInfoOptions(
    GeneralInfoParameter parameter,
  ) async {
    final modelName = parameter.modelName;
    final dependencies = parameter.dependencies;

    switch (modelName) {
      case 'c_salesregion':
        return _fetchFromApi(
          modelName: 'C_SalesRegion',
          payload: {
            r'$context': 'AD_User_ID:1099071,AD_Org_ID:1000001',
            r'$valrule': '1000031',
          },
          identifierKey: 'Name',
        );
      case 'm_specialist':
        return _fetchFromApi(
          modelName: 'M_Specialist',
          payload: {
            r'$context': 'C_SalesRegion_ID:1000017',
            r'$valrule': '1000014',
          },
          identifierKey: 'Name',
        );
      case 'Doctor_ID':
        final specialistId = dependencies['M_Specialist_ID'];
        if (specialistId == null) return [];
        return _fetchFromApi(
          modelName: 'C_BPartner',
          payload: {
            r'$context': 'M_Specialist_ID:$specialistId',
            r'$valrule': '1000017',
          },
          identifierKey: 'Name',
        );
      case 'Assistant_ID':
        return _fetchFromApi(
          modelName: 'C_BPartner',
          payload: {
            r'$context': 'C_SalesRegion_ID:1000017',
            r'$valrule': '1000021',
          },
          identifierKey: 'Name',
        );
      default:
        return [];
    }
  }

  Future<List<GeneralInfo>> _fetchFromApi({
    required String modelName,
    required Map<String, dynamic> payload,
    required String identifierKey,
  }) async {
    try {
      final response = await _apiClient.get(
        '/models/$modelName',
        queryParams: payload,
      );

      if (response['records'] is List) {
        final records = response['records'] as List;
        return records.map((json) {
          return GeneralInfo(
            propertyLabel: modelName,
            id: json['id'],
            identifier: json[identifierKey] ?? 'Unknown',
            modelName: json['model-name'],
          );
        }).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductInfo>> searchProducts(String query) async {
    return [];
  }
}
