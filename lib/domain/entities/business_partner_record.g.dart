// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_partner_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessPartnerRecord _$BusinessPartnerRecordFromJson(
  Map<String, dynamic> json,
) => BusinessPartnerRecord(
  id: (json['id'] as num).toInt(),
  uid: json['uid'] as String,
  adClientId: json['AD_Client_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Client_ID'] as Map<String, dynamic>),
  adOrgId: json['AD_Org_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['AD_Org_ID'] as Map<String, dynamic>),
  isActive: json['IsActive'] as bool?,
  created: json['Created'] as String?,
  createdBy: json['CreatedBy'] == null
      ? null
      : GeneralInfo.fromJson(json['CreatedBy'] as Map<String, dynamic>),
  updated: json['Updated'] as String?,
  updatedBy: json['UpdatedBy'] == null
      ? null
      : GeneralInfo.fromJson(json['UpdatedBy'] as Map<String, dynamic>),
  value: json['Value'] as String?,
  name: json['Name'] as String?,
  salesVolume: (json['SalesVolume'] as num?)?.toInt(),
  isSummary: json['IsSummary'] as bool?,
  isVendor: json['IsVendor'] as bool?,
  isCustomer: json['IsCustomer'] as bool?,
  isProspect: json['IsProspect'] as bool?,
  soCreditLimit: (json['SO_CreditLimit'] as num?)?.toDouble(),
  soCreditUsed: (json['SO_CreditUsed'] as num?)?.toDouble(),
  acqusitionCost: (json['AcqusitionCost'] as num?)?.toDouble(),
  potentialLifeTimeValue: (json['PotentialLifeTimeValue'] as num?)?.toDouble(),
  cPaymentTermId: json['C_PaymentTerm_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_PaymentTerm_ID'] as Map<String, dynamic>),
  actualLifeTimeValue: (json['ActualLifeTimeValue'] as num?)?.toDouble(),
  shareOfCustomer: (json['ShareOfCustomer'] as num?)?.toInt(),
  isEmployee: json['IsEmployee'] as bool?,
  isSalesRep: json['IsSalesRep'] as bool?,
  poPriceListId: json['PO_PriceList_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['PO_PriceList_ID'] as Map<String, dynamic>),
  isOneTime: json['IsOneTime'] as bool?,
  isTaxExempt: json['IsTaxExempt'] as bool?,
  isDiscountPrinted: json['IsDiscountPrinted'] as bool?,
  salesRepId: json['SalesRep_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['SalesRep_ID'] as Map<String, dynamic>),
  cBpGroupId: json['C_BP_Group_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_BP_Group_ID'] as Map<String, dynamic>),
  poPaymentTermId: json['PO_PaymentTerm_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['PO_PaymentTerm_ID'] as Map<String, dynamic>),
  sendEMail: json['SendEMail'] as bool?,
  soCreditStatus: json['SOCreditStatus'] == null
      ? null
      : GeneralInfo.fromJson(json['SOCreditStatus'] as Map<String, dynamic>),
  totalOpenBalance: (json['TotalOpenBalance'] as num?)?.toDouble(),
  isPOTaxExempt: json['IsPOTaxExempt'] as bool?,
  isManufacturer: json['IsManufacturer'] as bool?,
  is1099Vendor: json['Is1099Vendor'] as bool?,
  isReferral: json['IsReferral'] as bool?,
  cSalesRegionId: json['C_SalesRegion_ID'] == null
      ? null
      : GeneralInfo.fromJson(json['C_SalesRegion_ID'] as Map<String, dynamic>),
  promo: json['Promo'] as bool?,
  modelName: json['model-name'] as String?,
  adUser: (json['AD_User'] as List<dynamic>?)
      ?.map((e) => ADUserRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  cBpartnerLocation: (json['C_BPartner_Location'] as List<dynamic>?)
      ?.map((e) => CBPartnerLocationRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BusinessPartnerRecordToJson(
  BusinessPartnerRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'uid': instance.uid,
  'AD_Client_ID': instance.adClientId?.toJson(),
  'AD_Org_ID': instance.adOrgId?.toJson(),
  'IsActive': instance.isActive,
  'Created': instance.created,
  'CreatedBy': instance.createdBy?.toJson(),
  'Updated': instance.updated,
  'UpdatedBy': instance.updatedBy?.toJson(),
  'Value': instance.value,
  'Name': instance.name,
  'SalesVolume': instance.salesVolume,
  'IsSummary': instance.isSummary,
  'IsVendor': instance.isVendor,
  'IsCustomer': instance.isCustomer,
  'IsProspect': instance.isProspect,
  'SO_CreditLimit': instance.soCreditLimit,
  'SO_CreditUsed': instance.soCreditUsed,
  'AcqusitionCost': instance.acqusitionCost,
  'PotentialLifeTimeValue': instance.potentialLifeTimeValue,
  'C_PaymentTerm_ID': instance.cPaymentTermId?.toJson(),
  'ActualLifeTimeValue': instance.actualLifeTimeValue,
  'ShareOfCustomer': instance.shareOfCustomer,
  'IsEmployee': instance.isEmployee,
  'IsSalesRep': instance.isSalesRep,
  'PO_PriceList_ID': instance.poPriceListId?.toJson(),
  'IsOneTime': instance.isOneTime,
  'IsTaxExempt': instance.isTaxExempt,
  'IsDiscountPrinted': instance.isDiscountPrinted,
  'SalesRep_ID': instance.salesRepId?.toJson(),
  'C_BP_Group_ID': instance.cBpGroupId?.toJson(),
  'PO_PaymentTerm_ID': instance.poPaymentTermId?.toJson(),
  'SendEMail': instance.sendEMail,
  'SOCreditStatus': instance.soCreditStatus?.toJson(),
  'TotalOpenBalance': instance.totalOpenBalance,
  'IsPOTaxExempt': instance.isPOTaxExempt,
  'IsManufacturer': instance.isManufacturer,
  'Is1099Vendor': instance.is1099Vendor,
  'IsReferral': instance.isReferral,
  'C_SalesRegion_ID': instance.cSalesRegionId?.toJson(),
  'Promo': instance.promo,
  'model-name': instance.modelName,
  'AD_User': instance.adUser?.map((e) => e.toJson()).toList(),
  'C_BPartner_Location': instance.cBpartnerLocation
      ?.map((e) => e.toJson())
      .toList(),
};
