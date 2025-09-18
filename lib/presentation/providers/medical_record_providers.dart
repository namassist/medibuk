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
      print('🔍 Loading medical record: $medicalRecordId');
      final record = await repository.getMedicalRecord(medicalRecordId);
      print('✅ Medical record loaded successfully: ${record.documentNo}');
      return record;
    } catch (e, stackTrace) {
      print('❌ Error loading medical record $medicalRecordId: $e');
      print('📋 Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> updateRecord(MedicalRecord record) async {
    final repository = ref.read(medicalRecordRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      print('💾 Updating medical record: ${record.documentNo}');
      final updatedRecord = await repository.updateMedicalRecord(record);
      print('✅ Medical record updated successfully');
      return updatedRecord;
    });
  }
}

@riverpod
class GeneralInfoOptionsNotifier extends _$GeneralInfoOptionsNotifier {
  @override
  Future<List<GeneralInfo>> build(String modelName) async {
    if (modelName.isEmpty) return [];

    final repository = ref.read(medicalRecordRepositoryProvider);
    try {
      print('🔍 Loading options for model: $modelName');
      final options = await repository.getGeneralInfoOptions(modelName);
      print('✅ Loaded ${options.length} options for $modelName');
      return options;
    } catch (e) {
      print('❌ Error loading options for $modelName: $e');
      return [];
    }
  }
}
