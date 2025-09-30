// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encounter_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncounterRecord _$EncounterRecordFromJson(
  Map<String, dynamic> json,
) => EncounterRecord(
  id: (json['id'] as num).toInt(),
  uid: json['uid'] as String,
  adClientId: json['AD_Client_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Client_ID'] as Map<String, dynamic>),
  adOrgId: json['AD_Org_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Org_ID'] as Map<String, dynamic>),
  cDocTypeId: json['C_DocType_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_DocType_ID'] as Map<String, dynamic>),
  documentNo: json['DocumentNo'] as String,
  dateTrx: json['DateTrx'] as String,
  antrian: json['Antrian'] as String?,
  cBPartnerId: json['C_BPartner_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_BPartner_ID'] as Map<String, dynamic>),
  cBPartnerRelationID: json['C_BPartnerRelation_ID'] == null
      ? null
      : GeneralInfo.fromJson(
          json['C_BPartnerRelation_ID'] as Map<String, dynamic>,
        ),
  birthday: json['Birthday'] as String?,
  cSalesRegionId: json['C_SalesRegion_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_SalesRegion_ID'] as Map<String, dynamic>),
  mSpecialistId: json['M_Specialist_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['M_Specialist_ID'] as Map<String, dynamic>),
  doctorId: json['Doctor_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['Doctor_ID'] as Map<String, dynamic>),
  assistantId: json['Assistant_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['Assistant_ID'] as Map<String, dynamic>),
  info: json['Info'] as String?,
  cEncounterScheduleID: json['C_EncounterSchedule_ID'] == null
      ? null
      : GeneralInfo.fromJson(
          json['C_EncounterSchedule_ID'] as Map<String, dynamic>,
        ),
  systolicPressure: json['SystolicPressure'] as num?,
  diastolicPressure: json['DiastolicPressure'] as num?,
  bodyWeight: json['BodyWeight'] as num?,
  bodyHeight: json['BodyHeight'] as num?,
  bodyTemperature: json['BodyTemperature'] as num?,
  birthWeight: json['BirthWeight'] as num?,
  firstDayOfMenstrualPeriod: json['FirstDayOfMenstrualPeriod'] as String?,
  headCircumference: json['head_circumference'] as num?,
  pregnancyNo: (json['PregnancyNo'] as num?)?.toInt(),
  miscarriage: (json['Miscarriage'] as num?)?.toInt(),
  laborSpontanNormal: (json['LaborSpontanNormal'] as num?)?.toInt(),
  laborSC: (json['LaborSC'] as num?)?.toInt(),
  laborSpontanForcep: (json['LaborSpontanForcep'] as num?)?.toInt(),
  laborSpontanVacuum: (json['LaborSpontanVacuum'] as num?)?.toInt(),
  docStatus: json['DocStatus'] == null
      ? null
      : GeneralInfo.fromJson(json['DocStatus'] as Map<String, dynamic>),
  amount: json['Amount'] as num?,
  lila: json['LILA'] as num?,
  isActive: json['IsActive'] as bool,
  processed: json['Processed'] as bool,
  isPaid: json['IsPaid'] as bool,
  discountAmt: json['DiscountAmt'] as num?,
  amtBeforeDisc: json['AmtBeforeDisc'] as num?,
  docAction: json['doc_action'] as String?,
  cOrderID: json['C_Order_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_Order_ID'] as Map<String, dynamic>),
  qaSourcesID: json['QA_Sources_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['QA_Sources_ID'] as Map<String, dynamic>),
  cMedicalRecordID: json['C_MedicalRecord_ID'] == null
      ? null
      : GeneralInfo.fromJson(
          json['C_MedicalRecord_ID'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$EncounterRecordToJson(EncounterRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'AD_Client_ID': instance.adClientId,
      'AD_Org_ID': instance.adOrgId,
      'C_DocType_ID': instance.cDocTypeId,
      'DocumentNo': instance.documentNo,
      'DateTrx': instance.dateTrx,
      'Antrian': instance.antrian,
      'C_BPartner_ID': instance.cBPartnerId,
      'C_BPartnerRelation_ID': instance.cBPartnerRelationID,
      'Birthday': instance.birthday,
      'C_SalesRegion_ID': instance.cSalesRegionId,
      'C_EncounterSchedule_ID': instance.cEncounterScheduleID,
      'C_MedicalRecord_ID': instance.cMedicalRecordID,
      'M_Specialist_ID': instance.mSpecialistId,
      'Doctor_ID': instance.doctorId,
      'Assistant_ID': instance.assistantId,
      'Info': instance.info,
      'SystolicPressure': instance.systolicPressure,
      'DiastolicPressure': instance.diastolicPressure,
      'BodyWeight': instance.bodyWeight,
      'BodyHeight': instance.bodyHeight,
      'BodyTemperature': instance.bodyTemperature,
      'BirthWeight': instance.birthWeight,
      'FirstDayOfMenstrualPeriod': instance.firstDayOfMenstrualPeriod,
      'head_circumference': instance.headCircumference,
      'PregnancyNo': instance.pregnancyNo,
      'Miscarriage': instance.miscarriage,
      'LaborSpontanNormal': instance.laborSpontanNormal,
      'LaborSC': instance.laborSC,
      'LaborSpontanForcep': instance.laborSpontanForcep,
      'LaborSpontanVacuum': instance.laborSpontanVacuum,
      'DocStatus': instance.docStatus,
      'Amount': instance.amount,
      'LILA': instance.lila,
      'IsActive': instance.isActive,
      'Processed': instance.processed,
      'IsPaid': instance.isPaid,
      'DiscountAmt': instance.discountAmt,
      'AmtBeforeDisc': instance.amtBeforeDisc,
      'doc_action': instance.docAction,
      'C_Order_ID': instance.cOrderID,
      'QA_Sources_ID': instance.qaSourcesID,
    };
