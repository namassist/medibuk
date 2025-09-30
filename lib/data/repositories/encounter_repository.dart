import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/api/api_client.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';
import 'package:medibuk/presentation/providers/api_client_provider.dart';
import 'package:medibuk/presentation/utils/formatter.dart';

abstract class EncounterRepository {
  Future<EncounterRecord> getEncounterRecord(String id);
  Future<void> updateEncounterRecord(EncounterRecord record);
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
}
