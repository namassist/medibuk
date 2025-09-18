import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/medical_record_repository.dart';
import '../../domain/entities/medical_record.dart';

part 'medical_record_providers.g.dart';

@riverpod
MedicalRecordRepository medicalRecordRepository(
  MedicalRecordRepositoryRef ref,
) {
  return MedicalRecordRepositoryImpl();
}

@riverpod
class MedicalRecordNotifier extends _$MedicalRecordNotifier {
  @override
  Future<MedicalRecord?> build(String medicalRecordId) async {
    final repository = ref.read(medicalRecordRepositoryProvider);
    try {
      return await repository.getMedicalRecord(medicalRecordId);
    } catch (e) {
      // Log the error for debugging
      print('Error loading medical record $medicalRecordId: $e');
      rethrow; // Let the error propagate to show proper error state
    }
  }

  Future<void> updateRecord(MedicalRecord record) async {
    final repository = ref.read(medicalRecordRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await repository.updateMedicalRecord(record);
    });
  }
}

@riverpod
class GeneralInfoOptionsNotifier extends _$GeneralInfoOptionsNotifier {
  @override
  Future<List<GeneralInfo>> build(String modelName) async {
    if (modelName.isEmpty) return [];

    final repository = ref.read(medicalRecordRepositoryProvider);
    return await repository.getGeneralInfoOptions(modelName);
  }
}
