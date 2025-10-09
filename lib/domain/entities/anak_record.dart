import 'general_info.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medibuk/domain/entities/record.dart';

part 'anak_record.g.dart';

@JsonSerializable()
class AnakRecord extends Record {
  @JsonKey(name: 'AD_Client_ID')
  final GeneralInfo? adClientID;
  @JsonKey(name: 'AD_Org_ID')
  final GeneralInfo? adOrgID;
  @JsonKey(name: 'C_SalesRegion_ID')
  final GeneralInfo? cSalesRegionID;
  @JsonKey(name: 'C_MedicalRecord_ID')
  final GeneralInfo? cMedicalRecordID;
  @JsonKey(name: 'Doctor_ID')
  final GeneralInfo? doctorID;
  @JsonKey(name: 'Assistant_ID')
  final GeneralInfo? assistantID;
  @JsonKey(name: 'VisitDate')
  final DateTime? visitDate;
  @JsonKey(name: 'NextVisitDate')
  final DateTime? nextVisitDate;
  @JsonKey(name: 'Birthday')
  final DateTime? birthday;
  @JsonKey(name: 'BirthWeight')
  final num? birthWeight;
  @JsonKey(name: 'BodyWeight')
  final num? bodyWeight;
  @JsonKey(name: 'BodyHeight')
  final num? bodyHeight;
  @JsonKey(name: 'head_circumference')
  final num? headCircumference;
  @JsonKey(name: 'BodyTemperature')
  final num? bodyTemperature;
  @JsonKey(name: 'Pernafasan')
  final num? pernafasan;
  @JsonKey(name: 'Tekanan_Darah')
  final num? tekananDarah;
  @JsonKey(name: 'ICD_10')
  final GeneralInfo? icd10;
  @JsonKey(name: 'Keluhan_Utama')
  final String? keluhanUtama;
  @JsonKey(name: 'Description')
  final String? description;
  @JsonKey(name: 'Gender')
  final GeneralInfo? gender;
  @JsonKey(name: 'RTL')
  final String? rtl;
  @JsonKey(name: 'Processed')
  final bool? processed;

  const AnakRecord({
    required super.id,
    required super.uid,
    this.adClientID,
    this.adOrgID,
    this.cSalesRegionID,
    this.cMedicalRecordID,
    this.doctorID,
    this.assistantID,
    this.visitDate,
    this.nextVisitDate,
    this.birthday,
    this.birthWeight,
    this.bodyWeight,
    this.bodyHeight,
    this.headCircumference,
    this.bodyTemperature,
    this.pernafasan,
    this.tekananDarah,
    this.icd10,
    this.keluhanUtama,
    this.description,
    this.gender,
    this.rtl,
    this.processed,
  });

  factory AnakRecord.fromJson(Map<String, dynamic> json) =>
      _$AnakRecordFromJson(json);

  Map<String, dynamic> toJson() => _$AnakRecordToJson(this);
}
