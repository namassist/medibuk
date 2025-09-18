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
  processed: json['processed'] as bool,
  obstetric: (json['obstetric'] as List<dynamic>)
      .map((e) => ObstetricRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  gynecology: (json['gynecology'] as List<dynamic>)
      .map((e) => GynecologyRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  prescriptions: (json['prescriptions'] as List<dynamic>)
      .map((e) => PrescriptionRecord.fromJson(e as Map<String, dynamic>))
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
      'processed': instance.processed,
      'obstetric': instance.obstetric,
      'gynecology': instance.gynecology,
      'prescriptions': instance.prescriptions,
    };

GeneralInfo _$GeneralInfoFromJson(Map<String, dynamic> json) => GeneralInfo(
  propertyLabel: json['propertyLabel'] as String,
  id: json['id'],
  identifier: json['identifier'] as String,
  modelName: json['model-name'] as String,
);

Map<String, dynamic> _$GeneralInfoToJson(GeneralInfo instance) =>
    <String, dynamic>{
      'propertyLabel': instance.propertyLabel,
      'id': instance.id,
      'identifier': instance.identifier,
      'model-name': instance.modelName,
    };

ObstetricRecord _$ObstetricRecordFromJson(Map<String, dynamic> json) =>
    ObstetricRecord(
      id: (json['id'] as num).toInt(),
      uid: json['uid'] as String,
      doctorId: json['Doctor_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['Doctor_ID'] as Map<String, dynamic>),
      visitDate: json['VisitDate'] as String?,
      nextVisitDate: json['NextVisitDate'] as String?,
      chiefComplaint: json['ChiefComplaint'] as String?,
      bodyTemperature: json['BodyTemperature'] as num?,
      systolicPressure: json['SystolicPressure'] as num?,
      diastolicPressure: json['DiastolicPressure'] as num?,
    );

Map<String, dynamic> _$ObstetricRecordToJson(ObstetricRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'Doctor_ID': instance.doctorId,
      'VisitDate': instance.visitDate,
      'NextVisitDate': instance.nextVisitDate,
      'ChiefComplaint': instance.chiefComplaint,
      'BodyTemperature': instance.bodyTemperature,
      'SystolicPressure': instance.systolicPressure,
      'DiastolicPressure': instance.diastolicPressure,
    };

GynecologyRecord _$GynecologyRecordFromJson(Map<String, dynamic> json) =>
    GynecologyRecord(
      id: (json['id'] as num).toInt(),
      uid: json['uid'] as String,
      doctorId: json['Doctor_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['Doctor_ID'] as Map<String, dynamic>),
      chiefComplaint: json['ChiefComplaint'] as String?,
      bodyWeight: json['BodyWeight'] as num?,
      bodyHeight: json['BodyHeight'] as num?,
    );

Map<String, dynamic> _$GynecologyRecordToJson(GynecologyRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'Doctor_ID': instance.doctorId,
      'ChiefComplaint': instance.chiefComplaint,
      'BodyWeight': instance.bodyWeight,
      'BodyHeight': instance.bodyHeight,
    };

PrescriptionRecord _$PrescriptionRecordFromJson(Map<String, dynamic> json) =>
    PrescriptionRecord(
      id: (json['id'] as num).toInt(),
      uid: json['uid'] as String,
      mProductId: json['M_Product_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['M_Product_ID'] as Map<String, dynamic>),
      qty: json['Qty'] as num?,
      description: json['Description'] as String?,
    );

Map<String, dynamic> _$PrescriptionRecordToJson(PrescriptionRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'M_Product_ID': instance.mProductId,
      'Qty': instance.qty,
      'Description': instance.description,
    };
