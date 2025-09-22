// lib/domain/entities/prescription_record.dart
import 'package:json_annotation/json_annotation.dart';
import 'general_info.dart';

part 'prescription_record.g.dart';

@JsonSerializable()
class PrescriptionRecord {
  final int id;
  final String uid;
  @JsonKey(name: 'AD_Client_ID')
  final GeneralInfo? adClientId;
  @JsonKey(name: 'AD_Org_ID')
  final GeneralInfo? adOrgId;
  @JsonKey(name: 'LineNo')
  final int? lineNo;
  @JsonKey(name: 'C_MedicalRecord_ID')
  final GeneralInfo? cMedicalRecordId;
  @JsonKey(name: 'M_Product_ID')
  final GeneralInfo? mProductId;
  @JsonKey(name: 'Qty')
  final num? qty;
  @JsonKey(name: 'isMedicationCompund')
  final GeneralInfo? isMedicationCompund;
  @JsonKey(name: 'QtyOnHand')
  final num? qtyOnHand;
  @JsonKey(name: 'IsActive')
  final bool? isActive;
  @JsonKey(name: 'Description')
  final String? description;

  const PrescriptionRecord({
    required this.id,
    required this.uid,
    this.adClientId,
    this.adOrgId,
    this.lineNo,
    this.cMedicalRecordId,
    this.mProductId,
    this.qty,
    this.isMedicationCompund,
    this.qtyOnHand,
    this.isActive,
    this.description,
  });

  factory PrescriptionRecord.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionRecordFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionRecordToJson(this);
}
