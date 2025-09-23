import 'package:json_annotation/json_annotation.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/domain/entities/record.dart';

part 'encounter_record.g.dart';

@JsonSerializable()
class EncounterRecord extends Record {
  @JsonKey(name: 'AD_Client_ID')
  final GeneralInfo? adClientId;
  @JsonKey(name: 'AD_Org_ID')
  final GeneralInfo? adOrgId;
  @JsonKey(name: 'C_DocType_ID')
  final GeneralInfo? cDocTypeId;
  @JsonKey(name: 'DocumentNo')
  final String documentNo;
  @JsonKey(name: 'DateTrx')
  final String dateTrx;
  @JsonKey(name: 'Antrian')
  final String? antrian;
  @JsonKey(name: 'C_BPartner_ID')
  final GeneralInfo? cBPartnerId;
  @JsonKey(name: 'Birthday')
  final String? birthday;
  final bool? tensi;
  @JsonKey(name: 'C_SalesRegion_ID')
  final GeneralInfo? cSalesRegionId;
  @JsonKey(name: 'M_Specialist_ID')
  final GeneralInfo? mSpecialistId;
  @JsonKey(name: 'Doctor_ID')
  final GeneralInfo? doctorId;
  @JsonKey(name: 'Assistant_ID')
  final GeneralInfo? assistantId;
  @JsonKey(name: 'Info')
  final String? info;
  @JsonKey(name: 'SystolicPressure')
  final num? systolicPressure;
  @JsonKey(name: 'DiastolicPressure')
  final num? diastolicPressure;
  @JsonKey(name: 'BodyWeight')
  final num? bodyWeight;
  @JsonKey(name: 'BodyHeight')
  final num? bodyHeight;
  @JsonKey(name: 'BodyTemperature')
  final num? bodyTemperature;
  @JsonKey(name: 'BirthWeight')
  final num? birthWeight;
  @JsonKey(name: 'FirstDayOfMenstrualPeriod')
  final String? firstDayOfMenstrualPeriod;
  @JsonKey(name: 'head_circumference')
  final num? headCircumference;
  @JsonKey(name: 'PregnancyNo')
  final int? pregnancyNo;
  @JsonKey(name: 'Miscarriage')
  final int? miscarriage;
  @JsonKey(name: 'LaborSpontanNormal')
  final int? laborSpontanNormal;
  @JsonKey(name: 'LaborSC')
  final int? laborSC;
  @JsonKey(name: 'LaborSpontanForcep')
  final int? laborSpontanForcep;
  @JsonKey(name: 'LaborSpontanVacuum')
  final int? laborSpontanVacuum;
  @JsonKey(name: 'DocStatus')
  final GeneralInfo docStatus;
  @JsonKey(name: 'Amount')
  final num? amount;
  @JsonKey(name: 'LILA')
  final num? lila;
  @JsonKey(name: 'IsActive')
  final bool isActive;
  @JsonKey(name: 'Processed')
  final bool processed;
  @JsonKey(name: 'IsPaid')
  final bool isPaid;
  @JsonKey(name: 'DiscountAmt')
  final num? discountAmt;
  @JsonKey(name: 'AmtBeforeDisc')
  final num? amtBeforeDisc;

  EncounterRecord({
    required super.id,
    required super.uid,
    this.adClientId,
    this.adOrgId,
    this.cDocTypeId,
    required this.documentNo,
    required this.dateTrx,
    this.antrian,
    this.cBPartnerId,
    this.birthday,
    this.tensi,
    this.cSalesRegionId,
    this.mSpecialistId,
    this.doctorId,
    this.assistantId,
    this.info,
    this.systolicPressure,
    this.diastolicPressure,
    this.bodyWeight,
    this.bodyHeight,
    this.bodyTemperature,
    this.birthWeight,
    this.firstDayOfMenstrualPeriod,
    this.headCircumference,
    this.pregnancyNo,
    this.miscarriage,
    this.laborSpontanNormal,
    this.laborSC,
    this.laborSpontanForcep,
    this.laborSpontanVacuum,
    required this.docStatus,
    this.amount,
    this.lila,
    required this.isActive,
    required this.processed,
    required this.isPaid,
    this.discountAmt,
    this.amtBeforeDisc,
  });

  factory EncounterRecord.fromJson(Map<String, dynamic> json) =>
      _$EncounterRecordFromJson(json);

  Map<String, dynamic> toJson() => _$EncounterRecordToJson(this);
}
