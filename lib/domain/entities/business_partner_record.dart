import 'package:json_annotation/json_annotation.dart';
import 'package:medibuk/domain/entities/ad_user_record.dart';
import 'package:medibuk/domain/entities/cbpartner_location_record.dart';
import 'package:medibuk/domain/entities/record.dart';
import 'package:medibuk/domain/entities/general_info.dart';

part 'business_partner_record.g.dart';

@JsonSerializable(explicitToJson: true)
class BusinessPartnerRecord extends Record {
  @JsonKey(name: 'AD_Client_ID')
  final GeneralInfo? adClientId;
  @JsonKey(name: 'AD_Org_ID')
  final GeneralInfo? adOrgId;
  @JsonKey(name: 'IsActive')
  final bool? isActive;
  @JsonKey(name: 'Created')
  final String? created;
  @JsonKey(name: 'CreatedBy')
  final GeneralInfo? createdBy;
  @JsonKey(name: 'Updated')
  final String? updated;
  @JsonKey(name: 'UpdatedBy')
  final GeneralInfo? updatedBy;
  @JsonKey(name: 'Value')
  final String? value;
  @JsonKey(name: 'Name')
  final String? name;
  @JsonKey(name: 'SalesVolume')
  final int? salesVolume;
  @JsonKey(name: 'IsSummary')
  final bool? isSummary;
  @JsonKey(name: 'IsVendor')
  final bool? isVendor;
  @JsonKey(name: 'IsCustomer')
  final bool? isCustomer;
  @JsonKey(name: 'IsProspect')
  final bool? isProspect;
  @JsonKey(name: 'SO_CreditLimit')
  final double? soCreditLimit;
  @JsonKey(name: 'SO_CreditUsed')
  final double? soCreditUsed;
  @JsonKey(name: 'AcqusitionCost')
  final double? acqusitionCost;
  @JsonKey(name: 'PotentialLifeTimeValue')
  final double? potentialLifeTimeValue;
  @JsonKey(name: 'C_PaymentTerm_ID')
  final GeneralInfo? cPaymentTermId;
  @JsonKey(name: 'ActualLifeTimeValue')
  final double? actualLifeTimeValue;
  @JsonKey(name: 'ShareOfCustomer')
  final int? shareOfCustomer;
  @JsonKey(name: 'IsEmployee')
  final bool? isEmployee;
  @JsonKey(name: 'IsSalesRep')
  final bool? isSalesRep;
  @JsonKey(name: 'PO_PriceList_ID')
  final GeneralInfo? poPriceListId;
  @JsonKey(name: 'IsOneTime')
  final bool? isOneTime;
  @JsonKey(name: 'IsTaxExempt')
  final bool? isTaxExempt;
  @JsonKey(name: 'IsDiscountPrinted')
  final bool? isDiscountPrinted;
  @JsonKey(name: 'SalesRep_ID')
  final GeneralInfo? salesRepId;
  @JsonKey(name: 'C_BP_Group_ID')
  final GeneralInfo? cBpGroupId;
  @JsonKey(name: 'PO_PaymentTerm_ID')
  final GeneralInfo? poPaymentTermId;
  @JsonKey(name: 'SendEMail')
  final bool? sendEMail;
  @JsonKey(name: 'SOCreditStatus')
  final GeneralInfo? soCreditStatus;
  @JsonKey(name: 'TotalOpenBalance')
  final double? totalOpenBalance;
  @JsonKey(name: 'IsPOTaxExempt')
  final bool? isPOTaxExempt;
  @JsonKey(name: 'IsManufacturer')
  final bool? isManufacturer;
  @JsonKey(name: 'Is1099Vendor')
  final bool? is1099Vendor;
  @JsonKey(name: 'IsReferral')
  final bool? isReferral;
  @JsonKey(name: 'C_SalesRegion_ID')
  final GeneralInfo? cSalesRegionId;
  @JsonKey(name: 'Promo')
  final bool? promo;
  @JsonKey(name: 'model-name')
  final String? modelName;
  @JsonKey(name: 'AD_User')
  final List<ADUserRecord>? adUser;
  @JsonKey(name: 'C_BPartner_Location')
  final List<CBPartnerLocationRecord>? cBpartnerLocation;

  BusinessPartnerRecord({
    required super.id,
    required super.uid,
    this.adClientId,
    this.adOrgId,
    this.isActive,
    this.created,
    this.createdBy,
    this.updated,
    this.updatedBy,
    this.value,
    this.name,
    this.salesVolume,
    this.isSummary,
    this.isVendor,
    this.isCustomer,
    this.isProspect,
    this.soCreditLimit,
    this.soCreditUsed,
    this.acqusitionCost,
    this.potentialLifeTimeValue,
    this.cPaymentTermId,
    this.actualLifeTimeValue,
    this.shareOfCustomer,
    this.isEmployee,
    this.isSalesRep,
    this.poPriceListId,
    this.isOneTime,
    this.isTaxExempt,
    this.isDiscountPrinted,
    this.salesRepId,
    this.cBpGroupId,
    this.poPaymentTermId,
    this.sendEMail,
    this.soCreditStatus,
    this.totalOpenBalance,
    this.isPOTaxExempt,
    this.isManufacturer,
    this.is1099Vendor,
    this.isReferral,
    this.cSalesRegionId,
    this.promo,
    this.modelName,
    this.adUser,
    this.cBpartnerLocation,
  });

  String? get phone =>
      (adUser?.isNotEmpty ?? false) ? adUser!.first.phone : null;
  String? get birthday =>
      (adUser?.isNotEmpty ?? false) ? adUser!.first.birthday : null;

  factory BusinessPartnerRecord.fromJson(Map<String, dynamic> json) =>
      _$BusinessPartnerRecordFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessPartnerRecordToJson(this);
}
