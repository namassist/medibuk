import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:medibuk/data/repositories/encounter_repository.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';

part 'encounter_record_providers.g.dart';

@riverpod
class EncounterNotifier extends _$EncounterNotifier {
  @override
  Future<EncounterRecord?> build(String encounterId) async {
    if (encounterId.isEmpty) return null;

    final repository = ref.read(encounterRepositoryProvider);
    try {
      return await repository.getEncounterRecord(encounterId);
    } catch (e) {
      return null;
    }
  }

  // TAMBAHKAN METODE INI
  Future<void> updateRecord(EncounterRecord record) async {
    final repository = ref.read(encounterRepositoryProvider);
    final previousState = state;
    state = AsyncValue.data(record); // Optimistic update

    try {
      await repository.updateEncounterRecord(record);
      // State sudah diupdate, jadi tidak perlu set lagi jika API tidak mengembalikan apa-apa
    } catch (e) {
      state = previousState; // Rollback jika gagal
      rethrow;
    }
  }
}
