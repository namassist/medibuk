import 'general_info.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medibuk/domain/entities/record.dart';

part 'laktasi_record.g.dart';

@JsonSerializable()
class LaktasiRecord extends Record {
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

  const LaktasiRecord({
    required super.id,
    required super.uid,
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

  factory LaktasiRecord.fromJson(Map<String, dynamic> json) =>
      _$LaktasiRecordFromJson(json);

  Map<String, dynamic> toJson() => _$LaktasiRecordToJson(this);
}
