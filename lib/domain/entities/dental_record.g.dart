// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dental_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DentalRecord _$DentalRecordFromJson(Map<String, dynamic> json) => DentalRecord(
  id: (json['id'] as num).toInt(),
  uid: json['uid'] as String,
  adClientId: json['AD_Client_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Client_ID'] as Map<String, dynamic>),
  adOrgId: json['AD_Org_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Org_ID'] as Map<String, dynamic>),
  cSalesRegionId: json['C_SalesRegion_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_SalesRegion_ID'] as Map<String, dynamic>),
  cMedicalRecordId: json['C_MedicalRecord_ID'] == null
      ? null
      : GeneralInfo.fromJson(
          json['C_MedicalRecord_ID'] as Map<String, dynamic>,
        ),
  doctorId: json['Doctor_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['Doctor_ID'] as Map<String, dynamic>),
  assistantId: json['Assistant_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['Assistant_ID'] as Map<String, dynamic>),
  visitDate: json['VisitDate'] as String?,
  nextVisitDate: json['NextVisitDate'] as String?,
  chiefComplaint: json['ChiefComplaint'] as String?,
  birthControlMethod: json['BirthControlMethod'] == null
      ? null
      : GeneralInfo.fromJson(
          json['BirthControlMethod'] as Map<String, dynamic>,
        ),
  bodyWeight: json['BodyWeight'] as num?,
  systolicPressure: json['SystolicPressure'] as num?,
  bodyHeight: json['BodyHeight'] as num?,
  bmi: json['BMI'] as num?,
  diastolicPressure: json['DiastolicPressure'] as num?,
  birthday: json['Birthday'] as String?,
  firstDayOfMenstrualPeriod: json['FirstDayOfMenstrualPeriod'] as String?,
  icd10: json['ICD_10'] == null
      ? null
      : GeneralInfo.fromJson(json['ICD_10'] as Map<String, dynamic>),
  internalNote: json['InternalNote'] as String?,
  note: json['Note'] as String?,
  isShowMore: json['IsShowMore'] as bool?,
  nutritionNotes: json['NutritionNotes'] as String?,
  uterusNote: json['UterusNote'] as String?,
  uterusLength: json['UterusLength'] as num?,
  uterusWidth: json['UterusWidth'] as num?,
  uterusThickness: json['UterusThickness'] as num?,
  uterusPosition: json['UterusPosition'] == null
      ? null
      : GeneralInfo.fromJson(json['UterusPosition'] as Map<String, dynamic>),
  endometriumThickness: json['EndometriumThickness'] as num?,
  rightOvaryFollicleCount: json['RightOvaryFollicleCount'] as num?,
  rightOvaryNote: json['RightOvaryNote'] as String?,
  rightOvaryLength: json['RightOvaryLength'] as num?,
  rightOvaryThickness: json['RightOvaryThickness'] as num?,
  rightOvaryWidth: json['RightOvaryWidth'] as num?,
  leftOvaryFollicleCount: json['LeftOvaryFollicleCount'] as num?,
  leftOvaryNote: json['LeftOvaryNote'] as String?,
  leftOvaryLength: json['LeftOvaryLength'] as num?,
  leftOvaryThickness: json['LeftOvaryThickness'] as num?,
  leftOvaryWidth: json['LeftOvaryWidth'] as num?,
);

Map<String, dynamic> _$DentalRecordToJson(DentalRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'AD_Client_ID': instance.adClientId,
      'AD_Org_ID': instance.adOrgId,
      'C_SalesRegion_ID': instance.cSalesRegionId,
      'C_MedicalRecord_ID': instance.cMedicalRecordId,
      'Doctor_ID': instance.doctorId,
      'Assistant_ID': instance.assistantId,
      'VisitDate': instance.visitDate,
      'NextVisitDate': instance.nextVisitDate,
      'ChiefComplaint': instance.chiefComplaint,
      'BirthControlMethod': instance.birthControlMethod,
      'BodyWeight': instance.bodyWeight,
      'SystolicPressure': instance.systolicPressure,
      'BodyHeight': instance.bodyHeight,
      'BMI': instance.bmi,
      'DiastolicPressure': instance.diastolicPressure,
      'Birthday': instance.birthday,
      'FirstDayOfMenstrualPeriod': instance.firstDayOfMenstrualPeriod,
      'ICD_10': instance.icd10,
      'InternalNote': instance.internalNote,
      'Note': instance.note,
      'IsShowMore': instance.isShowMore,
      'NutritionNotes': instance.nutritionNotes,
      'UterusNote': instance.uterusNote,
      'UterusLength': instance.uterusLength,
      'UterusWidth': instance.uterusWidth,
      'UterusThickness': instance.uterusThickness,
      'UterusPosition': instance.uterusPosition,
      'EndometriumThickness': instance.endometriumThickness,
      'RightOvaryFollicleCount': instance.rightOvaryFollicleCount,
      'RightOvaryNote': instance.rightOvaryNote,
      'RightOvaryLength': instance.rightOvaryLength,
      'RightOvaryThickness': instance.rightOvaryThickness,
      'RightOvaryWidth': instance.rightOvaryWidth,
      'LeftOvaryFollicleCount': instance.leftOvaryFollicleCount,
      'LeftOvaryNote': instance.leftOvaryNote,
      'LeftOvaryLength': instance.leftOvaryLength,
      'LeftOvaryThickness': instance.leftOvaryThickness,
      'LeftOvaryWidth': instance.leftOvaryWidth,
    };
