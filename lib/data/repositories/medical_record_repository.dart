import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/medical_record.dart';

abstract class MedicalRecordRepository {
  Future<MedicalRecord> getMedicalRecord(String id);
  Future<MedicalRecord> updateMedicalRecord(MedicalRecord record);
  Future<List<GeneralInfo>> getGeneralInfoOptions(String modelName);
}

class MedicalRecordRepositoryImpl implements MedicalRecordRepository {
  static const String _baseUrl = 'https://devkss.idempiereonline.com/api/v1';
  static const String _authToken =
      'eyJraWQiOiJpZGVtcGllcmUiLCJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJTdXBlckFuYWFtIiwiTV9XYXJlaG91c2VfSUQiOjEwMDAwMTMsIkFEX0xhbmd1YWdlIjoiZW5fVVMiLCJBRF9TZXNzaW9uX0lEIjoyMjI3NTk1LCJBRF9Vc2VyX0lEIjoxMDk5MDcxLCJBRF9Sb2xlX0lEIjoxMDAwMDE1LCJBRF9PcmdfSUQiOjEwMDAwMDEsImlzcyI6ImlkZW1waWVyZS5vcmciLCJBRF9DbGllbnRfSUQiOjEwMDAwMDAsImV4cCI6MTc1ODU0NTU3Mn0.ZW3oYQaBDA1Neowwc0FhUgVFPitF_LFRL_B2qP55e5mdVrBRTW-Sxqa0JlPFMNAVPjJZQBB1HpbylIlGqJXeuQ';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        'Authorization': 'Bearer $_authToken',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

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
    switch (modelName.toLowerCase()) {
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
      case 'ad_client':
        return const [
          GeneralInfo(
            propertyLabel: 'Client',
            id: 1000000,
            identifier: 'KSS Group',
            modelName: 'ad_client',
          ),
          GeneralInfo(
            propertyLabel: 'Client',
            id: 1000002,
            identifier: 'KSS Clinic Network',
            modelName: 'ad_client',
          ),
        ];
      case 'ad_org':
        return const [
          GeneralInfo(
            propertyLabel: 'Organization',
            id: 1000001,
            identifier: 'PT KEHAMILAN SEHAT SEJAHTERA',
            modelName: 'ad_org',
          ),
          GeneralInfo(
            propertyLabel: 'Organization',
            id: 1000003,
            identifier: 'PT KEHAMILAN SEHAT GROUP',
            modelName: 'ad_org',
          ),
        ];
      case 'ordertype':
        return const [
          GeneralInfo(
            propertyLabel: 'Order Type',
            id: 1000004,
            identifier: 'Kandungan',
            modelName: 'ordertype',
          ),
          GeneralInfo(
            propertyLabel: 'Order Type',
            id: 1000005,
            identifier: 'Gynecology',
            modelName: 'ordertype',
          ),
        ];
      case 'c_encounter':
        return const [
          GeneralInfo(
            propertyLabel: 'Encounter',
            id: 1305573,
            identifier: '1305573',
            modelName: 'c_encounter',
          ),
          GeneralInfo(
            propertyLabel: 'Encounter',
            id: 1305574,
            identifier: '1305574',
            modelName: 'c_encounter',
          ),
        ];
      case 'ad_ref_list:presentation':
      case 'ad_ref_list:placentaposition':
      case 'ad_ref_list:gender':
      case 'ad_ref_list:uterusposition':
      case 'ad_ref_list:ismedicationcompund':
      case 'ad_ref_list:birthcontrolmethod':
      case 'ad_ref_list:cairan_ketuban':
        return _fetchAdRefList(modelName);
      case 'icd_10':
        return const [
          GeneralInfo(
            propertyLabel: 'ICD 10',
            id: 'A00.9',
            identifier: 'Cholera, unspecified',
            modelName: 'icd_10',
          ),
          GeneralInfo(
            propertyLabel: 'ICD 10',
            id: 'A01.0',
            identifier: 'Typhoid fever',
            modelName: 'icd_10',
          ),
          GeneralInfo(
            propertyLabel: 'ICD 10',
            id: 'O80',
            identifier: 'Encounter for full-term uncomplicated delivery',
            modelName: 'icd_10',
          ),
        ];
      default:
        return [];
    }
  }

  Future<List<GeneralInfo>> _fetchAdRefList(String modelName) async {
    // Map field key to reference ID based on provided API list
    // modelName format: 'ad_ref_list:<FieldName>'
    final parts = modelName.split(':');
    if (parts.length != 2) return [];
    final fieldKey = parts[1].toLowerCase();

    final Map<String, int> fieldToRefId = {
      'birthcontrolmethod': 1000007,
      'uterusposition': 1000008,
      'presentation': 1000010,
      'placentaposition': 1000009,
      'gender': 1000005,
      'cairan_ketuban': 1000030,
      'tipe_pemeriksaan': 1000031,
    };

    final refId = fieldToRefId[fieldKey];
    if (refId == null) return [];

    try {
      final response = await _dio.get('/reference/$refId');
      final data = response.data as Map<String, dynamic>;
      final reflist = (data['reflist'] as List<dynamic>? ?? []);
      final label = _humanizeField(parts[1]);
      return reflist.map((e) {
        final item = (e as Map).cast<String, dynamic>();
        return GeneralInfo(
          propertyLabel: label,
          id: item['value'],
          identifier:
              item['name']?.toString() ?? item['value']?.toString() ?? '',
          modelName: 'ad_ref_list',
        );
      }).toList();
    } catch (_) {
      return [];
    }
  }

  String _humanizeField(String raw) {
    return raw
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (w) => w.isEmpty
              ? ''
              : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}',
        )
        .join(' ');
  }
}
