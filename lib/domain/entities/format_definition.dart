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
    // ===== MAIN RECORD FIELDS =====
    // 'DocumentNo': FormatDefinition(
    //   wideCount: 2,
    //   editable: false,
    //   icon: Icons.receipt_long,
    // ),
    'DateTrx': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.calendar_today,
    ),
    'GestationalAgeWeek': FormatDefinition(
      wideCount: 2,
      editable: true,
      newLine: true,
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
    'C_Encounter_ID': FormatDefinition(
      wideCount: 4,
      editable: false,
      icon: Icons.medical_information,
    ),

    // ===== OBSTETRIC FIELDS =====
    'Doctor_ID': FormatDefinition(
      wideCount: 4,
      editable: true,
      icon: Icons.medical_services,
    ),
    'Assistant_ID': FormatDefinition(
      wideCount: 4,
      editable: true,
      icon: Icons.person_outline,
    ),
    'LineNo': FormatDefinition(
      wideCount: 2,
      editable: false,
      icon: Icons.numbers,
    ),
    'Birthday': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.cake,
    ),
    'Age': FormatDefinition(wideCount: 2, editable: false, icon: Icons.timer),
    'GPA': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.pregnant_woman,
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
    'Miscarriage': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.warning,
    ),
    'PregnancyNo': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.child_care,
    ),
    'FirstDayOfMenstrualPeriod': FormatDefinition(
      wideCount: 3,
      editable: true,
      icon: Icons.calendar_month,
    ),
    'Riwayat_alergi': FormatDefinition(
      wideCount: 5,
      newLine: true,
      editable: true,
      maxLines: 2,
      icon: Icons.health_and_safety,
    ),
    'HPL': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.event_note,
    ),
    'EstimatedDateOfConception': FormatDefinition(
      wideCount: 3,
      editable: true,
      icon: Icons.schedule,
    ),
    'LaborSC': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.healing,
    ),
    'LaborSpontanNormal': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.favorite,
    ),
    'LaborSpontanVacuum': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.medical_services,
    ),
    'BodyHeight': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.height,
    ),
    'BMI': FormatDefinition(
      wideCount: 2,
      editable: false, // Calculated field
      icon: Icons.monitor_weight,
    ),
    'BodyWeight': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.monitor_weight,
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
    'LILA': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.straighten,
    ),
    'ICD_10': FormatDefinition(
      wideCount: 4,
      newLine: true,
      editable: true,
      icon: Icons.medical_information,
    ),
    'Note': FormatDefinition(
      wideCount: 4,
      editable: true,
      maxLines: 3,
      icon: Icons.note_add,
    ),
    'InternalNote': FormatDefinition(
      wideCount: 4,
      editable: true,
      maxLines: 3,
      icon: Icons.note,
    ),
    'IsShowMore': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.visibility,
    ),
    'NutritionNotes': FormatDefinition(
      wideCount: 8,
      newLine: true,
      editable: true,
      maxLines: 3,
      icon: Icons.restaurant,
    ),
    'Presentation': FormatDefinition(
      wideCount: 3,
      editable: true,
      icon: Icons.baby_changing_station,
    ),
    'PlacentaGrade': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.grade,
    ),
    'PlacentaPosition': FormatDefinition(
      wideCount: 3,
      editable: true,
      icon: Icons.place,
    ),
    'Weight': FormatDefinition(wideCount: 2, editable: true, icon: Icons.scale),
    'GS': FormatDefinition(wideCount: 2, editable: true, icon: Icons.circle),
    'YS': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.circle_outlined,
    ),
    'DJJ': FormatDefinition(wideCount: 2, editable: true, icon: Icons.hearing),
    'FL': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.straighten,
    ),
    'CRL': FormatDefinition(wideCount: 2, editable: true, icon: Icons.height),
    'BPD': FormatDefinition(wideCount: 2, editable: true, icon: Icons.circle),
    'HC': FormatDefinition(wideCount: 2, editable: true, icon: Icons.circle),
    'AC': FormatDefinition(wideCount: 2, editable: true, icon: Icons.circle),
    'Gender': FormatDefinition(
      wideCount: 2,
      newLine: true,
      editable: true,
      icon: Icons.person,
    ),
    'SDP': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.water_drop,
    ),
    'AFI': FormatDefinition(wideCount: 2, editable: true, icon: Icons.opacity),
    'Cairan_Ketuban': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.water,
    ),

    // ===== GYNECOLOGY FIELDS =====
    'BirthControlMethod': FormatDefinition(
      wideCount: 4,
      newLine: true,
      editable: true,
      icon: Icons.health_and_safety,
    ),
    'UterusNote': FormatDefinition(
      wideCount: 4,
      editable: true,
      maxLines: 2,
      icon: Icons.notes,
    ),
    'UterusLength': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.straighten,
    ),
    'UterusWidth': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.width_normal,
    ),
    'UterusThickness': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.line_weight,
    ),
    'UterusPosition': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.place,
    ),
    'EndometriumThickness': FormatDefinition(
      wideCount: 3,
      newLine: true,
      editable: true,
      icon: Icons.layers,
    ),
    'RightOvaryFollicleCount': FormatDefinition(
      wideCount: 3,
      editable: true,
      icon: Icons.bubble_chart,
    ),
    'RightOvaryNote': FormatDefinition(
      wideCount: 2,
      editable: true,
      maxLines: 2,
      icon: Icons.note,
    ),
    'RightOvaryLength': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.straighten,
    ),
    'RightOvaryThickness': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.line_weight,
    ),
    'RightOvaryWidth': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.width_normal,
    ),
    'LeftOvaryFollicleCount': FormatDefinition(
      wideCount: 3,
      newLine: true,
      editable: true,
      icon: Icons.bubble_chart,
    ),
    'LeftOvaryNote': FormatDefinition(
      wideCount: 2,
      editable: true,
      maxLines: 2,
      icon: Icons.note,
    ),
    'LeftOvaryLength': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.straighten,
    ),
    'LeftOvaryThickness': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.line_weight,
    ),
    'LeftOvaryWidth': FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.width_normal,
    ),

    // ===== PRESCRIPTION FIELDS =====
    // 'M_Product_ID': FormatDefinition(
    //   wideCount: 4,
    //   editable: true,
    //   icon: Icons.medication,
    // ),
    // 'Qty': FormatDefinition(wideCount: 2, editable: true, icon: Icons.numbers),
    // 'Description': FormatDefinition(
    //   wideCount: 6,
    //   newLine: true,
    //   editable: true,
    //   maxLines: 2,
    //   icon: Icons.description,
    // ),
    // 'QtyOnHand': FormatDefinition(
    //   wideCount: 2,
    //   editable: false,
    //   icon: Icons.inventory,
    // ),
    // 'IsActive': FormatDefinition(
    //   wideCount: 2,
    //   editable: false,
    //   icon: Icons.check_circle,
    // ),
    // 'isMedicationCompund': FormatDefinition(
    //   wideCount: 4,
    //   editable: true,
    //   icon: Icons.science,
    // ),
  };

  // 🎯 FIX: Get configuration with safe fallback
  static FormatDefinition getConfig(String fieldName) {
    return configurations[fieldName] ??
        FormatDefinition(wideCount: 2, editable: true, icon: Icons.text_fields);
  }
}
