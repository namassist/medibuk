import 'general_info.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medibuk/domain/entities/record.dart';

part 'andrologi_record.g.dart';

@JsonSerializable()
class AndrologiRecord extends Record {
  @JsonKey(name: 'AD_Client_ID')
  final GeneralInfo? adClientID;
  @JsonKey(name: 'AD_Org_ID')
  final GeneralInfo? adOrgID;
  @JsonKey(name: 'Description')
  final String? description;
  @JsonKey(name: 'Assistant_ID')
  final GeneralInfo? assistantID;
  @JsonKey(name: 'Birthday')
  final DateTime? birthday;
  @JsonKey(name: 'BodyHeight')
  final num? bodyHeight;
  @JsonKey(name: 'BodyTemperature')
  final num? bodyTemperature;
  @JsonKey(name: 'BodyWeight')
  final num? bodyWeight;
  @JsonKey(name: 'C_SalesRegion_ID')
  final GeneralInfo? cSalesRegionID;
  @JsonKey(name: 'DiastolicPressure')
  final num? diastolicPressure;
  @JsonKey(name: 'Doctor_ID')
  final GeneralInfo? doctorID;
  @JsonKey(name: 'Gender')
  final GeneralInfo? gender;
  @JsonKey(name: 'InternalNote')
  final String? internalNote;
  @JsonKey(name: 'Keluhan_Utama')
  final String? keluhanUtama;
  @JsonKey(name: 'NextVisitDate')
  final DateTime? nextVisitDate;
  @JsonKey(name: 'Note')
  final String? note;
  @JsonKey(name: 'SystolicPressure')
  final num? systolicPressure;
  @JsonKey(name: 'VisitDate')
  final DateTime? visitDate;
  @JsonKey(name: 'C_MedicalRecord_ID')
  final GeneralInfo? cMedicalRecordID;

  const AndrologiRecord({
    required super.id,
    required super.uid,
    this.adClientID,
    this.adOrgID,
    this.description,
    this.assistantID,
    this.birthday,
    this.bodyHeight,
    this.bodyTemperature,
    this.bodyWeight,
    this.cSalesRegionID,
    this.diastolicPressure,
    this.doctorID,
    this.gender,
    this.internalNote,
    this.keluhanUtama,
    this.nextVisitDate,
    this.note,
    this.systolicPressure,
    this.visitDate,
    this.cMedicalRecordID,
  });

  factory AndrologiRecord.fromJson(Map<String, dynamic> json) =>
      _$AndrologiRecordFromJson(json);

  Map<String, dynamic> toJson() => _$AndrologiRecordToJson(this);
}
