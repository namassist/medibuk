import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/api/api_client.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';
import 'package:medibuk/presentation/providers/api_client_provider.dart';

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
    // Menggunakan endpoint dari dokumentasi
    final jsonData = await _apiClient.get('/windows/encounter/$id');
    return EncounterRecord.fromJson(jsonData);
  }

  @override
  Future<void> updateEncounterRecord(EncounterRecord record) async {
    // Menggunakan metode PUT dengan data dari record
    await _apiClient.put(
      '/windows/encounter/${record.id}',
      data: record.toJson(),
    );
  }
}
