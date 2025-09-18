import 'package:flutter/material.dart';

class FormatDefinition {
  final int wideCount;
  final bool newLine;
  final bool editable;
  final bool? isHidden;
  final bool isMandatory;
  final int? maxLines;
  final IconData? icon;
  final dynamic value;

  const FormatDefinition({
    this.maxLines,
    this.editable = true,
    this.newLine = false,
    this.wideCount = 2,
    this.isHidden,
    this.isMandatory = false,
    this.icon,
    this.value,
  });
}

class FieldConfiguration {
  static const Map<String, FormatDefinition> configurations = {
    // Main record fields
    'DocumentNo': FormatDefinition(
      wideCount: 2,
      editable: false,
      icon: Icons.receipt_long,
    ),
    'DateTrx': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.calendar_today,
    ),
    'GestationalAgeWeek': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.schedule,
    ),
    'GestationalAgeDay': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.schedule,
    ),
    'AD_Client_ID': FormatDefinition(
      wideCount: 4,
      editable: false,
      icon: Icons.business,
    ),
    'AD_Org_ID': FormatDefinition(
      wideCount: 4,
      newLine: true,
      editable: false,
      icon: Icons.account_balance,
    ),
    'C_SalesRegion_ID': FormatDefinition(
      wideCount: 4,
      editable: true,
      icon: Icons.location_city,
    ),
    'OrderType_ID': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.category,
    ),
    'M_Specialist_ID': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.medical_services,
    ),
    'C_BPartner_ID': FormatDefinition(
      wideCount: 4,
      newLine: true,
      editable: true,
      icon: Icons.person,
    ),

    // Obstetric fields
    'Doctor_ID': FormatDefinition(
      wideCount: 4,
      editable: true,
      icon: Icons.medical_services,
    ),
    'VisitDate': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.event,
    ),
    'NextVisitDate': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.event_available,
    ),
    'ChiefComplaint': FormatDefinition(
      wideCount: 8,
      newLine: true,
      editable: true,
      maxLines: 3,
      icon: Icons.notes,
    ),
    'BodyTemperature': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.thermostat,
    ),
    'SystolicPressure': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.favorite,
    ),
    'DiastolicPressure': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.favorite_border,
    ),

    // Gynecology fields
    'BodyWeight': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.monitor_weight,
    ),
    'BodyHeight': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.height,
    ),

    // Prescription fields
    'M_Product_ID': FormatDefinition(
      wideCount: 4,
      editable: true,
      icon: Icons.medication,
    ),
    'Qty': FormatDefinition(wideCount: 2, editable: true, icon: Icons.numbers),
    'Description': FormatDefinition(
      wideCount: 6,
      editable: true,
      maxLines: 2,
      icon: Icons.description,
    ),
  };
}
