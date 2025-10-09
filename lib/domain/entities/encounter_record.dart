import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/domain/entities/record.dart';
import 'package:medibuk/presentation/utils/formatter.dart';

part 'encounter_record.g.dart';

@JsonSerializable(includeIfNull: true)
class EncounterRecord extends Record {
  @JsonKey(name: 'AD_Client_ID')
  final GeneralInfo? adClientId;
  @JsonKey(name: 'AD_Org_ID')
  final GeneralInfo? adOrgId;
  @JsonKey(name: 'C_DocType_ID')
  final GeneralInfo? cDocTypeId;
  @JsonKey(name: 'DocumentNo')
  final String? documentNo;
  @JsonKey(name: 'DateTrx')
  final String? dateTrx;
  @JsonKey(name: 'Antrian')
  final String? antrian;
  @JsonKey(name: 'C_BPartner_ID')
  final GeneralInfo? cBPartnerId;
  @JsonKey(name: 'C_BPartnerRelation_ID')
  final GeneralInfo? cBPartnerRelationID;
  @JsonKey(name: 'Birthday')
  final String? birthday;
  @JsonKey(name: 'C_SalesRegion_ID')
  final GeneralInfo? cSalesRegionId;
  @JsonKey(name: 'C_EncounterSchedule_ID')
  final GeneralInfo? cEncounterScheduleID;
  @JsonKey(name: 'C_MedicalRecord_ID')
  final GeneralInfo? cMedicalRecordID;
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
  final GeneralInfo? docStatus;
  @JsonKey(name: 'Amount')
  final num? amount;
  @JsonKey(name: 'LILA')
  final num? lila;
  @JsonKey(name: 'IsActive')
  final bool? isActive;
  @JsonKey(name: 'Processed')
  final bool? processed;
  @JsonKey(name: 'IsPaid')
  final bool? isPaid;
  @JsonKey(name: 'DiscountAmt')
  final num? discountAmt;
  @JsonKey(name: 'AmtBeforeDisc')
  final num? amtBeforeDisc;
  @JsonKey(name: 'doc-action')
  final String? docAction;
  @JsonKey(name: 'C_Order_ID')
  final GeneralInfo? cOrderID;
  @JsonKey(name: 'QA_Sources_ID')
  final GeneralInfo? qaSourcesID;

  EncounterRecord({
    required super.id,
    required super.uid,
    this.adClientId,
    this.adOrgId,
    this.cDocTypeId,
    this.documentNo,
    this.dateTrx,
    this.antrian,
    this.cBPartnerId,
    this.cBPartnerRelationID,
    this.birthday,
    this.cSalesRegionId,
    this.mSpecialistId,
    this.doctorId,
    this.assistantId,
    this.info,
    this.cEncounterScheduleID,
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
    this.docStatus,
    this.amount,
    this.lila,
    this.isActive,
    this.processed,
    this.isPaid,
    this.discountAmt,
    this.amtBeforeDisc,
    this.docAction,
    this.cOrderID,
    this.qaSourcesID,
    this.cMedicalRecordID,
  });

  factory EncounterRecord.fromJson(Map<String, dynamic> json) =>
      _$EncounterRecordFromJson(json);

  Map<String, dynamic> toJson() => _$EncounterRecordToJson(this);

  factory EncounterRecord.empty() {
    final now = DateTime.now();
    return EncounterRecord(
      id: -1,
      uid: 'new-${now.millisecondsSinceEpoch}',
      documentNo: 'NEW',
      dateTrx: DateFormat('yyyy-MM-dd').format(now),
      docStatus: null,
      isActive: null,
      processed: null,
      isPaid: null,
      systolicPressure: null,
      diastolicPressure: null,
      bodyWeight: null,
      bodyHeight: null,
      bodyTemperature: null,
      birthWeight: null,
      headCircumference: null,
      pregnancyNo: null,
      miscarriage: null,
      laborSpontanNormal: null,
      laborSC: null,
      laborSpontanForcep: null,
      laborSpontanVacuum: null,
      amount: null,
      lila: null,
      discountAmt: null,
      amtBeforeDisc: null,
    );
  }

  DocumentStatus? get documentStatus {
    if (docStatus == null) return null;
    switch (docStatus!.id) {
      case 'DR':
        return DocumentStatus.drafted;
      case 'IP':
        return DocumentStatus.inprogress;
      case 'CO':
        return DocumentStatus.complete;
      case 'IN':
        return DocumentStatus.invalid;
      case 'VO':
        return DocumentStatus.voided;
      default:
        return null;
    }
  }

  EncounterRecord copyWith({
    int? id,
    String? uid,
    GeneralInfo? adClientId,
    GeneralInfo? adOrgId,
    GeneralInfo? cDocTypeId,
    String? documentNo,
    String? dateTrx,
    String? antrian,
    GeneralInfo? cBPartnerId,
    GeneralInfo? cBPartnerRelationID,
    String? birthday,
    GeneralInfo? cSalesRegionId,
    GeneralInfo? cEncounterScheduleID,
    GeneralInfo? cMedicalRecordID,
    GeneralInfo? mSpecialistId,
    GeneralInfo? doctorId,
    GeneralInfo? assistantId,
    String? info,
    num? systolicPressure,
    num? diastolicPressure,
    num? bodyWeight,
    num? bodyHeight,
    num? bodyTemperature,
    num? birthWeight,
    String? firstDayOfMenstrualPeriod,
    num? headCircumference,
    int? pregnancyNo,
    int? miscarriage,
    int? laborSpontanNormal,
    int? laborSC,
    int? laborSpontanForcep,
    int? laborSpontanVacuum,
    GeneralInfo? docStatus,
    num? amount,
    num? lila,
    bool? isActive,
    bool? processed,
    bool? isPaid,
    num? discountAmt,
    num? amtBeforeDisc,
    String? docAction,
    GeneralInfo? cOrderID,
    GeneralInfo? qaSourcesID,
  }) {
    return EncounterRecord(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      adClientId: adClientId ?? this.adClientId,
      adOrgId: adOrgId ?? this.adOrgId,
      cDocTypeId: cDocTypeId ?? this.cDocTypeId,
      documentNo: documentNo ?? this.documentNo,
      dateTrx: dateTrx ?? this.dateTrx,
      antrian: antrian ?? this.antrian,
      cBPartnerId: cBPartnerId ?? this.cBPartnerId,
      cBPartnerRelationID: cBPartnerRelationID ?? this.cBPartnerRelationID,
      birthday: birthday ?? this.birthday,
      cSalesRegionId: cSalesRegionId ?? this.cSalesRegionId,
      cEncounterScheduleID: cEncounterScheduleID ?? this.cEncounterScheduleID,
      cMedicalRecordID: cMedicalRecordID ?? this.cMedicalRecordID,
      mSpecialistId: mSpecialistId ?? this.mSpecialistId,
      doctorId: doctorId ?? this.doctorId,
      assistantId: assistantId ?? this.assistantId,
      info: info ?? this.info,
      systolicPressure: systolicPressure ?? this.systolicPressure,
      diastolicPressure: diastolicPressure ?? this.diastolicPressure,
      bodyWeight: bodyWeight ?? this.bodyWeight,
      bodyHeight: bodyHeight ?? this.bodyHeight,
      bodyTemperature: bodyTemperature ?? this.bodyTemperature,
      birthWeight: birthWeight ?? this.birthWeight,
      firstDayOfMenstrualPeriod:
          firstDayOfMenstrualPeriod ?? this.firstDayOfMenstrualPeriod,
      headCircumference: headCircumference ?? this.headCircumference,
      pregnancyNo: pregnancyNo ?? this.pregnancyNo,
      miscarriage: miscarriage ?? this.miscarriage,
      laborSpontanNormal: laborSpontanNormal ?? this.laborSpontanNormal,
      laborSC: laborSC ?? this.laborSC,
      laborSpontanForcep: laborSpontanForcep ?? this.laborSpontanForcep,
      laborSpontanVacuum: laborSpontanVacuum ?? this.laborSpontanVacuum,
      docStatus: docStatus ?? this.docStatus,
      amount: amount ?? this.amount,
      lila: lila ?? this.lila,
      isActive: isActive ?? this.isActive,
      processed: processed ?? this.processed,
      isPaid: isPaid ?? this.isPaid,
      discountAmt: discountAmt ?? this.discountAmt,
      amtBeforeDisc: amtBeforeDisc ?? this.amtBeforeDisc,
      docAction: docAction ?? this.docAction,
      cOrderID: cOrderID ?? this.cOrderID,
      qaSourcesID: qaSourcesID ?? this.qaSourcesID,
    );
  }
}
