import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/api/api_client.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/domain/entities/icd10_info.dart';
import 'package:medibuk/domain/entities/product_info.dart';
import 'package:medibuk/domain/entities/reference_list_item.dart';
import 'package:medibuk/presentation/providers/api_client_provider.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';

abstract class SharedDataRepository {
  Future<List<GeneralInfo>> searchModelData({
    required String modelName,
    required String query,
    required String filter,
  });
  Future<List<ProductInfo>> searchProducts(String query);
  Future<List<GeneralInfo>> getReferenceList(String referenceId);
  Future<List<GeneralInfo>> searchIcd10(String query);
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
      case 'qa_sources':
        apiModelName = 'qa_sources';
        identifierKey = 'Name';
        break;
      default:
        return [];
    }

    String context = contextMap.entries
        .map((e) => '${e.key}:${e.value}')
        .join(',');

    final payload = <String, dynamic>{
      if (valRule.isNotEmpty) r'$valrule': valRule,
      if (query.isNotEmpty) r'$filter': "$identifierKey ilike '%$query%'",
      if (context.isNotEmpty) r'$context': context,
      if (apiModelName == 'qa_sources') r'$select': 'Name',
    };

    return _fetchFromApi(
      modelName: apiModelName,
      payload: payload,
      identifierKey: identifierKey,
    );
  }

  @override
  Future<List<GeneralInfo>> getReferenceList(String referenceId) async {
    try {
      final response = await _apiClient.get('/reference/$referenceId');

      if (response.data != null && response.data['reflist'] is List) {
        final list = response.data['reflist'] as List;

        return list
            .map((item) => ReferenceList.fromJson(item as Map<String, dynamic>))
            .map(
              (refItem) => GeneralInfo(
                id: refItem.value,
                identifier: refItem.name,
                modelName: 'ad_ref_list',
              ),
            )
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GeneralInfo>> searchIcd10(String query) async {
    try {
      final valuePattern = RegExp(r'^[a-zA-Z]\d');
      Map<String, dynamic> parameters;

      if (valuePattern.hasMatch(query)) {
        parameters = {'value': query};
      } else {
        parameters = {'name_idn': '%$query%'};
      }

      final response = await _apiClient.get(
        '/infos/icd-10-info',
        queryParams: {'\$parameters': jsonEncode(parameters)},
      );

      if (response.data != null &&
          response.data['infowindow-records'] is List) {
        final list = response.data['infowindow-records'] as List;

        return list
            .map((item) => Icd10Info.fromJson(item as Map<String, dynamic>))
            .map(
              (icdItem) => GeneralInfo(
                id: icdItem.id.toString(),
                identifier: '${icdItem.value} - ${icdItem.nameIdn}',
                propertyLabel: 'ICD_10',
                modelName: 'icd-10-info',
              ),
            )
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
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
