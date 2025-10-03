// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bpartner_info_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessPartnerInfoRecord _$BusinessPartnerInfoRecordFromJson(
  Map<String, dynamic> json,
) => BusinessPartnerInfoRecord(
  id: (json['C_BPartner_ID'] as num).toInt(),
  name: json['Name'] as String?,
  value: json['Value'] as String?,
  birthday: json['Birthday'] as String?,
  phone: json['Phone'] as String?,
  address: json['Address1'] as String?,
  gender: json['Gender'] == null
      ? null
      : GeneralInfo.fromJson(json['Gender'] as Map<String, dynamic>),
  hasNik: json['NIK'] as bool?,
);

Map<String, dynamic> _$BusinessPartnerInfoRecordToJson(
  BusinessPartnerInfoRecord instance,
) => <String, dynamic>{
  'C_BPartner_ID': instance.id,
  'Name': instance.name,
  'Value': instance.value,
  'Birthday': instance.birthday,
  'Phone': instance.phone,
  'Address1': instance.address,
  'Gender': instance.gender?.toJson(),
  'NIK': instance.hasNik,
};
