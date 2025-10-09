// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'umum_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UmumRecord _$UmumRecordFromJson(Map<String, dynamic> json) => UmumRecord(
  id: (json['id'] as num).toInt(),
  uid: json['uid'] as String,
  adClientID: json['AD_Client_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Client_ID'] as Map<String, dynamic>),
  adOrgID: json['AD_Org_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Org_ID'] as Map<String, dynamic>),
  cMedicalRecordID: json['C_MedicalRecord_ID'] == null
      ? null
      : GeneralInfo.fromJson(
          json['C_MedicalRecord_ID'] as Map<String, dynamic>,
        ),
  cSalesRegionID: json['C_SalesRegion_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_SalesRegion_ID'] as Map<String, dynamic>),
  doctorID: json['Doctor_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['Doctor_ID'] as Map<String, dynamic>),
  assistantID: json['Assistant_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['Assistant_ID'] as Map<String, dynamic>),
  visitDate: json['VisitDate'] == null
      ? null
      : DateTime.parse(json['VisitDate'] as String),
  icd10: json['ICD_10'] == null
      ? null
      : GeneralInfo.fromJson(json['ICD_10'] as Map<String, dynamic>),
  nextVisitDate: json['NextVisitDate'] == null
      ? null
      : DateTime.parse(json['NextVisitDate'] as String),
  birthday: json['Birthday'] == null
      ? null
      : DateTime.parse(json['Birthday'] as String),
  gender: json['Gender'] == null
      ? null
      : GeneralInfo.fromJson(json['Gender'] as Map<String, dynamic>),
  bodyWeight: json['BodyWeight'] as num?,
  bodyHeight: json['BodyHeight'] as num?,
  bodyTemperature: json['BodyTemperature'] as num?,
  systolicPressure: json['SystolicPressure'] as num?,
  diastolicPressure: json['DiastolicPressure'] as num?,
  pulse: json['pulse'] as String?,
  tekananDarah: json['Tekanan_Darah'] as num?,
  pernafasan: json['Pernafasan'] as num?,
  keluhanUtama: json['Keluhan_Utama'] as String?,
  riwayatAlergi: json['Riwayat_alergi'] as String?,
  description: json['Description'] as String?,
  diagnosis: json['Diagnosis'] as String?,
  therapy: json['Therapy'] as String?,
  processed: json['Processed'] as bool?,
  isActive: json['IsActive'] as bool?,
  docStatus: json['DocStatus'] == null
      ? null
      : GeneralInfo.fromJson(json['DocStatus'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UmumRecordToJson(UmumRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'AD_Client_ID': instance.adClientID,
      'AD_Org_ID': instance.adOrgID,
      'C_MedicalRecord_ID': instance.cMedicalRecordID,
      'C_SalesRegion_ID': instance.cSalesRegionID,
      'Doctor_ID': instance.doctorID,
      'Assistant_ID': instance.assistantID,
      'VisitDate': instance.visitDate?.toIso8601String(),
      'ICD_10': instance.icd10,
      'NextVisitDate': instance.nextVisitDate?.toIso8601String(),
      'Birthday': instance.birthday?.toIso8601String(),
      'Gender': instance.gender,
      'BodyWeight': instance.bodyWeight,
      'BodyHeight': instance.bodyHeight,
      'BodyTemperature': instance.bodyTemperature,
      'SystolicPressure': instance.systolicPressure,
      'DiastolicPressure': instance.diastolicPressure,
      'pulse': instance.pulse,
      'Tekanan_Darah': instance.tekananDarah,
      'Pernafasan': instance.pernafasan,
      'Keluhan_Utama': instance.keluhanUtama,
      'Riwayat_alergi': instance.riwayatAlergi,
      'Description': instance.description,
      'Diagnosis': instance.diagnosis,
      'Therapy': instance.therapy,
      'Processed': instance.processed,
      'IsActive': instance.isActive,
      'DocStatus': instance.docStatus,
    };
