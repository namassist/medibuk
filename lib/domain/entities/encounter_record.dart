import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/domain/entities/record.dart';
import 'package:medibuk/presentation/utils/formatter.dart';

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
  final bool isActive;
  @JsonKey(name: 'Processed')
  final bool processed;
  @JsonKey(name: 'IsPaid')
  final bool isPaid;
  @JsonKey(name: 'DiscountAmt')
  final num? discountAmt;
  @JsonKey(name: 'AmtBeforeDisc')
  final num? amtBeforeDisc;
  @JsonKey(name: 'doc_action')
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
    required this.documentNo,
    required this.dateTrx,
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
    required this.isActive,
    required this.processed,
    required this.isPaid,
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
      id: 0,
      uid: 'new-${now.millisecondsSinceEpoch}',
      documentNo: 'NEW',
      dateTrx: DateFormat('yyyy-MM-dd').format(now),
      docStatus: null, // Status dibuat null saat create new
      isActive: true,
      processed: false,
      isPaid: false,
      // Inisialisasi semua field numerik dengan 0
      systolicPressure: 0,
      diastolicPressure: 0,
      bodyWeight: 0,
      bodyHeight: 0,
      bodyTemperature: 0,
      birthWeight: 0,
      headCircumference: 0,
      pregnancyNo: 0,
      miscarriage: 0,
      laborSpontanNormal: 0,
      laborSC: 0,
      laborSpontanForcep: 0,
      laborSpontanVacuum: 0,
      amount: 0,
      lila: 0,
      discountAmt: 0,
      amtBeforeDisc: 0,
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
}
