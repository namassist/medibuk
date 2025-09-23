import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/api/api_client.dart';
import 'package:medibuk/domain/entities/medical_record.dart';
import 'package:medibuk/presentation/providers/api_client_provider.dart';

abstract class MedicalRecordRepository {
  Future<MedicalRecord> getMedicalRecord(String id);
  Future<MedicalRecord> updateMedicalRecord(MedicalRecord record);
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
    // Menambahkan query parameter $expand sesuai dokumentasi
    const String expandQuery =
        'gynecology,obstetric,medical-record-anak,prescriptions,services,icd-codes,dental,laktasi,medical-record-umum,andrologi';

    final jsonData = await _apiClient.get(
      '/windows/medical-record/$id',
      queryParams: {r'$expand': expandQuery},
    );
    return MedicalRecord.fromJson(jsonData);
  }

  @override
  Future<MedicalRecord> updateMedicalRecord(MedicalRecord record) async {
    await _apiClient.put(
      '/windows/medical-record/${record.id}',
      data: record.toJson(),
    );
    // API mungkin tidak mengembalikan record yang diperbarui, jadi kita kembalikan record lokal
    return record;
  }
}
