// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anak_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnakRecord _$AnakRecordFromJson(Map<String, dynamic> json) => AnakRecord(
  id: (json['id'] as num).toInt(),
  uid: json['uid'] as String,
  adClientID: json['AD_Client_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Client_ID'] as Map<String, dynamic>),
  adOrgID: json['AD_Org_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Org_ID'] as Map<String, dynamic>),
  cSalesRegionID: json['C_SalesRegion_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_SalesRegion_ID'] as Map<String, dynamic>),
  cMedicalRecordID: json['C_MedicalRecord_ID'] == null
      ? null
      : GeneralInfo.fromJson(
          json['C_MedicalRecord_ID'] as Map<String, dynamic>,
        ),
  doctorID: json['Doctor_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['Doctor_ID'] as Map<String, dynamic>),
  assistantID: json['Assistant_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['Assistant_ID'] as Map<String, dynamic>),
  visitDate: json['VisitDate'] == null
      ? null
      : DateTime.parse(json['VisitDate'] as String),
  nextVisitDate: json['NextVisitDate'] == null
      ? null
      : DateTime.parse(json['NextVisitDate'] as String),
  birthday: json['Birthday'] == null
      ? null
      : DateTime.parse(json['Birthday'] as String),
  birthWeight: json['BirthWeight'] as num?,
  bodyWeight: json['BodyWeight'] as num?,
  bodyHeight: json['BodyHeight'] as num?,
  headCircumference: json['head_circumference'] as num?,
  bodyTemperature: json['BodyTemperature'] as num?,
  pernafasan: json['Pernafasan'] as num?,
  tekananDarah: json['Tekanan_Darah'] as num?,
  icd10: json['ICD_10'] == null
      ? null
      : GeneralInfo.fromJson(json['ICD_10'] as Map<String, dynamic>),
  keluhanUtama: json['Keluhan_Utama'] as String?,
  description: json['Description'] as String?,
  gender: json['Gender'] == null
      ? null
      : GeneralInfo.fromJson(json['Gender'] as Map<String, dynamic>),
  rtl: json['RTL'] as String?,
  processed: json['Processed'] as bool?,
);

Map<String, dynamic> _$AnakRecordToJson(AnakRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'AD_Client_ID': instance.adClientID,
      'AD_Org_ID': instance.adOrgID,
      'C_SalesRegion_ID': instance.cSalesRegionID,
      'C_MedicalRecord_ID': instance.cMedicalRecordID,
      'Doctor_ID': instance.doctorID,
      'Assistant_ID': instance.assistantID,
      'VisitDate': instance.visitDate?.toIso8601String(),
      'NextVisitDate': instance.nextVisitDate?.toIso8601String(),
      'Birthday': instance.birthday?.toIso8601String(),
      'BirthWeight': instance.birthWeight,
      'BodyWeight': instance.bodyWeight,
      'BodyHeight': instance.bodyHeight,
      'head_circumference': instance.headCircumference,
      'BodyTemperature': instance.bodyTemperature,
      'Pernafasan': instance.pernafasan,
      'Tekanan_Darah': instance.tekananDarah,
      'ICD_10': instance.icd10,
      'Keluhan_Utama': instance.keluhanUtama,
      'Description': instance.description,
      'Gender': instance.gender,
      'RTL': instance.rtl,
      'Processed': instance.processed,
    };
