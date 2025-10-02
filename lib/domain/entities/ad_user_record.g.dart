// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_user_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ADUserRecord _$ADUserRecordFromJson(Map<String, dynamic> json) => ADUserRecord(
  id: (json['id'] as num).toInt(),
  uid: json['uid'] as String,
  name: json['Name'] as String?,
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
  email: json['EMail'] as String?,
  birthday: json['Birthday'] as String?,
  phone: json['Phone'] as String?,
  ldapUser: json['LDAPUser'] as String?,
  notificationType: json['NotificationType'] == null
      ? null
      : GeneralInfo.fromJson(json['NotificationType'] as Map<String, dynamic>),
  isFullBPAccess: json['IsFullBPAccess'] as bool?,
  value: json['Value'] as String?,
  isInPayroll: json['IsInPayroll'] as bool?,
  isSalesLead: json['IsSalesLead'] as bool?,
  isLocked: json['IsLocked'] as bool?,
  failedLoginCount: (json['FailedLoginCount'] as num?)?.toInt(),
  dateLastLogin: json['DateLastLogin'] as String?,
  isNoPasswordReset: json['IsNoPasswordReset'] as bool?,
  isExpired: json['IsExpired'] as bool?,
  isAddMailTextAutomatically: json['IsAddMailTextAutomatically'] as bool?,
  isNoExpire: json['IsNoExpire'] as bool?,
  isSupportUser: json['IsSupportUser'] as bool?,
  isShipTo: json['IsShipTo'] as bool?,
  isBillTo: json['IsBillTo'] as bool?,
  gender: json['Gender'] == null
      ? null
      : GeneralInfo.fromJson(json['Gender'] as Map<String, dynamic>),
  lastLoginToken: json['LastLoginToken'] as String?,
  absent: (json['Absent'] as num?)?.toInt(),
);

Map<String, dynamic> _$ADUserRecordToJson(ADUserRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'Name': instance.name,
      'AD_Client_ID': instance.adClientId?.toJson(),
      'AD_Org_ID': instance.adOrgId?.toJson(),
      'IsActive': instance.isActive,
      'Created': instance.created,
      'CreatedBy': instance.createdBy?.toJson(),
      'Updated': instance.updated,
      'UpdatedBy': instance.updatedBy?.toJson(),
      'EMail': instance.email,
      'Birthday': instance.birthday,
      'Phone': instance.phone,
      'LDAPUser': instance.ldapUser,
      'NotificationType': instance.notificationType?.toJson(),
      'IsFullBPAccess': instance.isFullBPAccess,
      'Value': instance.value,
      'IsInPayroll': instance.isInPayroll,
      'IsSalesLead': instance.isSalesLead,
      'IsLocked': instance.isLocked,
      'FailedLoginCount': instance.failedLoginCount,
      'DateLastLogin': instance.dateLastLogin,
      'IsNoPasswordReset': instance.isNoPasswordReset,
      'IsExpired': instance.isExpired,
      'IsAddMailTextAutomatically': instance.isAddMailTextAutomatically,
      'IsNoExpire': instance.isNoExpire,
      'IsSupportUser': instance.isSupportUser,
      'IsShipTo': instance.isShipTo,
      'IsBillTo': instance.isBillTo,
      'Gender': instance.gender?.toJson(),
      'LastLoginToken': instance.lastLoginToken,
      'Absent': instance.absent,
    };
