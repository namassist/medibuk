import 'package:json_annotation/json_annotation.dart';
import 'package:medibuk/domain/entities/warehouse_record.dart';

part 'icd10_info.g.dart';

@JsonSerializable()
class Icd10Info {
  @JsonKey(name: 'C_ICD10_ID')
  final int id;
  @JsonKey(name: 'Value')
  final String? value;
  @JsonKey(name: 'Name')
  final String? name;
  @JsonKey(name: 'name_idn')
  final String? nameIdn;
  @JsonKey(name: 'C_ICD10_Category_ID')
  final GeneralInfo? categoryID;

  const Icd10Info({
    required this.id,
    this.value,
    this.name,
    this.nameIdn,
    this.categoryID,
  });

  factory Icd10Info.fromJson(Map<String, dynamic> json) =>
      _$Icd10InfoFromJson(json);

  Map<String, dynamic> toJson() => _$Icd10InfoToJson(this);
}
