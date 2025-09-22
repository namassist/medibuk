// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceRecord _$ServiceRecordFromJson(
  Map<String, dynamic> json,
) => ServiceRecord(
  id: (json['id'] as num).toInt(),
  uid: json['uid'] as String,
  adClientId: json['AD_Client_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Client_ID'] as Map<String, dynamic>),
  adOrgId: json['AD_Org_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Org_ID'] as Map<String, dynamic>),
  cMedicalRecordId: json['C_MedicalRecord_ID'] == null
      ? null
      : GeneralInfo.fromJson(
          json['C_MedicalRecord_ID'] as Map<String, dynamic>,
        ),
  cSalesRegionId: json['C_SalesRegion_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_SalesRegion_ID'] as Map<String, dynamic>),
  doctorId: json['Doctor_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['Doctor_ID'] as Map<String, dynamic>),
  assistantId: json['Assistant_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['Assistant_ID'] as Map<String, dynamic>),
  lineNo: (json['LineNo'] as num?)?.toInt(),
  birthday: json['Birthday'] as String?,
  age: json['Age'] as String?,
  gpa: json['GPA'] as String?,
  visitDate: json['VisitDate'] as String?,
  nextVisitDate: json['NextVisitDate'] as String?,
  chiefComplaint: json['ChiefComplaint'] as String?,
  bodyTemperature: json['BodyTemperature'] as num?,
  miscarriage: (json['Miscarriage'] as num?)?.toInt(),
  pregnancyNo: (json['PregnancyNo'] as num?)?.toInt(),
  firstDayOfMenstrualPeriod: json['FirstDayOfMenstrualPeriod'] as String?,
  riwayatAlergi: json['Riwayat_alergi'] as String?,
  hpl: json['HPL'] as String?,
  estimatedDateOfConception: json['EstimatedDateOfConception'] as String?,
  laborSC: json['LaborSC'] as num?,
  laborSpontanNormal: json['LaborSpontanNormal'] as num?,
  laborSpontanVacuum: json['LaborSpontanVacuum'] as num?,
  bodyHeight: json['BodyHeight'] as num?,
  bmi: json['BMI'] as num?,
  bodyWeight: json['BodyWeight'] as num?,
  systolicPressure: json['SystolicPressure'] as num?,
  diastolicPressure: json['DiastolicPressure'] as num?,
  lila: json['LILA'] as num?,
  icd10: json['ICD_10'] == null
      ? null
      : GeneralInfo.fromJson(json['ICD_10'] as Map<String, dynamic>),
  note: json['Note'] as String?,
  internalNote: json['InternalNote'] as String?,
  isShowMore: json['IsShowMore'] as bool?,
  nutritionNotes: json['NutritionNotes'] as String?,
  presentation: json['Presentation'] == null
      ? null
      : GeneralInfo.fromJson(json['Presentation'] as Map<String, dynamic>),
  placentaGrade: json['PlacentaGrade'] as num?,
  placentaPosition: json['PlacentaPosition'] == null
      ? null
      : GeneralInfo.fromJson(json['PlacentaPosition'] as Map<String, dynamic>),
  weight: json['Weight'] as num?,
  gs: json['GS'] as num?,
  ys: json['YS'] as num?,
  djj: json['DJJ'] as num?,
  fl: json['FL'] as num?,
  crl: json['CRL'] as num?,
  bpd: json['BPD'] as num?,
  hc: json['HC'] as num?,
  ac: json['AC'] as num?,
  gender: json['Gender'] == null
      ? null
      : GeneralInfo.fromJson(json['Gender'] as Map<String, dynamic>),
  sdp: json['SDP'] as num?,
  afi: json['AFI'] as num?,
  cairanKetuban: json['Cairan_Ketuban'] == null
      ? null
      : GeneralInfo.fromJson(json['Cairan_Ketuban'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ServiceRecordToJson(ServiceRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'AD_Client_ID': instance.adClientId,
      'AD_Org_ID': instance.adOrgId,
      'C_MedicalRecord_ID': instance.cMedicalRecordId,
      'C_SalesRegion_ID': instance.cSalesRegionId,
      'Doctor_ID': instance.doctorId,
      'Assistant_ID': instance.assistantId,
      'LineNo': instance.lineNo,
      'Birthday': instance.birthday,
      'Age': instance.age,
      'GPA': instance.gpa,
      'VisitDate': instance.visitDate,
      'NextVisitDate': instance.nextVisitDate,
      'ChiefComplaint': instance.chiefComplaint,
      'BodyTemperature': instance.bodyTemperature,
      'Miscarriage': instance.miscarriage,
      'PregnancyNo': instance.pregnancyNo,
      'FirstDayOfMenstrualPeriod': instance.firstDayOfMenstrualPeriod,
      'Riwayat_alergi': instance.riwayatAlergi,
      'HPL': instance.hpl,
      'EstimatedDateOfConception': instance.estimatedDateOfConception,
      'LaborSC': instance.laborSC,
      'LaborSpontanNormal': instance.laborSpontanNormal,
      'LaborSpontanVacuum': instance.laborSpontanVacuum,
      'BodyHeight': instance.bodyHeight,
      'BMI': instance.bmi,
      'BodyWeight': instance.bodyWeight,
      'SystolicPressure': instance.systolicPressure,
      'DiastolicPressure': instance.diastolicPressure,
      'LILA': instance.lila,
      'ICD_10': instance.icd10,
      'Note': instance.note,
      'InternalNote': instance.internalNote,
      'IsShowMore': instance.isShowMore,
      'NutritionNotes': instance.nutritionNotes,
      'Presentation': instance.presentation,
      'PlacentaGrade': instance.placentaGrade,
      'PlacentaPosition': instance.placentaPosition,
      'Weight': instance.weight,
      'GS': instance.gs,
      'YS': instance.ys,
      'DJJ': instance.djj,
      'FL': instance.fl,
      'CRL': instance.crl,
      'BPD': instance.bpd,
      'HC': instance.hc,
      'AC': instance.ac,
      'Gender': instance.gender,
      'SDP': instance.sdp,
      'AFI': instance.afi,
      'Cairan_Ketuban': instance.cairanKetuban,
    };
