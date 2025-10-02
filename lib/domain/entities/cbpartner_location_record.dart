import 'package:json_annotation/json_annotation.dart';
import 'package:medibuk/domain/entities/record.dart';
import 'package:medibuk/domain/entities/general_info.dart';

part 'cbpartner_location_record.g.dart';

@JsonSerializable(explicitToJson: true)
class CBPartnerLocationRecord extends Record {
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
  @JsonKey(name: 'C_Location_ID')
  final GeneralInfo? cLocationId;
  @JsonKey(name: 'Name')
  final String? name;
  @JsonKey(name: 'IsBillTo')
  final bool? isBillTo;
  @JsonKey(name: 'IsShipTo')
  final bool? isShipTo;
  @JsonKey(name: 'IsPayFrom')
  final bool? isPayFrom;
  @JsonKey(name: 'IsRemitTo')
  final bool? isRemitTo;
  @JsonKey(name: 'IsPreserveCustomName')
  final bool? isPreserveCustomName;

  CBPartnerLocationRecord({
    required super.id,
    required super.uid,
    this.adClientId,
    this.adOrgId,
    this.isActive,
    this.created,
    this.createdBy,
    this.updated,
    this.updatedBy,
    this.cLocationId,
    this.name,
    this.isBillTo,
    this.isShipTo,
    this.isPayFrom,
    this.isRemitTo,
    this.isPreserveCustomName,
  });

  factory CBPartnerLocationRecord.fromJson(Map<String, dynamic> json) =>
      _$CBPartnerLocationRecordFromJson(json);
  Map<String, dynamic> toJson() => _$CBPartnerLocationRecordToJson(this);
}
