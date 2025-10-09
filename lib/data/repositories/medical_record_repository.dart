import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/api/api_client.dart';
import 'package:medibuk/domain/entities/anak_record.dart';
import 'package:medibuk/domain/entities/laktasi_record.dart';
import 'package:medibuk/domain/entities/medical_record.dart';
import 'package:medibuk/presentation/providers/api_client_provider.dart';
import 'package:medibuk/presentation/utils/formatter.dart';

abstract class MedicalRecordRepository {
  Future<MedicalRecord> getMedicalRecord(String id);
  Future<MedicalRecord> updateMedicalRecord(MedicalRecord record);
  Future<void> deleteObstetricRecord(int id);
  Future<List<ObstetricRecord>> getObstetricHistory(int obstetricId);
  Future<List<GynecologyRecord>> getGynecologyHistory(int gynecologyId);
  Future<List<AnakRecord>> getAnakHistory(int anakId);
  Future<List<LaktasiRecord>> getLaktasiHistory(int anakId);
}

final medicalRecordRepositoryProvider = Provider<MedicalRecordRepository>((
  ref,
) {
  final apiClient = ref.watch(apiClientProvider);
  return MedicalRecordRepositoryImpl(apiClient);
});

class MedicalRecordRepositoryImpl implements MedicalRecordRepository {
  final ApiClient _apiClient;

  MedicalRecordRepositoryImpl(this._apiClient);

  @override
  Future<MedicalRecord> getMedicalRecord(String id) async {
    const String expandQuery =
        'gynecology,obstetric,medical-record-anak,prescriptions,services,icd-codes,dental,laktasi,medical-record-umum,andrologi';

    final response = await _apiClient.get(
      '/windows/medical-record/$id',
      queryParams: {r'$expand': expandQuery},
    );

    // -- DEBUG DITAMBAHKAN DISINI --
    // Mencetak seluruh data dari response API ke konsol debug.
    log('GET Medical Record Response: ${response.data}');
    // ----------------------------

    return MedicalRecord.fromJson(response.data);
  }

  @override
  Future<MedicalRecord> updateMedicalRecord(MedicalRecord record) async {
    final rawJson = record.toJson();
    final cleanedJson = removeNullValues(rawJson);

    // -- DEBUG DITAMBAHKAN DISINI --
    // Menggunakan JsonEncoder untuk format JSON yang lebih rapi (pretty print).
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String prettyPayload = encoder.convert(cleanedJson);
    log('UPDATE Medical Record Payload:\n$prettyPayload');
    // ----------------------------

    final response = await _apiClient.put(
      '/windows/medical-record/${record.id}',
      data: cleanedJson,
    );

    return MedicalRecord.fromJson(response.data);
  }

  @override
  Future<void> deleteObstetricRecord(int id) async {
    try {
      await _apiClient.delete('/windows/medical-record/tabs/obstetric/$id');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ObstetricRecord>> getObstetricHistory(int obstetricId) async {
    try {
      final response = await _apiClient.get(
        '/windows/medical-record/tabs/obstetric/$obstetricId/obstetric-history',
      );

      if (response.data != null && response.data['childtab-records'] is List) {
        final list = response.data['childtab-records'] as List;
        return list
            .map(
              (item) => ObstetricRecord.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GynecologyRecord>> getGynecologyHistory(int gynecologyId) async {
    try {
      final response = await _apiClient.get(
        '/windows/medical-record/tabs/gynecology/$gynecologyId/gynecology-history',
      );

      if (response.data != null && response.data['childtab-records'] is List) {
        final list = response.data['childtab-records'] as List;
        return list
            .map(
              (item) => GynecologyRecord.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AnakRecord>> getAnakHistory(int anakId) async {
    try {
      final response = await _apiClient.get(
        '/windows/medical-record/tabs/medical-record-anak/$anakId/anak-history',
      );

      if (response.data != null && response.data['childtab-records'] is List) {
        final list = response.data['childtab-records'] as List;
        return list
            .map((item) => AnakRecord.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LaktasiRecord>> getLaktasiHistory(int laktasiId) async {
    try {
      final response = await _apiClient.get(
        '/windows/medical-record/tabs/laktasi/$laktasiId/laktasi-history',
      );

      if (response.data != null && response.data['childtab-records'] is List) {
        final list = response.data['childtab-records'] as List;
        return list
            .map((item) => LaktasiRecord.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
