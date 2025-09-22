// lib/domain/entities/gynecology_record.dart
import 'package:json_annotation/json_annotation.dart';
import 'general_info.dart';

part 'gynecology_record.g.dart';

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
