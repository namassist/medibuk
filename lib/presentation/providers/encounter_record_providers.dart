import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:medibuk/data/repositories/encounter_repository.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';

part 'encounter_record_providers.g.dart';

@riverpod
class EncounterNotifier extends _$EncounterNotifier {
  @override
  Future<EncounterRecord?> build(String encounterId) async {
    if (encounterId == 'NEW') {
      return EncounterRecord.empty();
    }

    if (encounterId.isEmpty) return null;

    final repository = ref.read(encounterRepositoryProvider);
    try {
      return await repository.getEncounterRecord(encounterId);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateRecord(EncounterRecord record) async {
    final repository = ref.read(encounterRepositoryProvider);
    final previousState = state;
    state = AsyncValue.data(record);
    try {
      await repository.updateEncounterRecord(record);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }
}
