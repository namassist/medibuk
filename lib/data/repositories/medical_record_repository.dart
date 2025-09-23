import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:medibuk/domain/entities/product_info.dart';
import '../../domain/entities/medical_record.dart';

abstract class MedicalRecordRepository {
  Future<MedicalRecord> getMedicalRecord(String id);
  Future<MedicalRecord> updateMedicalRecord(MedicalRecord record);
  Future<List<GeneralInfo>> getGeneralInfoOptions(String modelName);
  Future<List<ProductInfo>> searchProducts(String query);
}

class MedicalRecordRepositoryImpl implements MedicalRecordRepository {
  static const String _baseUrl = 'https://devkss.idempiereonline.com/api/v1';
  static const String _authToken =
      'eyJraWQiOiJpZGVtcGllcmUiLCJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJTdXBlckFuYWFtIiwiTV9XYXJlaG91c2VfSUQiOjEwMDAwMTMsIkFEX0xhbmd1YWdlIjoiZW5fVVMiLCJBRF9TZXNzaW9uX0lEIjoyMjI4Mjc3LCJBRF9Vc2VyX0lEIjoxMDk5MDcxLCJBRF9Sb2xlX0lEIjoxMDAwMDE1LCJBRF9PcmdfSUQiOjEwMDAwMDEsImlzcyI6ImlkZW1waWVyZS5vcmciLCJBRF9DbGllbnRfSUQiOjEwMDAwMDAsImV4cCI6MTc1ODYyMDI4M30.JrX8egqArEdwpFXmINqNPKcYbPX31qNjhpK2NABnll0i1v71KNr5inow3UkwkmlVa9AV2KColGj6GXNvYx5wqg';

  static const String _nodeBaseUrl = 'https://medibook.medital.id/api';
  static const String _nodeAuthToken =
      'eyJraWQiOiJpZGVtcGllcmUiLCJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJTdXBlckFuYWFtIiwiTV9XYXJlaG91c2VfSUQiOjEwMDAwMTMsIkFEX0xhbmd1YWdlIjoiZW5fVVMiLCJBRF9TZXNzaW9uX0lEIjoyMjI4Mjc3LCJBRF9Vc2VyX0lEIjoxMDk5MDcxLCJBRF9Sb2xlX0lEIjoxMDAwMDE1LCJBRF9PcmdfSUQiOjEwMDAwMDEsImlzcyI6ImlkZW1waWVyZS5vcmciLCJBRF9DbGllbnRfSUQiOjEwMDAwMDAsImV4cCI6MTc1ODYyMDI4M30.JrX8egqArEdwpFXmINqNPKcYbPX31qNjhpK2NABnll0i1v71KNr5inow3UkwkmlVa9AV2KColGj6GXNvYx5wqg';

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

  final Dio _nodeDio = Dio(
    BaseOptions(
      baseUrl: _nodeBaseUrl,
      headers: {
        'Authorization': 'Bearer $_nodeAuthToken',
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
    // This logic determines whether to call the generic ad_ref_list fetcher
    // or handle other specific models.
    if (modelName.toLowerCase().startsWith('ad_ref_list:')) {
      return _fetchAdRefList(modelName);
    }

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
        // Return empty list for unhandled cases
        return [];
    }
  }

  Future<List<GeneralInfo>> _fetchAdRefList(String modelName) async {
    final parts = modelName.split(':');
    if (parts.length != 2) return [];
    final fieldKey = parts[1].toLowerCase();

    // Mapping from field name to its reference ID for the API endpoint
    final Map<String, int> fieldToRefId = {
      'birthcontrolmethod': 1000007,
      'uterusposition': 1000008,
      'presentation': 1000010,
      'placentaposition': 1000009,
      'gender': 1000005,
      'cairan_ketuban': 1000030,
      'tipe_pemeriksaan': 1000031, // Asumsi ID, sesuaikan jika perlu
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
    } catch (e) {
      // Handle potential errors, e.g., network issues
      // For now, return an empty list to prevent crashes
      return [];
    }
  }

  @override
  Future<List<ProductInfo>> searchProducts(String query) async {
    if (query.isEmpty) return [];
    try {
      // Sesuaikan parameter ini dengan kebutuhan production
      final parameters = json.encode({
        "name": "%${query.toLowerCase()}%",
        "category": null,
        "M_WareHouse_ID": "1000013",
        "mPriceListVersionId": null,
        "AD_Org_ID": "1000001",
      });

      final response = await _nodeDio.get(
        '/infos/product-info',
        queryParameters: {
          'node': 'dev',
          r'$parameters': parameters,
          r'$order_by': 'QtyAvailable DESC',
        },
      );
      final records = response.data['infowindow-records'] as List;
      return records.map((json) => ProductInfo.fromJson(json)).toList();
    } catch (e) {
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
