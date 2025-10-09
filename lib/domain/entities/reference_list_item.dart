import 'package:json_annotation/json_annotation.dart';

part 'reference_list_item.g.dart';

@JsonSerializable()
class ReferenceList {
  @JsonKey(name: 'value')
  final String value;
  @JsonKey(name: 'name')
  final String name;

  const ReferenceList({required this.value, required this.name});

  factory ReferenceList.fromJson(Map<String, dynamic> json) =>
      _$ReferenceListFromJson(json);

  Map<String, dynamic> toJson() => _$ReferenceListToJson(this);
}
