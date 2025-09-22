// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralInfo _$GeneralInfoFromJson(Map<String, dynamic> json) => GeneralInfo(
  propertyLabel: json['propertyLabel'] as String,
  id: json['id'],
  identifier: json['identifier'] as String,
  modelName: json['model-name'] as String?,
);

Map<String, dynamic> _$GeneralInfoToJson(GeneralInfo instance) =>
    <String, dynamic>{
      'propertyLabel': instance.propertyLabel,
      'id': instance.id,
      'identifier': instance.identifier,
      'model-name': instance.modelName,
    };
