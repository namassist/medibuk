// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalRecord _$MedicalRecordFromJson(
  Map<String, dynamic> json,
) => MedicalRecord(
  id: (json['id'] as num).toInt(),
  uid: json['uid'] as String,
  documentNo: json['DocumentNo'] as String,
  dateTrx: json['DateTrx'] as String,
  docStatus: GeneralInfo.fromJson(json['DocStatus'] as Map<String, dynamic>),
  gestationalAgeWeek: (json['GestationalAgeWeek'] as num?)?.toInt(),
  gestationalAgeDay: (json['GestationalAgeDay'] as num?)?.toInt(),
  adClientId: json['AD_Client_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Client_ID'] as Map<String, dynamic>),
  adOrgId: json['AD_Org_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Org_ID'] as Map<String, dynamic>),
  cSalesRegionId: json['C_SalesRegion_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_SalesRegion_ID'] as Map<String, dynamic>),
  orderTypeId: json['OrderType_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['OrderType_ID'] as Map<String, dynamic>),
  mSpecialistId: json['M_Specialist_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['M_Specialist_ID'] as Map<String, dynamic>),
  cBPartnerId: json['C_BPartner_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_BPartner_ID'] as Map<String, dynamic>),
  cEncounterId: json['C_Encounter_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_Encounter_ID'] as Map<String, dynamic>),
  processed: json['Processed'] as bool,
  obstetric: (json['obstetric'] as List<dynamic>?)
      ?.map((e) => ObstetricRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  gynecology: (json['gynecology'] as List<dynamic>?)
      ?.map((e) => GynecologyRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  dental: (json['dental'] as List<dynamic>?)
      ?.map((e) => DentalRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  anak: (json['medical-record-anak'] as List<dynamic>?)
      ?.map((e) => AnakRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  umum: (json['medical-record-umum'] as List<dynamic>?)
      ?.map((e) => UmumRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  laktasi: (json['laktasi'] as List<dynamic>?)
      ?.map((e) => LaktasiRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  andrologi: (json['andrologi'] as List<dynamic>?)
      ?.map((e) => AndrologiRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  services: (json['services'] as List<dynamic>?)
      ?.map((e) => ServiceRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  prescriptions: (json['prescriptions'] as List<dynamic>?)
      ?.map((e) => PrescriptionRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MedicalRecordToJson(MedicalRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'DocumentNo': instance.documentNo,
      'DateTrx': instance.dateTrx,
      'DocStatus': instance.docStatus,
      'GestationalAgeWeek': instance.gestationalAgeWeek,
      'GestationalAgeDay': instance.gestationalAgeDay,
      'AD_Client_ID': instance.adClientId,
      'AD_Org_ID': instance.adOrgId,
      'C_SalesRegion_ID': instance.cSalesRegionId,
      'OrderType_ID': instance.orderTypeId,
      'M_Specialist_ID': instance.mSpecialistId,
      'C_BPartner_ID': instance.cBPartnerId,
      'C_Encounter_ID': instance.cEncounterId,
      'Processed': instance.processed,
      'obstetric': instance.obstetric,
      'gynecology': instance.gynecology,
      'dental': instance.dental,
      'medical-record-anak': instance.anak,
      'medical-record-umum': instance.umum,
      'laktasi': instance.laktasi,
      'andrologi': instance.andrologi,
      'services': instance.services,
      'prescriptions': instance.prescriptions,
    };
