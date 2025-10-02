import 'package:medibuk/domain/entities/record.dart';
import 'package:json_annotation/json_annotation.dart';
import 'general_info.dart';

export 'general_info.dart';
export 'obstetric_record.dart';
export 'gynecology_record.dart';
export 'prescription_record.dart';

part 'warehouse_record.g.dart';

@JsonSerializable()
class WarehouseRecord extends Record {
  @JsonKey(name: 'Name')
  final String? name;

  @JsonKey(name: 'C_Location_ID')
  final GeneralInfo? cLocation;

  @JsonKey(name: 'AD_Org_ID')
  final GeneralInfo? adOrg;

  @JsonKey(name: 'AD_Client_ID')
  final GeneralInfo? adClient;

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

  @JsonKey(name: 'Value')
  final String? value;

  @JsonKey(name: 'Separator')
  final String? separator;

  @JsonKey(name: 'IsInTransit')
  final bool? isInTransit;

  @JsonKey(name: 'IsDisallowNegativeInv')
  final bool? isDisallowNegativeInv;

  @JsonKey(name: 'M_ReserveLocator_ID')
  final GeneralInfo? mReserveLocator;

  @JsonKey(name: 'C_SalesRegion_ID')
  final GeneralInfo? cSalesRegion;

  @JsonKey(name: 'model-name')
  final String? modelName;

  const WarehouseRecord({
    required super.id,
    required super.uid,
    this.name,
    this.cLocation,
    this.adOrg,
    this.adClient,
    this.isActive,
    this.created,
    this.createdBy,
    this.updated,
    this.updatedBy,
    this.value,
    this.separator,
    this.isInTransit,
    this.isDisallowNegativeInv,
    this.mReserveLocator,
    this.cSalesRegion,
    this.modelName,
  });

  factory WarehouseRecord.fromJson(Map<String, dynamic> json) =>
      _$WarehouseRecordFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseRecordToJson(this);
}
