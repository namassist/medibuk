import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/api/api_client.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/domain/entities/product_info.dart';
import 'package:medibuk/presentation/providers/api_client_provider.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';

abstract class SharedDataRepository {
  Future<List<GeneralInfo>> searchModelData({
    required String modelName,
    required String query,
    required String filter,
  });

  Future<List<ProductInfo>> searchProducts(String query);
}

final sharedDataRepositoryProvider = Provider<SharedDataRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return SharedDataRepositoryImpl(apiClient, ref);
});

class SharedDataRepositoryImpl implements SharedDataRepository {
  final ApiClient _apiClient;
  final Ref _ref;

  SharedDataRepositoryImpl(this._apiClient, this._ref);


  @override
  Future<List<GeneralInfo>> searchModelData({
    required String modelName,
    required String query,
    required String filter,
  }) async {
    final userProfile = _ref.read(authProvider).userProfile;
    final adUserId = userProfile?.userId ?? 0;
    final adOrgId = userProfile?.organization.id ?? 0;

    

    if (modelName == 'c_doctype') {
      const doctypes = [
        GeneralInfo(
          propertyLabel: 'DocType',
          id: 1000049,
          identifier: 'Poli',
          modelName: 'c_doctype',
        ),
        GeneralInfo(
          propertyLabel: 'DocType',
          id: 1000047,
          identifier: 'Pharmacy',
          modelName: 'c_doctype',
        ),
      ];
      if (query.isEmpty) return doctypes;
      return doctypes
          .where(
            (dt) => dt.identifier.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }

    String apiModelName = '';
    String valRule = '';
    String identifierKey = 'Name';

    Map<String, dynamic> contextMap = {};

    switch (modelName) {
      case 'c_salesregion':
        apiModelName = 'C_SalesRegion';
        valRule = '1000031';
        contextMap['AD_User_ID'] = adUserId;
        contextMap['AD_Org_ID'] = adOrgId;
        break;
      case 'm_specialist':
        apiModelName = 'M_Specialist';
        valRule = '1000014';
        final parts = filter.isNotEmpty
            ? filter.split('=')
            : ['C_SalesRegion_ID', '0'];
        contextMap[parts[0]] = parts[1];
        break;
      case 'doctor':
        apiModelName = 'C_BPartner';
        valRule = '1000017';
        final parts = filter.isNotEmpty
            ? filter.split('=')
            : ['M_Specialist_ID', '0'];
        contextMap[parts[0]] = parts[1];
        break;
      case 'assistant':
        apiModelName = 'C_BPartner';
        valRule = '1000021';
        final parts = filter.isNotEmpty
            ? filter.split('=')
            : ['C_SalesRegion_ID', '0'];
        contextMap[parts[0]] = parts[1];
        break;
      case 'c_bpartner':
        apiModelName = 'C_BPartner';
        valRule = '1000020';
        break;
      case 'c_bpartnerrelation':
        apiModelName = 'C_BPartner';
        valRule = '1000020';
        break;
      default:
        return [];
    }

    String context = contextMap.entries
        .map((e) => '${e.key}:${e.value}')
        .join(',');

    final payload = <String, dynamic>{
      r'$valrule': valRule,
      if (query.isNotEmpty) r'$filter': "$identifierKey ilike '%$query%'",
      if (context.isNotEmpty) r'$context': context,
    };

    

    return _fetchFromApi(
      modelName: apiModelName,
      payload: payload,
      identifierKey: identifierKey,
    );
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

      if (response.data != null && response.data['records'] is List) {
        final records = response.data['records'] as List;
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
