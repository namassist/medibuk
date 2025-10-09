import 'general_info.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medibuk/domain/entities/record.dart';

part 'laktasi_record.g.dart';

@JsonSerializable()
class LaktasiRecord extends Record {
  @JsonKey(name: 'Doctor_ID')
  final GeneralInfo? doctorID;

  @JsonKey(name: 'C_MedicalRecord_ID')
  final GeneralInfo? cMedicalRecordID;

  @JsonKey(name: 'Assistant_ID')
  final GeneralInfo? assistantID;

  @JsonKey(name: 'C_SalesRegion_ID')
  final GeneralInfo? cSalesRegionID;

  @JsonKey(name: 'VisitDate')
  final DateTime? visitDate;

  @JsonKey(name: 'C_BPartnerRelation_ID')
  final GeneralInfo? child;

  @JsonKey(name: 'BirthWeight')
  final num? birthWeight;

  @JsonKey(name: 'Gender')
  final GeneralInfo? gender;

  @JsonKey(name: 'Birthday')
  final DateTime? birthday;

  @JsonKey(name: 'DiastolicPressureMother')
  final num? diastolicPressureMother;

  @JsonKey(name: 'BodyTemperatureMother')
  final num? bodyTemperatureMother;

  @JsonKey(name: 'BodyWeightMother')
  final num? bodyWeightMother;

  @JsonKey(name: 'SystolicPressureMother')
  final num? systolicPressureMother;

  @JsonKey(name: 'ICD_10')
  final GeneralInfo? icd10;

  @JsonKey(name: 'Keluhan_Utama')
  final String? keluhanUtama;

  @JsonKey(name: 'scratched')
  final bool? scratched;

  @JsonKey(name: 'BreastMilk')
  final bool? breastMilk;

  @JsonKey(name: 'Suckling')
  final bool? suckling;

  const LaktasiRecord({
    required super.id,
    required super.uid,
    this.doctorID,
    this.cMedicalRecordID,
    this.assistantID,
    this.cSalesRegionID,
    this.visitDate,
    this.child,
    this.birthWeight,
    this.gender,
    this.birthday,
    this.diastolicPressureMother,
    this.bodyTemperatureMother,
    this.bodyWeightMother,
    this.systolicPressureMother,
    this.icd10,
    this.keluhanUtama,
    this.scratched,
    this.breastMilk,
    this.suckling,
  });

  factory LaktasiRecord.fromJson(Map<String, dynamic> json) =>
      _$LaktasiRecordFromJson(json);

  Map<String, dynamic> toJson() => _$LaktasiRecordToJson(this);
}
