import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/medical_record.dart';

abstract class MedicalRecordRepository {
  Future<MedicalRecord> getMedicalRecord(String id);
  Future<MedicalRecord> updateMedicalRecord(MedicalRecord record);
  Future<List<GeneralInfo>> getGeneralInfoOptions(String modelName);
}

class MedicalRecordRepositoryImpl implements MedicalRecordRepository {
  @override
  Future<MedicalRecord> getMedicalRecord(String id) async {
    // Simulate API call by loading from assets
    final jsonString = await rootBundle.loadString(
      'assets/data/medrec.sample.json',
    );
    final jsonData = json.decode(jsonString);
    return MedicalRecord.fromJson(jsonData);
  }

  @override
  Future<MedicalRecord> updateMedicalRecord(MedicalRecord record) async {
    // Simulate API update
    await Future.delayed(const Duration(milliseconds: 500));
    return record;
  }

  @override
  Future<List<GeneralInfo>> getGeneralInfoOptions(String modelName) async {
    // Mock data for different model types
    await Future.delayed(const Duration(milliseconds: 300));

    switch (modelName) {
      case 'c_bpartner':
        return [
          const GeneralInfo(
            propertyLabel: 'Doctor',
            id: 1000024,
            identifier: 'dr. Hasni Kemala Sari, Sp.OG',
            modelName: 'c_bpartner',
          ),
          const GeneralInfo(
            propertyLabel: 'Doctor',
            id: 1000025,
            identifier: 'dr. Ahmad Fauzi, Sp.OG',
            modelName: 'c_bpartner',
          ),
        ];
      case 'm_specialist':
        return [
          const GeneralInfo(
            propertyLabel: 'Specialist',
            id: 1000000,
            identifier: 'KANDUNGAN PALEM SEMI',
            modelName: 'm_specialist',
          ),
          const GeneralInfo(
            propertyLabel: 'Specialist',
            id: 1000001,
            identifier: 'GINEKOLOGI PALEM SEMI',
            modelName: 'm_specialist',
          ),
        ];
      case 'c_salesregion':
        return [
          const GeneralInfo(
            propertyLabel: 'Clinic',
            id: 1000012,
            identifier: 'Kehamilan Sehat Palem Semi',
            modelName: 'c_salesregion',
          ),
          const GeneralInfo(
            propertyLabel: 'Clinic',
            id: 1000013,
            identifier: 'Kehamilan Sehat Jakarta Pusat',
            modelName: 'c_salesregion',
          ),
        ];
      case 'm_product':
        return [
          const GeneralInfo(
            propertyLabel: 'Product',
            id: 1000824,
            identifier: 'ALCOHOL 70%',
            modelName: 'm_product',
          ),
          const GeneralInfo(
            propertyLabel: 'Product',
            id: 1000323,
            identifier: 'CAL95',
            modelName: 'm_product',
          ),
        ];
      default:
        return [];
    }
  }
}
