// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laktasi_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaktasiRecord _$LaktasiRecordFromJson(Map<String, dynamic> json) =>
    LaktasiRecord(
      id: (json['id'] as num).toInt(),
      uid: json['uid'] as String,
      doctorID: json['Doctor_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['Doctor_ID'] as Map<String, dynamic>),
      cMedicalRecordID: json['C_MedicalRecord_ID'] == null
          ? null
          : GeneralInfo.fromJson(
              json['C_MedicalRecord_ID'] as Map<String, dynamic>,
            ),
      assistantID: json['Assistant_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['Assistant_ID'] as Map<String, dynamic>),
      cSalesRegionID: json['C_SalesRegion_ID'] == null
          ? null
          : GeneralInfo.fromJson(
              json['C_SalesRegion_ID'] as Map<String, dynamic>,
            ),
      visitDate: json['VisitDate'] == null
          ? null
          : DateTime.parse(json['VisitDate'] as String),
      child: json['C_BPartnerRelation_ID'] == null
          ? null
          : GeneralInfo.fromJson(
              json['C_BPartnerRelation_ID'] as Map<String, dynamic>,
            ),
      birthWeight: json['BirthWeight'] as num?,
      gender: json['Gender'] == null
          ? null
          : GeneralInfo.fromJson(json['Gender'] as Map<String, dynamic>),
      birthday: json['Birthday'] == null
          ? null
          : DateTime.parse(json['Birthday'] as String),
      diastolicPressureMother: json['DiastolicPressureMother'] as num?,
      bodyTemperatureMother: json['BodyTemperatureMother'] as num?,
      bodyWeightMother: json['BodyWeightMother'] as num?,
      systolicPressureMother: json['SystolicPressureMother'] as num?,
      icd10: json['ICD_10'] == null
          ? null
          : GeneralInfo.fromJson(json['ICD_10'] as Map<String, dynamic>),
      keluhanUtama: json['Keluhan_Utama'] as String?,
      scratched: json['scratched'] as bool?,
      breastMilk: json['BreastMilk'] as bool?,
      suckling: json['Suckling'] as bool?,
    );

Map<String, dynamic> _$LaktasiRecordToJson(LaktasiRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'Doctor_ID': instance.doctorID,
      'C_MedicalRecord_ID': instance.cMedicalRecordID,
      'Assistant_ID': instance.assistantID,
      'C_SalesRegion_ID': instance.cSalesRegionID,
      'VisitDate': instance.visitDate?.toIso8601String(),
      'C_BPartnerRelation_ID': instance.child,
      'BirthWeight': instance.birthWeight,
      'Gender': instance.gender,
      'Birthday': instance.birthday?.toIso8601String(),
      'DiastolicPressureMother': instance.diastolicPressureMother,
      'BodyTemperatureMother': instance.bodyTemperatureMother,
      'BodyWeightMother': instance.bodyWeightMother,
      'SystolicPressureMother': instance.systolicPressureMother,
      'ICD_10': instance.icd10,
      'Keluhan_Utama': instance.keluhanUtama,
      'scratched': instance.scratched,
      'BreastMilk': instance.breastMilk,
      'Suckling': instance.suckling,
    };
