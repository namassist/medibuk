// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalRecord _$MedicalRecordFromJson(
  Map<String, dynamic> json,
) => MedicalRecord(
  id: (json['id'] as num).toInt(),
  uid: json['uid'] as String,
  documentNo: json['DocumentNo'] as String,
  dateTrx: json['DateTrx'] as String,
  docStatus: GeneralInfo.fromJson(json['DocStatus'] as Map<String, dynamic>),
  gestationalAgeWeek: (json['GestationalAgeWeek'] as num?)?.toInt(),
  gestationalAgeDay: (json['GestationalAgeDay'] as num?)?.toInt(),
  adClientId: json['AD_Client_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Client_ID'] as Map<String, dynamic>),
  adOrgId: json['AD_Org_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Org_ID'] as Map<String, dynamic>),
  cSalesRegionId: json['C_SalesRegion_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_SalesRegion_ID'] as Map<String, dynamic>),
  orderTypeId: json['OrderType_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['OrderType_ID'] as Map<String, dynamic>),
  mSpecialistId: json['M_Specialist_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['M_Specialist_ID'] as Map<String, dynamic>),
  cBPartnerId: json['C_BPartner_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_BPartner_ID'] as Map<String, dynamic>),
  cEncounterId: json['C_Encounter_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_Encounter_ID'] as Map<String, dynamic>),
  processed: json['Processed'] as bool,
  obstetric: (json['obstetric'] as List<dynamic>?)
      ?.map((e) => ObstetricRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  gynecology: (json['gynecology'] as List<dynamic>?)
      ?.map((e) => GynecologyRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  prescriptions: (json['prescriptions'] as List<dynamic>?)
      ?.map((e) => PrescriptionRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MedicalRecordToJson(MedicalRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'DocumentNo': instance.documentNo,
      'DateTrx': instance.dateTrx,
      'DocStatus': instance.docStatus,
      'GestationalAgeWeek': instance.gestationalAgeWeek,
      'GestationalAgeDay': instance.gestationalAgeDay,
      'AD_Client_ID': instance.adClientId,
      'AD_Org_ID': instance.adOrgId,
      'C_SalesRegion_ID': instance.cSalesRegionId,
      'OrderType_ID': instance.orderTypeId,
      'M_Specialist_ID': instance.mSpecialistId,
      'C_BPartner_ID': instance.cBPartnerId,
      'C_Encounter_ID': instance.cEncounterId,
      'Processed': instance.processed,
      'obstetric': instance.obstetric,
      'gynecology': instance.gynecology,
      'prescriptions': instance.prescriptions,
    };

GeneralInfo _$GeneralInfoFromJson(Map<String, dynamic> json) => GeneralInfo(
  propertyLabel: json['propertyLabel'] as String,
  id: json['id'],
  identifier: json['identifier'] as String,
  modelName: json['model-name'] as String?,
);

Map<String, dynamic> _$GeneralInfoToJson(GeneralInfo instance) =>
    <String, dynamic>{
      'propertyLabel': instance.propertyLabel,
      'id': instance.id,
      'identifier': instance.identifier,
      'model-name': instance.modelName,
    };

ObstetricRecord _$ObstetricRecordFromJson(
  Map<String, dynamic> json,
) => ObstetricRecord(
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

Map<String, dynamic> _$ObstetricRecordToJson(ObstetricRecord instance) =>
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

GynecologyRecord _$GynecologyRecordFromJson(
  Map<String, dynamic> json,
) => GynecologyRecord(
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

Map<String, dynamic> _$GynecologyRecordToJson(GynecologyRecord instance) =>
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

PrescriptionRecord _$PrescriptionRecordFromJson(Map<String, dynamic> json) =>
    PrescriptionRecord(
      id: (json['id'] as num).toInt(),
      uid: json['uid'] as String,
      adClientId: json['AD_Client_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['AD_Client_ID'] as Map<String, dynamic>),
      adOrgId: json['AD_Org_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['AD_Org_ID'] as Map<String, dynamic>),
      lineNo: (json['LineNo'] as num?)?.toInt(),
      cMedicalRecordId: json['C_MedicalRecord_ID'] == null
          ? null
          : GeneralInfo.fromJson(
              json['C_MedicalRecord_ID'] as Map<String, dynamic>,
            ),
      mProductId: json['M_Product_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['M_Product_ID'] as Map<String, dynamic>),
      qty: json['Qty'] as num?,
      isMedicationCompund: json['isMedicationCompund'] == null
          ? null
          : GeneralInfo.fromJson(
              json['isMedicationCompund'] as Map<String, dynamic>,
            ),
      qtyOnHand: json['QtyOnHand'] as num?,
      isActive: json['IsActive'] as bool?,
      description: json['Description'] as String?,
    );

Map<String, dynamic> _$PrescriptionRecordToJson(PrescriptionRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'AD_Client_ID': instance.adClientId,
      'AD_Org_ID': instance.adOrgId,
      'LineNo': instance.lineNo,
      'C_MedicalRecord_ID': instance.cMedicalRecordId,
      'M_Product_ID': instance.mProductId,
      'Qty': instance.qty,
      'isMedicationCompund': instance.isMedicationCompund,
      'QtyOnHand': instance.qtyOnHand,
      'IsActive': instance.isActive,
      'Description': instance.description,
    };
