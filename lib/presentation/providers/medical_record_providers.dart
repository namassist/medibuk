import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/medical_record_repository.dart';
import '../../domain/entities/medical_record.dart';

part 'medical_record_providers.g.dart';

@Riverpod(keepAlive: true)
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
      // Log error but don't rethrow to prevent UI breaking
      return null;
    }
  }

  Future<void> updateRecord(MedicalRecord record) async {
    final repository = ref.read(medicalRecordRepositoryProvider);

    // Optimistic update - update state immediately
    final previousState = state;
    state = AsyncValue.data(record);

    try {
      final updatedRecord = await repository.updateMedicalRecord(record);
      state = AsyncValue.data(updatedRecord);
    } catch (e) {
      // Rollback on error
      state = previousState;
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
class CachedGeneralInfoOptions extends _$CachedGeneralInfoOptions {
  final Map<String, List<GeneralInfo>> _cache = {};

  @override
  Future<List<GeneralInfo>> build(String modelName) async {
    if (modelName.isEmpty) return [];

    // Return cached data if available
    if (_cache.containsKey(modelName)) {
      return _cache[modelName]!;
    }

    final repository = ref.read(medicalRecordRepositoryProvider);
    final options = await repository.getGeneralInfoOptions(modelName);

    // Cache the result
    _cache[modelName] = options;
    return options;
  }

  // Method to refresh specific model cache
  void refreshModel(String modelName) {
    _cache.remove(modelName);
    ref.invalidateSelf();
  }
}

@riverpod
class FormModificationNotifier extends _$FormModificationNotifier {
  @override
  bool build() => false;

  void setModified(bool isModified) {
    state = isModified;
  }

  void reset() {
    state = false;
  }
}

@riverpod
Map<String, dynamic> processedMainData(
  ProcessedMainDataRef ref,
  MedicalRecord record,
) {
  // This provider will only recompute when the record changes
  return {
    'DocumentNo': record.documentNo,
    'DateTrx': record.dateTrx,
    'GestationalAgeWeek': record.gestationalAgeWeek,
    'GestationalAgeDay': record.gestationalAgeDay,
    'AD_Client_ID': record.adClientId,
    'AD_Org_ID': record.adOrgId,
    'C_SalesRegion_ID': record.cSalesRegionId,
    'OrderType_ID': record.orderTypeId,
    'M_Specialist_ID': record.mSpecialistId,
    'C_BPartner_ID': record.cBPartnerId,
  };
}
