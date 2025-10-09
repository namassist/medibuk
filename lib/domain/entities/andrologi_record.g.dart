// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'andrologi_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AndrologiRecord _$AndrologiRecordFromJson(Map<String, dynamic> json) =>
    AndrologiRecord(
      id: (json['id'] as num).toInt(),
      uid: json['uid'] as String,
      adClientID: json['AD_Client_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['AD_Client_ID'] as Map<String, dynamic>),
      adOrgID: json['AD_Org_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['AD_Org_ID'] as Map<String, dynamic>),
      description: json['Description'] as String?,
      assistantID: json['Assistant_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['Assistant_ID'] as Map<String, dynamic>),
      birthday: json['Birthday'] == null
          ? null
          : DateTime.parse(json['Birthday'] as String),
      bodyHeight: json['BodyHeight'] as num?,
      bodyTemperature: json['BodyTemperature'] as num?,
      bodyWeight: json['BodyWeight'] as num?,
      cSalesRegionID: json['C_SalesRegion_ID'] == null
          ? null
          : GeneralInfo.fromJson(
              json['C_SalesRegion_ID'] as Map<String, dynamic>,
            ),
      diastolicPressure: json['DiastolicPressure'] as num?,
      doctorID: json['Doctor_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['Doctor_ID'] as Map<String, dynamic>),
      gender: json['Gender'] == null
          ? null
          : GeneralInfo.fromJson(json['Gender'] as Map<String, dynamic>),
      internalNote: json['InternalNote'] as String?,
      keluhanUtama: json['Keluhan_Utama'] as String?,
      nextVisitDate: json['NextVisitDate'] == null
          ? null
          : DateTime.parse(json['NextVisitDate'] as String),
      note: json['Note'] as String?,
      systolicPressure: json['SystolicPressure'] as num?,
      visitDate: json['VisitDate'] == null
          ? null
          : DateTime.parse(json['VisitDate'] as String),
      cMedicalRecordID: json['C_MedicalRecord_ID'] == null
          ? null
          : GeneralInfo.fromJson(
              json['C_MedicalRecord_ID'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AndrologiRecordToJson(AndrologiRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'AD_Client_ID': instance.adClientID,
      'AD_Org_ID': instance.adOrgID,
      'Description': instance.description,
      'Assistant_ID': instance.assistantID,
      'Birthday': instance.birthday?.toIso8601String(),
      'BodyHeight': instance.bodyHeight,
      'BodyTemperature': instance.bodyTemperature,
      'BodyWeight': instance.bodyWeight,
      'C_SalesRegion_ID': instance.cSalesRegionID,
      'DiastolicPressure': instance.diastolicPressure,
      'Doctor_ID': instance.doctorID,
      'Gender': instance.gender,
      'InternalNote': instance.internalNote,
      'Keluhan_Utama': instance.keluhanUtama,
      'NextVisitDate': instance.nextVisitDate?.toIso8601String(),
      'Note': instance.note,
      'SystolicPressure': instance.systolicPressure,
      'VisitDate': instance.visitDate?.toIso8601String(),
      'C_MedicalRecord_ID': instance.cMedicalRecordID,
    };
