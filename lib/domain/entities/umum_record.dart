import 'general_info.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medibuk/domain/entities/record.dart';

part 'umum_record.g.dart';

@JsonSerializable()
class UmumRecord extends Record {
  @JsonKey(name: 'AD_Client_ID')
  final GeneralInfo? adClientID;
  @JsonKey(name: 'AD_Org_ID')
  final GeneralInfo? adOrgID;
  @JsonKey(name: 'C_MedicalRecord_ID')
  final GeneralInfo? cMedicalRecordID;
  @JsonKey(name: 'C_SalesRegion_ID')
  final GeneralInfo? cSalesRegionID;
  @JsonKey(name: 'Doctor_ID')
  final GeneralInfo? doctorID;
  @JsonKey(name: 'Assistant_ID')
  final GeneralInfo? assistantID;
  @JsonKey(name: 'VisitDate')
  final DateTime? visitDate;
  @JsonKey(name: 'ICD_10')
  final GeneralInfo? icd10;
  @JsonKey(name: 'NextVisitDate')
  final DateTime? nextVisitDate;
  @JsonKey(name: 'Birthday')
  final DateTime? birthday;
  @JsonKey(name: 'Gender')
  final GeneralInfo? gender;
  @JsonKey(name: 'BodyWeight')
  final num? bodyWeight;
  @JsonKey(name: 'BodyHeight')
  final num? bodyHeight;
  @JsonKey(name: 'BodyTemperature')
  final num? bodyTemperature;
  @JsonKey(name: 'SystolicPressure')
  final num? systolicPressure;
  @JsonKey(name: 'DiastolicPressure')
  final num? diastolicPressure;
  @JsonKey(name: 'pulse')
  final String? pulse;
  @JsonKey(name: 'Tekanan_Darah')
  final num? tekananDarah;
  @JsonKey(name: 'Pernafasan')
  final num? pernafasan;
  @JsonKey(name: 'Keluhan_Utama')
  final String? keluhanUtama;
  @JsonKey(name: 'Riwayat_alergi')
  final String? riwayatAlergi;
  @JsonKey(name: 'Description')
  final String? description;
  @JsonKey(name: 'Diagnosis')
  final String? diagnosis;
  @JsonKey(name: 'Therapy')
  final String? therapy;
  @JsonKey(name: 'Processed')
  final bool? processed;
  @JsonKey(name: 'IsActive')
  final bool? isActive;
  @JsonKey(name: 'DocStatus')
  final GeneralInfo? docStatus;

  const UmumRecord({
    required super.id,
    required super.uid,
    this.adClientID,
    this.adOrgID,
    this.cMedicalRecordID,
    this.cSalesRegionID,
    this.doctorID,
    this.assistantID,
    this.visitDate,
    this.icd10,
    this.nextVisitDate,
    this.birthday,
    this.gender,
    this.bodyWeight,
    this.bodyHeight,
    this.bodyTemperature,
    this.systolicPressure,
    this.diastolicPressure,
    this.pulse,
    this.tekananDarah,
    this.pernafasan,
    this.keluhanUtama,
    this.riwayatAlergi,
    this.description,
    this.diagnosis,
    this.therapy,
    this.processed,
    this.isActive,
    this.docStatus,
    // lanjutkan
  });

  factory UmumRecord.fromJson(Map<String, dynamic> json) =>
      _$UmumRecordFromJson(json);

  Map<String, dynamic> toJson() => _$UmumRecordToJson(this);
}
