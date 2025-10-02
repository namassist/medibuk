// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseRecord _$WarehouseRecordFromJson(Map<String, dynamic> json) =>
    WarehouseRecord(
      id: (json['id'] as num).toInt(),
      uid: json['uid'] as String,
      name: json['Name'] as String?,
      cLocation: json['C_Location_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['C_Location_ID'] as Map<String, dynamic>),
      adOrg: json['AD_Org_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['AD_Org_ID'] as Map<String, dynamic>),
      adClient: json['AD_Client_ID'] == null
          ? null
          : GeneralInfo.fromJson(json['AD_Client_ID'] as Map<String, dynamic>),
      isActive: json['IsActive'] as bool?,
      created: json['Created'] as String?,
      createdBy: json['CreatedBy'] == null
          ? null
          : GeneralInfo.fromJson(json['CreatedBy'] as Map<String, dynamic>),
      updated: json['Updated'] as String?,
      updatedBy: json['UpdatedBy'] == null
          ? null
          : GeneralInfo.fromJson(json['UpdatedBy'] as Map<String, dynamic>),
      value: json['Value'] as String?,
      separator: json['Separator'] as String?,
      isInTransit: json['IsInTransit'] as bool?,
      isDisallowNegativeInv: json['IsDisallowNegativeInv'] as bool?,
      mReserveLocator: json['M_ReserveLocator_ID'] == null
          ? null
          : GeneralInfo.fromJson(
              json['M_ReserveLocator_ID'] as Map<String, dynamic>,
            ),
      cSalesRegion: json['C_SalesRegion_ID'] == null
          ? null
          : GeneralInfo.fromJson(
              json['C_SalesRegion_ID'] as Map<String, dynamic>,
            ),
      modelName: json['model-name'] as String?,
    );

Map<String, dynamic> _$WarehouseRecordToJson(WarehouseRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'Name': instance.name,
      'C_Location_ID': instance.cLocation,
      'AD_Org_ID': instance.adOrg,
      'AD_Client_ID': instance.adClient,
      'IsActive': instance.isActive,
      'Created': instance.created,
      'CreatedBy': instance.createdBy,
      'Updated': instance.updated,
      'UpdatedBy': instance.updatedBy,
      'Value': instance.value,
      'Separator': instance.separator,
      'IsInTransit': instance.isInTransit,
      'IsDisallowNegativeInv': instance.isDisallowNegativeInv,
      'M_ReserveLocator_ID': instance.mReserveLocator,
      'C_SalesRegion_ID': instance.cSalesRegion,
      'model-name': instance.modelName,
    };
