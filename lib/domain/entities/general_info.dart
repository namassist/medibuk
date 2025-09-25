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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneralInfo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          identifier == other.identifier &&
          modelName == other.modelName;

  @override
  int get hashCode => id.hashCode ^ identifier.hashCode ^ modelName.hashCode;
}
