import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/medical_record_repository.dart';
import '../../domain/entities/medical_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'medical_record_providers.g.dart';

// 🎯 OPTIMIZATION 1: Repository as singleton to avoid recreation
@Riverpod(keepAlive: true)
MedicalRecordRepository medicalRecordRepository(
  MedicalRecordRepositoryRef ref,
) {
  return MedicalRecordRepositoryImpl();
}

// 🎯 OPTIMIZATION 2: Focused state management with better error handling
@riverpod
class OptimizedMedicalRecordNotifier extends _$OptimizedMedicalRecordNotifier {
  @override
  Future<MedicalRecord?> build(String medicalRecordId) async {
    final repository = ref.read(medicalRecordRepositoryProvider);

    try {
      return await repository.getMedicalRecord(medicalRecordId);
    } catch (e) {
      // Log error but don't rethrow to prevent UI breaking
      print('Error loading medical record: $e');
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

// 🎯 OPTIMIZATION 3: Cached dropdown options with keepAlive
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

// 🎯 OPTIMIZATION 4: Form modification state provider
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

// 🎯 OPTIMIZATION 5: Processed data cache to avoid repeated JSON serialization
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
