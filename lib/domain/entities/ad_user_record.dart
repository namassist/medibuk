import 'package:json_annotation/json_annotation.dart';
import 'package:medibuk/domain/entities/record.dart';
import 'package:medibuk/domain/entities/general_info.dart';

part 'ad_user_record.g.dart';

@JsonSerializable(explicitToJson: true)
class ADUserRecord extends Record {
  @JsonKey(name: 'Name')
  final String? name;
  @JsonKey(name: 'AD_Client_ID')
  final GeneralInfo? adClientId;
  @JsonKey(name: 'AD_Org_ID')
  final GeneralInfo? adOrgId;
  @JsonKey(name: 'IsActive')
  final bool? isActive;
  @JsonKey(name: 'Created')
  final String? created;
  @JsonKey(name: 'CreatedBy')
  final GeneralInfo? createdBy;
  @JsonKey(name: 'Updated')
  final String? updated;
  @JsonKey(name: 'UpdatedBy')
  final GeneralInfo? updatedBy;
  @JsonKey(name: 'EMail')
  final String? email;
  @JsonKey(name: 'Birthday')
  final String? birthday;
  @JsonKey(name: 'Phone')
  final String? phone;
  @JsonKey(name: 'LDAPUser')
  final String? ldapUser;
  @JsonKey(name: 'NotificationType')
  final GeneralInfo? notificationType;
  @JsonKey(name: 'IsFullBPAccess')
  final bool? isFullBPAccess;
  @JsonKey(name: 'Value')
  final String? value;
  @JsonKey(name: 'IsInPayroll')
  final bool? isInPayroll;
  @JsonKey(name: 'IsSalesLead')
  final bool? isSalesLead;
  @JsonKey(name: 'IsLocked')
  final bool? isLocked;
  @JsonKey(name: 'FailedLoginCount')
  final int? failedLoginCount;
  @JsonKey(name: 'DateLastLogin')
  final String? dateLastLogin;
  @JsonKey(name: 'IsNoPasswordReset')
  final bool? isNoPasswordReset;
  @JsonKey(name: 'IsExpired')
  final bool? isExpired;
  @JsonKey(name: 'IsAddMailTextAutomatically')
  final bool? isAddMailTextAutomatically;
  @JsonKey(name: 'IsNoExpire')
  final bool? isNoExpire;
  @JsonKey(name: 'IsSupportUser')
  final bool? isSupportUser;
  @JsonKey(name: 'IsShipTo')
  final bool? isShipTo;
  @JsonKey(name: 'IsBillTo')
  final bool? isBillTo;
  @JsonKey(name: 'Gender')
  final GeneralInfo? gender;
  @JsonKey(name: 'LastLoginToken')
  final String? lastLoginToken;
  @JsonKey(name: 'Absent')
  final int? absent;

  ADUserRecord({
    required super.id,
    required super.uid,
    this.name,
    this.adClientId,
    this.adOrgId,
    this.isActive,
    this.created,
    this.createdBy,
    this.updated,
    this.updatedBy,
    this.email,
    this.birthday,
    this.phone,
    this.ldapUser,
    this.notificationType,
    this.isFullBPAccess,
    this.value,
    this.isInPayroll,
    this.isSalesLead,
    this.isLocked,
    this.failedLoginCount,
    this.dateLastLogin,
    this.isNoPasswordReset,
    this.isExpired,
    this.isAddMailTextAutomatically,
    this.isNoExpire,
    this.isSupportUser,
    this.isShipTo,
    this.isBillTo,
    this.gender,
    this.lastLoginToken,
    this.absent,
  });

  factory ADUserRecord.fromJson(Map<String, dynamic> json) =>
      _$ADUserRecordFromJson(json);
  Map<String, dynamic> toJson() => _$ADUserRecordToJson(this);
}
