// lib/domain/entities/medical_record.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'package:medibuk/domain/entities/anak_record.dart';
import 'package:medibuk/domain/entities/andrologi_record.dart';
import 'package:medibuk/domain/entities/dental_record.dart';
import 'package:medibuk/domain/entities/laktasi_record.dart';
import 'package:medibuk/domain/entities/service_record.dart';
import 'package:medibuk/domain/entities/umum_record.dart';
import 'format_definition.dart';
import 'general_info.dart';
import 'obstetric_record.dart';
import 'gynecology_record.dart';
import 'prescription_record.dart';

export 'general_info.dart';
export 'obstetric_record.dart';
export 'gynecology_record.dart';
export 'prescription_record.dart';

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
    required this.dental,
    required this.anak,
    required this.umum,
    required this.laktasi,
    required this.andrologi,
    required this.services,
    required this.prescriptions,
  });

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

class MedicalRecordFieldConfiguration {
  static const Map<String, Map<String, FormatDefinition>>
  sectionConfigurations = {
    'main': {
      'DateTrx': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.date,
      ),
      'OrderType_ID': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'M_Specialist_ID': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'C_BPartner_ID': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'GestationalAgeWeek': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        newLine: true,
        isMandatory: true,
        fieldType: FieldType.number,
      ),
      'GestationalAgeDay': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        isMandatory: true,
        fieldType: FieldType.number,
      ),
    },
    'gynecology': {
      'Doctor_ID': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Assistant_ID': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Birthday': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.date,
      ),
      'NextVisitDate': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.date,
      ),
      'ChiefComplaint': FormatDefinition(
        wideCount: 8,
        newLine: true,
        multiLine: true,
        editable: true,
        maxLines: 7,
      ),
      'FirstDayOfMenstrualPeriod': FormatDefinition(
        wideCount: 2,
        editable: true,
        newLine: true,
        fieldType: FieldType.date,
      ),
      'BirthControlMethod': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'BodyHeight': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'BodyWeight': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'SystolicPressure': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'DiastolicPressure': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'ICD_10': FormatDefinition(
        wideCount: 4,
        editable: true,
        newLine: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'EndometriumThickness': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'InternalNote': FormatDefinition(
        wideCount: 8,
        editable: true,
        multiLine: true,
        newLine: true,
        maxLines: 7,
      ),
      'Note': FormatDefinition(
        wideCount: 8,
        editable: true,
        multiLine: true,
        newLine: true,
        maxLines: 7,
      ),
      'IsShowMore': FormatDefinition(
        wideCount: 2,
        editable: true,
        newLine: true,
        fieldType: FieldType.boolean,
      ),
      'NutritionNotes': FormatDefinition(
        wideCount: 8,
        newLine: true,
        multiLine: true,
        editable: true,
        maxLines: 7,
      ),
      'UterusLength': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'UterusWidth': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'UterusThickness': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'UterusPosition': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'UterusNote': FormatDefinition(
        wideCount: 8,
        editable: true,
        multiLine: true,
        newLine: true,
        maxLines: 7,
      ),
      'LeftOvaryFollicleCount': FormatDefinition(
        wideCount: 2,
        newLine: true,
        editable: true,
        fieldType: FieldType.number,
      ),
      'LeftOvaryLength': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'LeftOvaryThickness': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'LeftOvaryWidth': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'LeftOvaryNote': FormatDefinition(
        wideCount: 8,
        editable: true,
        multiLine: true,
        newLine: true,
        maxLines: 7,
      ),
      'RightOvaryFollicleCount': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'RightOvaryLength': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'RightOvaryThickness': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'RightOvaryWidth': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'RightOvaryNote': FormatDefinition(
        wideCount: 8,
        editable: true,
        multiLine: true,
        newLine: true,
        maxLines: 7,
      ),
    },
    'obstetric': {
      'Doctor_ID': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Assistant_ID': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Birthday': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.date,
      ),
      'Age': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.text,
      ),
      'GPA': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.text,
      ),
      'LineNo': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'VisitDate': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.date,
      ),
      'NextVisitDate': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.date,
      ),
      'ChiefComplaint': FormatDefinition(
        wideCount: 8,
        editable: true,
        multiLine: true,
        newLine: true,
        maxLines: 7,
      ),
      'BodyTemperature': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'Miscarriage': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'PregnancyNo': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'EstimatedDateOfConception': FormatDefinition(
        wideCount: 2,
        editable: false,
        fieldType: FieldType.date,
      ),
      'FirstDayOfMenstrualPeriod': FormatDefinition(
        wideCount: 1,
        editable: true,
        fieldType: FieldType.date,
      ),
      'HPL': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.date,
      ),
      'Riwayat_alergi': FormatDefinition(
        wideCount: 8,
        newLine: true,
        multiLine: true,
        editable: true,
        maxLines: 7,
      ),
      'LaborSC': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'LaborSpontanNormal': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'LaborSpontanVacuum': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'BodyHeight': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'BodyWeight': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'SystolicPressure': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'DiastolicPressure': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'LILA': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'BMI': FormatDefinition(
        wideCount: 1,
        editable: true,
        newLine: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'ICD_10': FormatDefinition(
        wideCount: 4,
        newLine: true,
        editable: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Note': FormatDefinition(
        wideCount: 8,
        editable: true,
        multiLine: true,
        maxLines: 6,
      ),
      'InternalNote': FormatDefinition(
        wideCount: 8,
        multiLine: true,
        editable: true,
        maxLines: 7,
      ),
      'IsShowMore': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.boolean,
      ),
      'NutritionNotes': FormatDefinition(
        wideCount: 8,
        multiLine: true,
        newLine: true,
        editable: true,
        maxLines: 7,
      ),
      'Presentation': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'PlacentaGrade': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'PlacentaPosition': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Cairan_Ketuban': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Gender': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Weight': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'GS': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        newLine: true,
        fieldType: FieldType.number,
      ),
      'YS': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'DJJ': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'FL': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'CRL': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'BPD': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'HC': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'AC': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'SDP': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'AFI': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
    },
  };

  static FormatDefinition getConfig(
    String fieldName, {
    required String section,
  }) {
    final sectionMap = sectionConfigurations[section];
    if (sectionMap != null && sectionMap.containsKey(fieldName)) {
      return sectionMap[fieldName]!;
    }
    return const FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.text_fields,
    );
  }

  static List<String> orderedKeysForSection(String section) {
    final sectionMap = sectionConfigurations[section];
    if (sectionMap != null && sectionMap.isNotEmpty) {
      return sectionMap.keys.toList();
    }
    return const <String>[];
  }
}
