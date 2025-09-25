import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:medibuk/data/repositories/medical_record_repository.dart';
import 'package:medibuk/domain/entities/medical_record.dart';

part 'medical_record_providers.g.dart';

@riverpod
class MedicalRecordNotifier extends _$MedicalRecordNotifier {
  @override
  Future<MedicalRecord?> build(String medicalRecordId) async {
    if (medicalRecordId == 'NEW') {
      return MedicalRecord.empty();
    }
    final repository = ref.read(medicalRecordRepositoryProvider);
    try {
      return await repository.getMedicalRecord(medicalRecordId);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateRecord(MedicalRecord record) async {
    final repository = ref.read(medicalRecordRepositoryProvider);
    final previousState = state;
    state = AsyncValue.data(record);

    try {
      final updatedRecord = await repository.updateMedicalRecord(record);
      state = AsyncValue.data(updatedRecord);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }
}

@riverpod
Map<String, dynamic> processedMainData(Ref ref, MedicalRecord record) {
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
