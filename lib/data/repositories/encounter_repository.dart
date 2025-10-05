import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:medibuk/data/api/api_client.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';
import 'package:medibuk/domain/entities/paginated.dart';
import 'package:medibuk/presentation/providers/api_client_provider.dart';
import 'package:medibuk/presentation/utils/formatter.dart';

abstract class EncounterRepository {
  Future<EncounterRecord> getEncounterRecord(String id);
  Future<void> updateEncounterRecord(EncounterRecord record);
  Future<void> deleteEncounterRecord(String id);
  Future<Paginated<EncounterRecord>> getTodayEncounters({
    required int salesRegionId,
    int? bPartnerId,
  });
  Future<Paginated<EncounterRecord>> getTodayBidanEncounters({
    required int salesRegionId,
    String? date,
  });
  Future<bool> isNewPatientForQaSource(int bpartnerId);
}

final encounterRepositoryProvider = Provider<EncounterRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return EncounterRepositoryImpl(apiClient);
});

class EncounterRepositoryImpl implements EncounterRepository {
  final ApiClient _apiClient;

  EncounterRepositoryImpl(this._apiClient);

  @override
  Future<EncounterRecord> getEncounterRecord(String id) async {
    final response = await _apiClient.get('/windows/encounter/$id');
    return EncounterRecord.fromJson(response.data);
  }

  @override
  Future<void> updateEncounterRecord(EncounterRecord record) async {
    final rawJson = record.toJson();
    final cleanedJson = removeNullValues(rawJson);

    await _apiClient.put('/windows/encounter/${record.id}', data: cleanedJson);
  }

  @override
  Future<void> deleteEncounterRecord(String id) async {
    try {
      await _apiClient.delete('/windows/encounter/$id');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Paginated<EncounterRecord>> getTodayEncounters({
    required int salesRegionId,
    int? bPartnerId,
  }) async {
    try {
      String filter;

      if (bPartnerId != null) {
        filter = "C_BPartner_ID = $bPartnerId";
      } else {
        final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
        filter =
            "C_SalesRegion_ID = $salesRegionId AND DateTrx = '$today' and DocStatus != 'VO'";
      }

      final response = await _apiClient.get(
        '/windows/encounter',
        queryParams: {'\$filter': filter},
      );

      return Paginated.fromJson(
        response.data,
        (json) => EncounterRecord.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Paginated<EncounterRecord>> getTodayBidanEncounters({
    required int salesRegionId,
    String? date,
  }) async {
    try {
      final dateString =
          date ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
      final filter =
          "C_SalesRegion_ID = $salesRegionId AND DateTrx = '$dateString' and DocStatus != 'VO'";

      final response = await _apiClient.get(
        '/windows/encounter-bidan',
        queryParams: {'\$filter': filter},
      );

      return Paginated.fromJson(
        response.data,
        (json) => EncounterRecord.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isNewPatientForQaSource(int bpartnerId) async {
    try {
      final response = await _apiClient.get(
        '/models/c_encounter',
        queryParams: {
          r'$filter': 'C_BPartner_ID eq $bpartnerId AND QA_Sources_ID neq 0',
        },
      );

      if (response.data != null && response.data['row-count'] == 0) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
