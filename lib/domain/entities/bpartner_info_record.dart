import 'package:json_annotation/json_annotation.dart';
import 'package:medibuk/domain/entities/general_info.dart';

part 'bpartner_info_record.g.dart';

@JsonSerializable(explicitToJson: true)
class BusinessPartnerInfoRecord {
  @JsonKey(name: 'C_BPartner_ID')
  final int id;
  @JsonKey(name: 'Name')
  final String? name;
  @JsonKey(name: 'Value')
  final String? value;
  @JsonKey(name: 'Birthday')
  final String? birthday;
  @JsonKey(name: 'Phone')
  final String? phone;
  @JsonKey(name: 'Address1')
  final String? address;
  @JsonKey(name: 'Gender')
  final GeneralInfo? gender;
  @JsonKey(name: 'NIK')
  final bool? hasNik;

  BusinessPartnerInfoRecord({
    required this.id,
    this.name,
    this.value,
    this.birthday,
    this.phone,
    this.address,
    this.gender,
    this.hasNik,
  });

  factory BusinessPartnerInfoRecord.fromJson(Map<String, dynamic> json) =>
      _$BusinessPartnerInfoRecordFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessPartnerInfoRecordToJson(this);
}
