import 'package:json_annotation/json_annotation.dart';

part 'medical_record.g.dart';

@JsonSerializable()
class MedicalRecord {
  final int id;
  final String uid;
  @JsonKey(name: 'DocumentNo')
  final String documentNo;
  @JsonKey(name: 'DateTrx')
  final String dateTrx;
  @JsonKey(name: 'DocStatus')
  final GeneralInfo docStatus;
  @JsonKey(name: 'GestationalAgeWeek')
  final int? gestationalAgeWeek;
  @JsonKey(name: 'GestationalAgeDay')
  final int? gestationalAgeDay;
  @JsonKey(name: 'AD_Client_ID')
  final GeneralInfo? adClientId;
  @JsonKey(name: 'AD_Org_ID')
  final GeneralInfo? adOrgId;
  @JsonKey(name: 'C_SalesRegion_ID')
  final GeneralInfo? cSalesRegionId;
  @JsonKey(name: 'OrderType_ID')
  final GeneralInfo? orderTypeId;
  @JsonKey(name: 'M_Specialist_ID')
  final GeneralInfo? mSpecialistId;
  @JsonKey(name: 'C_BPartner_ID')
  final GeneralInfo? cBPartnerId;
  final bool processed;
  final List<ObstetricRecord> obstetric;
  final List<GynecologyRecord> gynecology;
  final List<PrescriptionRecord> prescriptions;

  const MedicalRecord({
    required this.id,
    required this.uid,
    required this.documentNo,
    required this.dateTrx,
    required this.docStatus,
    this.gestationalAgeWeek,
    this.gestationalAgeDay,
    this.adClientId,
    this.adOrgId,
    this.cSalesRegionId,
    this.orderTypeId,
    this.mSpecialistId,
    this.cBPartnerId,
    required this.processed,
    required this.obstetric,
    required this.gynecology,
    required this.prescriptions,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) =>
      _$MedicalRecordFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalRecordToJson(this);
}

@JsonSerializable()
class GeneralInfo {
  final String propertyLabel;
  final dynamic id;
  final String identifier;
  @JsonKey(name: 'model-name')
  final String modelName;

  const GeneralInfo({
    required this.propertyLabel,
    required this.id,
    required this.identifier,
    required this.modelName,
  });

  factory GeneralInfo.fromJson(Map<String, dynamic> json) =>
      _$GeneralInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralInfoToJson(this);
}

// Partial models for demonstration (1/8 of complete structure)
@JsonSerializable()
class ObstetricRecord {
  final int id;
  final String uid;
  @JsonKey(name: 'Doctor_ID')
  final GeneralInfo? doctorId;
  @JsonKey(name: 'VisitDate')
  final String? visitDate;
  @JsonKey(name: 'NextVisitDate')
  final String? nextVisitDate;
  @JsonKey(name: 'ChiefComplaint')
  final String? chiefComplaint;
  @JsonKey(name: 'BodyTemperature')
  final num? bodyTemperature;
  @JsonKey(name: 'SystolicPressure')
  final num? systolicPressure;
  @JsonKey(name: 'DiastolicPressure')
  final num? diastolicPressure;

  const ObstetricRecord({
    required this.id,
    required this.uid,
    this.doctorId,
    this.visitDate,
    this.nextVisitDate,
    this.chiefComplaint,
    this.bodyTemperature,
    this.systolicPressure,
    this.diastolicPressure,
  });

  factory ObstetricRecord.fromJson(Map<String, dynamic> json) =>
      _$ObstetricRecordFromJson(json);

  Map<String, dynamic> toJson() => _$ObstetricRecordToJson(this);
}

@JsonSerializable()
class GynecologyRecord {
  final int id;
  final String uid;
  @JsonKey(name: 'Doctor_ID')
  final GeneralInfo? doctorId;
  @JsonKey(name: 'ChiefComplaint')
  final String? chiefComplaint;
  @JsonKey(name: 'BodyWeight')
  final num? bodyWeight;
  @JsonKey(name: 'BodyHeight')
  final num? bodyHeight;

  const GynecologyRecord({
    required this.id,
    required this.uid,
    this.doctorId,
    this.chiefComplaint,
    this.bodyWeight,
    this.bodyHeight,
  });

  factory GynecologyRecord.fromJson(Map<String, dynamic> json) =>
      _$GynecologyRecordFromJson(json);

  Map<String, dynamic> toJson() => _$GynecologyRecordToJson(this);
}

@JsonSerializable()
class PrescriptionRecord {
  final int id;
  final String uid;
  @JsonKey(name: 'M_Product_ID')
  final GeneralInfo? mProductId;
  @JsonKey(name: 'Qty')
  final num? qty;
  @JsonKey(name: 'Description')
  final String? description;

  const PrescriptionRecord({
    required this.id,
    required this.uid,
    this.mProductId,
    this.qty,
    this.description,
  });

  factory PrescriptionRecord.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionRecordFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionRecordToJson(this);
}
