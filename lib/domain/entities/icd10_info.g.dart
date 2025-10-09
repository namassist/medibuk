// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icd10_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Icd10Info _$Icd10InfoFromJson(Map<String, dynamic> json) => Icd10Info(
  id: (json['C_ICD10_ID'] as num).toInt(),
  value: json['Value'] as String?,
  name: json['Name'] as String?,
  nameIdn: json['name_idn'] as String?,
  categoryID: json['C_ICD10_Category_ID'] == null
      ? null
      : GeneralInfo.fromJson(
          json['C_ICD10_Category_ID'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$Icd10InfoToJson(Icd10Info instance) => <String, dynamic>{
  'C_ICD10_ID': instance.id,
  'Value': instance.value,
  'Name': instance.name,
  'name_idn': instance.nameIdn,
  'C_ICD10_Category_ID': instance.categoryID,
};
