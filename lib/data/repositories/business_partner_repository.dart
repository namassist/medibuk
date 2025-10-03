import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/api/api_client.dart';
import 'package:medibuk/domain/entities/bpartner_info_record.dart';
import 'package:medibuk/domain/entities/business_partner_record.dart';
import 'package:medibuk/presentation/providers/api_client_provider.dart';

class BusinessPartnerRepository {
  final ApiClient _apiClient;
  BusinessPartnerRepository(this._apiClient);

  Future<BusinessPartnerRecord> getBusinessPartner(int id) async {
    final response = await _apiClient.get(
      '/models/C_BPartner/$id',
      queryParams: {'\$expand': 'AD_User,C_BPartner_Location'},
    );
    return BusinessPartnerRecord.fromJson(response.data);
  }

  Future<List<BusinessPartnerInfoRecord>> searchBusinessPartner({
    String? query,
    bool isCustomer = true,
  }) async {
    final Map<String, dynamic> internalParams = {
      'isCustomer': isCustomer ? 'Y' : 'N',
    };

    if (query != null && query.isNotEmpty) {
      final isNumeric = double.tryParse(query) != null;
      if (isNumeric) {
        internalParams['phone'] = '%$query%';
      } else {
        internalParams['name'] = '%${query.toUpperCase()}%';
      }
    }

    final jsonString = jsonEncode(internalParams);

    final finalQueryParams = {'\$parameters': jsonString};

    final response = await _apiClient.get(
      '/infos/business-partner-info',
      queryParams: finalQueryParams,
    );

    final List<dynamic> records = response.data['infowindow-records'] ?? [];
    return records
        .map(
          (json) =>
              BusinessPartnerInfoRecord.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }
}

final businessPartnerRepositoryProvider = Provider((ref) {
  return BusinessPartnerRepository(ref.watch(apiClientProvider));
});

final businessPartnerProvider = FutureProvider.autoDispose
    .family<BusinessPartnerRecord, int>((ref, id) async {
      final repo = ref.watch(businessPartnerRepositoryProvider);
      return repo.getBusinessPartner(id);
    });
