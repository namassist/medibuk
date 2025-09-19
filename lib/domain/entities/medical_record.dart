// lib/domain/entities/medical_record.dart
import 'package:json_annotation/json_annotation.dart';

part 'medical_record.g.dart';

@JsonSerializable()
class MedicalRecord {
  final int id;
  final String uid;
  @JsonKey(name: 'DocumentNo')
  final String documentNo;
  @JsonKey(name: 'DateTrx')
  final String dateTrx;
  @JsonKey(name: 'DocStatus')
  final GeneralInfo docStatus;
  @JsonKey(name: 'GestationalAgeWeek')
  final int? gestationalAgeWeek;
  @JsonKey(name: 'GestationalAgeDay')
  final int? gestationalAgeDay;
  @JsonKey(name: 'AD_Client_ID')
  final GeneralInfo? adClientId;
  @JsonKey(name: 'AD_Org_ID')
  final GeneralInfo? adOrgId;
  @JsonKey(name: 'C_SalesRegion_ID')
  final GeneralInfo? cSalesRegionId;
  @JsonKey(name: 'OrderType_ID')
  final GeneralInfo? orderTypeId;
  @JsonKey(name: 'M_Specialist_ID')
  final GeneralInfo? mSpecialistId;
  @JsonKey(name: 'C_BPartner_ID')
  final GeneralInfo? cBPartnerId;
  @JsonKey(name: 'C_Encounter_ID')
  final GeneralInfo? cEncounterId;
  @JsonKey(name: 'Processed')
  final bool processed;
  final List<ObstetricRecord>? obstetric;
  final List<GynecologyRecord>? gynecology;
  final List<PrescriptionRecord>? prescriptions;
  // @JsonKey(name: 'medical-record-umum')
  // final List<dynamic>? medicalRecordUmum;
  // @JsonKey(name: 'medical-record-anak')
  // final List<dynamic>? medicalRecordAnak;
  // final List<dynamic>? services;
  // @JsonKey(name: 'icd-codes')
  // final List<dynamic>? icdCodes;
  // final List<dynamic>? dental;
  // final List<dynamic>? laktasi;
  // final List<dynamic>? andrologi;

  const MedicalRecord({
    required this.id,
    required this.uid,
    required this.documentNo,
    required this.dateTrx,
    required this.docStatus,
    this.gestationalAgeWeek,
    this.gestationalAgeDay,
    this.adClientId,
    this.adOrgId,
    this.cSalesRegionId,
    this.orderTypeId,
    this.mSpecialistId,
    this.cBPartnerId,
    this.cEncounterId,
    required this.processed,
    required this.obstetric,
    required this.gynecology,
    required this.prescriptions,
    // required this.medicalRecordUmum,
    // required this.medicalRecordAnak,
    // required this.services,
    // required this.icdCodes,
    // required this.dental,
    // required this.laktasi,
    // required this.andrologi,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) =>
      _$MedicalRecordFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalRecordToJson(this);
}

@JsonSerializable()
class GeneralInfo {
  final String propertyLabel;
  final dynamic id;
  final String identifier;
  @JsonKey(name: 'model-name')
  final String? modelName;

  const GeneralInfo({
    required this.propertyLabel,
    required this.id,
    required this.identifier,
    this.modelName,
  });

  factory GeneralInfo.fromJson(Map<String, dynamic> json) =>
      _$GeneralInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralInfoToJson(this);
}

@JsonSerializable()
class ObstetricRecord {
  final int id;
  final String uid;
  @JsonKey(name: 'AD_Client_ID')
  final GeneralInfo? adClientId;
  @JsonKey(name: 'AD_Org_ID')
  final GeneralInfo? adOrgId;
  @JsonKey(name: 'C_MedicalRecord_ID')
  final GeneralInfo? cMedicalRecordId;
  @JsonKey(name: 'C_SalesRegion_ID')
  final GeneralInfo? cSalesRegionId;
  @JsonKey(name: 'Doctor_ID')
  final GeneralInfo? doctorId;
  @JsonKey(name: 'Assistant_ID')
  final GeneralInfo? assistantId;
  @JsonKey(name: 'LineNo')
  final int? lineNo;
  @JsonKey(name: 'Birthday')
  final String? birthday;
  @JsonKey(name: 'Age')
  final String? age;
  @JsonKey(name: 'GPA')
  final String? gpa;
  @JsonKey(name: 'VisitDate')
  final String? visitDate;
  @JsonKey(name: 'NextVisitDate')
  final String? nextVisitDate;
  @JsonKey(name: 'ChiefComplaint')
  final String? chiefComplaint;
  @JsonKey(name: 'BodyTemperature')
  final num? bodyTemperature;
  @JsonKey(name: 'Miscarriage')
  final int? miscarriage;
  @JsonKey(name: 'PregnancyNo')
  final int? pregnancyNo;
  @JsonKey(name: 'FirstDayOfMenstrualPeriod')
  final String? firstDayOfMenstrualPeriod;
  @JsonKey(name: 'Riwayat_alergi')
  final String? riwayatAlergi;
  @JsonKey(name: 'HPL')
  final String? hpl;
  @JsonKey(name: 'EstimatedDateOfConception')
  final String? estimatedDateOfConception;
  @JsonKey(name: 'LaborSC')
  final num? laborSC;
  @JsonKey(name: 'LaborSpontanNormal')
  final num? laborSpontanNormal;
  @JsonKey(name: 'LaborSpontanVacuum')
  final num? laborSpontanVacuum;
  @JsonKey(name: 'BodyHeight')
  final num? bodyHeight;
  @JsonKey(name: 'BMI')
  final num? bmi;
  @JsonKey(name: 'BodyWeight')
  final num? bodyWeight;
  @JsonKey(name: 'SystolicPressure')
  final num? systolicPressure;
  @JsonKey(name: 'DiastolicPressure')
  final num? diastolicPressure;
  @JsonKey(name: 'LILA')
  final num? lila;
  @JsonKey(name: 'ICD_10')
  final GeneralInfo? icd10;
  @JsonKey(name: 'Note')
  final String? note;
  @JsonKey(name: 'InternalNote')
  final String? internalNote;
  @JsonKey(name: 'IsShowMore')
  final bool? isShowMore;
  @JsonKey(name: 'NutritionNotes')
  final String? nutritionNotes;
  @JsonKey(name: 'Presentation')
  final GeneralInfo? presentation;
  @JsonKey(name: 'PlacentaGrade')
  final num? placentaGrade;
  @JsonKey(name: 'PlacentaPosition')
  final GeneralInfo? placentaPosition;
  @JsonKey(name: 'Weight')
  final num? weight;
  @JsonKey(name: 'GS')
  final num? gs;
  @JsonKey(name: 'YS')
  final num? ys;
  @JsonKey(name: 'DJJ')
  final num? djj;
  @JsonKey(name: 'FL')
  final num? fl;
  @JsonKey(name: 'CRL')
  final num? crl;
  @JsonKey(name: 'BPD')
  final num? bpd;
  @JsonKey(name: 'HC')
  final num? hc;
  @JsonKey(name: 'AC')
  final num? ac;
  @JsonKey(name: 'Gender')
  final GeneralInfo? gender;
  @JsonKey(name: 'SDP')
  final num? sdp;
  @JsonKey(name: 'AFI')
  final num? afi;
  @JsonKey(name: 'Cairan_Ketuban')
  final GeneralInfo? cairanKetuban;

  const ObstetricRecord({
    required this.id,
    required this.uid,
    this.adClientId,
    this.adOrgId,
    this.cMedicalRecordId,
    this.cSalesRegionId,
    this.doctorId,
    this.assistantId,
    this.lineNo,
    this.birthday,
    this.age,
    this.gpa,
    this.visitDate,
    this.nextVisitDate,
    this.chiefComplaint,
    this.bodyTemperature,
    this.miscarriage,
    this.pregnancyNo,
    this.firstDayOfMenstrualPeriod,
    this.riwayatAlergi,
    this.hpl,
    this.estimatedDateOfConception,
    this.laborSC,
    this.laborSpontanNormal,
    this.laborSpontanVacuum,
    this.bodyHeight,
    this.bmi,
    this.bodyWeight,
    this.systolicPressure,
    this.diastolicPressure,
    this.lila,
    this.icd10,
    this.note,
    this.internalNote,
    this.isShowMore,
    this.nutritionNotes,
    this.presentation,
    this.placentaGrade,
    this.placentaPosition,
    this.weight,
    this.gs,
    this.ys,
    this.djj,
    this.fl,
    this.crl,
    this.bpd,
    this.hc,
    this.ac,
    this.gender,
    this.sdp,
    this.afi,
    this.cairanKetuban,
  });

  factory ObstetricRecord.fromJson(Map<String, dynamic> json) =>
      _$ObstetricRecordFromJson(json);

  Map<String, dynamic> toJson() => _$ObstetricRecordToJson(this);
}

@JsonSerializable()
class GynecologyRecord {
  final int id;
  final String uid;
  @JsonKey(name: 'AD_Client_ID')
  final GeneralInfo? adClientId;
  @JsonKey(name: 'AD_Org_ID')
  final GeneralInfo? adOrgId;
  @JsonKey(name: 'C_SalesRegion_ID')
  final GeneralInfo? cSalesRegionId;
  @JsonKey(name: 'C_MedicalRecord_ID')
  final GeneralInfo? cMedicalRecordId;
  @JsonKey(name: 'Doctor_ID')
  final GeneralInfo? doctorId;
  @JsonKey(name: 'Assistant_ID')
  final GeneralInfo? assistantId;
  @JsonKey(name: 'VisitDate')
  final String? visitDate;
  @JsonKey(name: 'NextVisitDate')
  final String? nextVisitDate;
  @JsonKey(name: 'ChiefComplaint')
  final String? chiefComplaint;
  @JsonKey(name: 'BirthControlMethod')
  final GeneralInfo? birthControlMethod;
  @JsonKey(name: 'BodyWeight')
  final num? bodyWeight;
  @JsonKey(name: 'SystolicPressure')
  final num? systolicPressure;
  @JsonKey(name: 'BodyHeight')
  final num? bodyHeight;
  @JsonKey(name: 'BMI')
  final num? bmi;
  @JsonKey(name: 'DiastolicPressure')
  final num? diastolicPressure;
  @JsonKey(name: 'Birthday')
  final String? birthday;
  @JsonKey(name: 'FirstDayOfMenstrualPeriod')
  final String? firstDayOfMenstrualPeriod;
  @JsonKey(name: 'ICD_10')
  final GeneralInfo? icd10;
  @JsonKey(name: 'InternalNote')
  final String? internalNote;
  @JsonKey(name: 'Note')
  final String? note;
  @JsonKey(name: 'IsShowMore')
  final bool? isShowMore;
  @JsonKey(name: 'NutritionNotes')
  final String? nutritionNotes;
  @JsonKey(name: 'UterusNote')
  final String? uterusNote;
  @JsonKey(name: 'UterusLength')
  final num? uterusLength;
  @JsonKey(name: 'UterusWidth')
  final num? uterusWidth;
  @JsonKey(name: 'UterusThickness')
  final num? uterusThickness;
  @JsonKey(name: 'UterusPosition')
  final GeneralInfo? uterusPosition;
  @JsonKey(name: 'EndometriumThickness')
  final num? endometriumThickness;
  @JsonKey(name: 'RightOvaryFollicleCount')
  final num? rightOvaryFollicleCount;
  @JsonKey(name: 'RightOvaryNote')
  final String? rightOvaryNote;
  @JsonKey(name: 'RightOvaryLength')
  final num? rightOvaryLength;
  @JsonKey(name: 'RightOvaryThickness')
  final num? rightOvaryThickness;
  @JsonKey(name: 'RightOvaryWidth')
  final num? rightOvaryWidth;
  @JsonKey(name: 'LeftOvaryFollicleCount')
  final num? leftOvaryFollicleCount;
  @JsonKey(name: 'LeftOvaryNote')
  final String? leftOvaryNote;
  @JsonKey(name: 'LeftOvaryLength')
  final num? leftOvaryLength;
  @JsonKey(name: 'LeftOvaryThickness')
  final num? leftOvaryThickness;
  @JsonKey(name: 'LeftOvaryWidth')
  final num? leftOvaryWidth;

  const GynecologyRecord({
    required this.id,
    required this.uid,
    this.adClientId,
    this.adOrgId,
    this.cSalesRegionId,
    this.cMedicalRecordId,
    this.doctorId,
    this.assistantId,
    this.visitDate,
    this.nextVisitDate,
    this.chiefComplaint,
    this.birthControlMethod,
    this.bodyWeight,
    this.systolicPressure,
    this.bodyHeight,
    this.bmi,
    this.diastolicPressure,
    this.birthday,
    this.firstDayOfMenstrualPeriod,
    this.icd10,
    this.internalNote,
    this.note,
    this.isShowMore,
    this.nutritionNotes,
    this.uterusNote,
    this.uterusLength,
    this.uterusWidth,
    this.uterusThickness,
    this.uterusPosition,
    this.endometriumThickness,
    this.rightOvaryFollicleCount,
    this.rightOvaryNote,
    this.rightOvaryLength,
    this.rightOvaryThickness,
    this.rightOvaryWidth,
    this.leftOvaryFollicleCount,
    this.leftOvaryNote,
    this.leftOvaryLength,
    this.leftOvaryThickness,
    this.leftOvaryWidth,
  });

  factory GynecologyRecord.fromJson(Map<String, dynamic> json) =>
      _$GynecologyRecordFromJson(json);

  Map<String, dynamic> toJson() => _$GynecologyRecordToJson(this);
}

@JsonSerializable()
class PrescriptionRecord {
  final int id;
  final String uid;
  @JsonKey(name: 'AD_Client_ID')
  final GeneralInfo? adClientId;
  @JsonKey(name: 'AD_Org_ID')
  final GeneralInfo? adOrgId;
  @JsonKey(name: 'LineNo')
  final int? lineNo;
  @JsonKey(name: 'C_MedicalRecord_ID')
  final GeneralInfo? cMedicalRecordId;
  @JsonKey(name: 'M_Product_ID')
  final GeneralInfo? mProductId;
  @JsonKey(name: 'Qty')
  final num? qty;
  @JsonKey(name: 'isMedicationCompund')
  final GeneralInfo? isMedicationCompund;
  @JsonKey(name: 'QtyOnHand')
  final num? qtyOnHand;
  @JsonKey(name: 'IsActive')
  final bool? isActive;
  @JsonKey(name: 'Description')
  final String? description;

  const PrescriptionRecord({
    required this.id,
    required this.uid,
    this.adClientId,
    this.adOrgId,
    this.lineNo,
    this.cMedicalRecordId,
    this.mProductId,
    this.qty,
    this.isMedicationCompund,
    this.qtyOnHand,
    this.isActive,
    this.description,
  });

  factory PrescriptionRecord.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionRecordFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionRecordToJson(this);
}

extension MedicalRecordCopyWith on MedicalRecord {
  MedicalRecord copyWith({
    int? id,
    String? uid,
    String? documentNo,
    String? dateTrx,
    GeneralInfo? docStatus,
    int? gestationalAgeWeek,
    int? gestationalAgeDay,
    GeneralInfo? adClientId,
    GeneralInfo? adOrgId,
    GeneralInfo? cSalesRegionId,
    GeneralInfo? orderTypeId,
    GeneralInfo? mSpecialistId,
    GeneralInfo? cBPartnerId,
    GeneralInfo? cEncounterId,
    bool? processed,
    List<ObstetricRecord>? obstetric,
    List<GynecologyRecord>? gynecology,
    List<PrescriptionRecord>? prescriptions,
  }) {
    return MedicalRecord(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      documentNo: documentNo ?? this.documentNo,
      dateTrx: dateTrx ?? this.dateTrx,
      docStatus: docStatus ?? this.docStatus,
      gestationalAgeWeek: gestationalAgeWeek ?? this.gestationalAgeWeek,
      gestationalAgeDay: gestationalAgeDay ?? this.gestationalAgeDay,
      adClientId: adClientId ?? this.adClientId,
      adOrgId: adOrgId ?? this.adOrgId,
      cSalesRegionId: cSalesRegionId ?? this.cSalesRegionId,
      orderTypeId: orderTypeId ?? this.orderTypeId,
      mSpecialistId: mSpecialistId ?? this.mSpecialistId,
      cBPartnerId: cBPartnerId ?? this.cBPartnerId,
      cEncounterId: cEncounterId ?? this.cEncounterId,
      processed: processed ?? this.processed,
      obstetric: obstetric ?? this.obstetric,
      gynecology: gynecology ?? this.gynecology,
      prescriptions: prescriptions ?? this.prescriptions,
    );
  }
}
