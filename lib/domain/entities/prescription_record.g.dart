// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionRecord _$PrescriptionRecordFromJson(Map<String, dynamic> json) =>
    PrescriptionRecord(
      id: (json['id'] as num).toInt(),
      uid: json['uid'] as String,
      adClientId: json['AD_Client_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['AD_Client_ID'] as Map<String, dynamic>),
      adOrgId: json['AD_Org_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['AD_Org_ID'] as Map<String, dynamic>),
      lineNo: (json['LineNo'] as num?)?.toInt(),
      cMedicalRecordId: json['C_MedicalRecord_ID'] == null
          ? null
          : GeneralInfo.fromJson(
              json['C_MedicalRecord_ID'] as Map<String, dynamic>,
            ),
      mProductId: json['M_Product_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['M_Product_ID'] as Map<String, dynamic>),
      qty: json['Qty'] as num?,
      isMedicationCompund: json['isMedicationCompund'] == null
          ? null
          : GeneralInfo.fromJson(
              json['isMedicationCompund'] as Map<String, dynamic>,
            ),
      qtyOnHand: json['QtyOnHand'] as num?,
      isActive: json['IsActive'] as bool?,
      description: json['Description'] as String?,
    );

Map<String, dynamic> _$PrescriptionRecordToJson(PrescriptionRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'AD_Client_ID': instance.adClientId,
      'AD_Org_ID': instance.adOrgId,
      'LineNo': instance.lineNo,
      'C_MedicalRecord_ID': instance.cMedicalRecordId,
      'M_Product_ID': instance.mProductId,
      'Qty': instance.qty,
      'isMedicationCompund': instance.isMedicationCompund,
      'QtyOnHand': instance.qtyOnHand,
      'IsActive': instance.isActive,
      'Description': instance.description,
    };
