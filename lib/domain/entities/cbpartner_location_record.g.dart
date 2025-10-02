// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cbpartner_location_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CBPartnerLocationRecord _$CBPartnerLocationRecordFromJson(
  Map<String, dynamic> json,
) => CBPartnerLocationRecord(
  id: (json['id'] as num).toInt(),
  uid: json['uid'] as String,
  adClientId: json['AD_Client_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Client_ID'] as Map<String, dynamic>),
  adOrgId: json['AD_Org_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Org_ID'] as Map<String, dynamic>),
  isActive: json['IsActive'] as bool?,
  created: json['Created'] as String?,
  createdBy: json['CreatedBy'] == null
      ? null
      : GeneralInfo.fromJson(json['CreatedBy'] as Map<String, dynamic>),
  updated: json['Updated'] as String?,
  updatedBy: json['UpdatedBy'] == null
      ? null
      : GeneralInfo.fromJson(json['UpdatedBy'] as Map<String, dynamic>),
  cLocationId: json['C_Location_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_Location_ID'] as Map<String, dynamic>),
  name: json['Name'] as String?,
  isBillTo: json['IsBillTo'] as bool?,
  isShipTo: json['IsShipTo'] as bool?,
  isPayFrom: json['IsPayFrom'] as bool?,
  isRemitTo: json['IsRemitTo'] as bool?,
  isPreserveCustomName: json['IsPreserveCustomName'] as bool?,
);

Map<String, dynamic> _$CBPartnerLocationRecordToJson(
  CBPartnerLocationRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'uid': instance.uid,
  'AD_Client_ID': instance.adClientId?.toJson(),
  'AD_Org_ID': instance.adOrgId?.toJson(),
  'IsActive': instance.isActive,
  'Created': instance.created,
  'CreatedBy': instance.createdBy?.toJson(),
  'Updated': instance.updated,
  'UpdatedBy': instance.updatedBy?.toJson(),
  'C_Location_ID': instance.cLocationId?.toJson(),
  'Name': instance.name,
  'IsBillTo': instance.isBillTo,
  'IsShipTo': instance.isShipTo,
  'IsPayFrom': instance.isPayFrom,
  'IsRemitTo': instance.isRemitTo,
  'IsPreserveCustomName': instance.isPreserveCustomName,
};
