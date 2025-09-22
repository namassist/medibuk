// lib/domain/entities/general_info.dart
import 'package:json_annotation/json_annotation.dart';

part 'general_info.g.dart';

@JsonSerializable()
class GeneralInfo {
  final String propertyLabel;
  final dynamic id;
  final String identifier;
  @JsonKey(name: 'model-name')
  final String? modelName;

  const GeneralInfo({
    required this.propertyLabel,
    required this.id,
    required this.identifier,
    this.modelName,
  });

  factory GeneralInfo.fromJson(Map<String, dynamic> json) =>
      _$GeneralInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralInfoToJson(this);
}
