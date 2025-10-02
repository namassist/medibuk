import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/api/api_client.dart';
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
}

final businessPartnerRepositoryProvider = Provider((ref) {
  return BusinessPartnerRepository(ref.watch(apiClientProvider));
});

final businessPartnerProvider = FutureProvider.autoDispose
    .family<BusinessPartnerRecord, int>((ref, id) async {
      final repo = ref.watch(businessPartnerRepositoryProvider);
      return repo.getBusinessPartner(id);
    });
