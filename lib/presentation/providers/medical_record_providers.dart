import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:medibuk/data/repositories/medical_record_repository.dart';
import 'package:medibuk/data/repositories/shared_data_repository.dart'; // Import repo baru
import 'package:medibuk/domain/entities/medical_record.dart';

part 'medical_record_providers.g.dart';

@riverpod
class MedicalRecordNotifier extends _$MedicalRecordNotifier {
  @override
  Future<MedicalRecord?> build(String medicalRecordId) async {
    if (medicalRecordId == 'NEW') {
      return MedicalRecord.empty();
    }
    // Menggunakan provider repository yang sudah benar
    final repository = ref.read(medicalRecordRepositoryProvider);
    try {
      return await repository.getMedicalRecord(medicalRecordId);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateRecord(MedicalRecord record) async {
    // Menggunakan provider repository yang sudah benar
    final repository = ref.read(medicalRecordRepositoryProvider);
    final previousState = state;
    state = AsyncValue.data(record);

    try {
      // ERROR TERATASI: Metode ini sekarang ada di MedicalRecordRepository
      final updatedRecord = await repository.updateMedicalRecord(record);
      state = AsyncValue.data(updatedRecord);
    } catch (e) {
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

    if (_cache.containsKey(modelName)) {
      return _cache[modelName]!;
    }

    // Menggunakan sharedDataRepositoryProvider yang benar
    final repository = ref.read(sharedDataRepositoryProvider);
    // ERROR TERATASI: Metode ini sekarang ada di SharedDataRepository
    final options = await repository.getGeneralInfoOptions(modelName);

    _cache[modelName] = options;
    return options;
  }

  void refreshModel(String modelName) {
    _cache.remove(modelName);
    ref.invalidateSelf();
  }
}

@riverpod
Map<String, dynamic> processedMainData(Ref ref, MedicalRecord record) {
  // Provider ini tidak berubah dan tetap benar
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
