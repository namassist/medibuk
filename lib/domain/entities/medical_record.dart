import 'package:medibuk/domain/entities/record.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medibuk/domain/entities/anak_record.dart';
import 'package:medibuk/domain/entities/andrologi_record.dart';
import 'package:medibuk/domain/entities/dental_record.dart';
import 'package:medibuk/domain/entities/laktasi_record.dart';
import 'package:medibuk/domain/entities/service_record.dart';
import 'package:medibuk/domain/entities/umum_record.dart';
import 'general_info.dart';
import 'obstetric_record.dart';
import 'gynecology_record.dart';
import 'prescription_record.dart';
import 'package:intl/intl.dart';

export 'general_info.dart';
export 'obstetric_record.dart';
export 'gynecology_record.dart';
export 'prescription_record.dart';

part 'medical_record.g.dart';

@JsonSerializable()
class MedicalRecord extends Record {
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
  final List<DentalRecord>? dental;
  @JsonKey(name: 'medical-record-anak')
  final List<AnakRecord>? anak;
  @JsonKey(name: 'medical-record-umum')
  final List<UmumRecord>? umum;
  @JsonKey(name: 'laktasi')
  final List<LaktasiRecord>? laktasi;
  @JsonKey(name: 'andrologi')
  final List<AndrologiRecord>? andrologi;
  final List<ServiceRecord>? services;
  final List<PrescriptionRecord>? prescriptions;

  const MedicalRecord({
    required super.id,
    required super.uid,
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
    required this.dental,
    required this.anak,
    required this.umum,
    required this.laktasi,
    required this.andrologi,
    required this.services,
    required this.prescriptions,
  });

  factory MedicalRecord.empty() {
    final now = DateTime.now();
    return MedicalRecord(
      id: 0,
      uid: 'new-${now.millisecondsSinceEpoch}',
      documentNo: 'NEW RECORD',
      dateTrx: DateFormat('yyyy-MM-dd').format(now),
      docStatus: const GeneralInfo(
        propertyLabel: 'Document Status',
        id: 'DR',
        identifier: 'Drafted',
        modelName: 'ad_ref_list',
      ),
      processed: false,
      obstetric: const [],
      gynecology: const [],
      dental: const [],
      anak: const [],
      umum: const [],
      laktasi: const [],
      andrologi: const [],
      services: const [],
      prescriptions: const [],
    );
  }

  factory MedicalRecord.fromJson(Map<String, dynamic> json) =>
      _$MedicalRecordFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalRecordToJson(this);
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
    List<DentalRecord>? dental,
    List<AnakRecord>? anak,
    List<UmumRecord>? umum,
    List<LaktasiRecord>? laktasi,
    List<AndrologiRecord>? andrologi,
    List<ServiceRecord>? services,
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
      dental: dental ?? this.dental,
      anak: anak ?? this.anak,
      umum: umum ?? this.umum,
      laktasi: laktasi ?? this.laktasi,
      andrologi: andrologi ?? this.andrologi,
      services: services ?? this.services,
      prescriptions: prescriptions ?? this.prescriptions,
    );
  }
}
