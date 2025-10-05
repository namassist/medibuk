import 'package:flutter/material.dart';
import 'package:medibuk/domain/entities/format_definition.dart';
import 'package:medibuk/domain/entities/general_info.dart';

dynamic _getProp(Map<String, dynamic> data, String fieldKey, String propKey) {
  final value = data[fieldKey];
  if (value is GeneralInfo) {
    if (propKey == 'id') return value.id;
    if (propKey == 'identifier') return value.identifier;
  }
  if (value is Map) {
    return value[propKey];
  }
  return null;
}

// Pengecekan status
bool _isReadOnlyStatus(Map<String, dynamic> data) {
  final docStatus = data['DocStatus']?['id'] as String?;
  return docStatus == 'VO' || docStatus == 'CO';
}

// Pengecekan status yang memperbolehkan edit
bool _isEditableStatus(Map<String, dynamic> data) {
  final docStatus = data['DocStatus']?['id'] as String?;
  final id = data['id'] as int?;
  final docNo = data['DocumentNo'] as String?;

  // Kondisi "Buat Baru"
  if (id == -1 && docNo == 'NEW') return true;

  // Kondisi status lainnya
  return ['DR', 'IP', 'IN'].contains(docStatus);
}

// Pengecekan tipe spesialis
bool _isSpecialist(Map<String, dynamic> data, String keyword) {
  final specialistIdentifier =
      _getProp(data, 'M_Specialist_ID', 'identifier') as String?;
  if (specialistIdentifier == null) return false;
  return specialistIdentifier.toUpperCase().contains(keyword.toUpperCase());
}

class FieldConfig {
  static final Map<String, Map<String, FormatDefinition>>
  _sectionConfigurations = {
    'main': {
      'DateTrx': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.date,
      ),
      'OrderType_ID': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'M_Specialist_ID': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'C_BPartner_ID': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'GestationalAgeWeek': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        newLine: true,
        isMandatory: true,
        fieldType: FieldType.number,
      ),
      'GestationalAgeDay': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        isMandatory: true,
        fieldType: FieldType.number,
      ),
    },
    'gynecology': {
      'Doctor_ID': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Assistant_ID': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Birthday': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.date,
      ),
      'NextVisitDate': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.date,
      ),
      'ChiefComplaint': FormatDefinition(
        wideCount: 8,
        newLine: true,
        multiLine: true,
        editable: true,
        maxLines: 7,
        fieldType: FieldType.text,
      ),
      'FirstDayOfMenstrualPeriod': FormatDefinition(
        wideCount: 2,
        editable: true,
        newLine: true,
        fieldType: FieldType.date,
      ),
      'BirthControlMethod': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'BodyHeight': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'BodyWeight': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'SystolicPressure': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'DiastolicPressure': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'ICD_10': FormatDefinition(
        wideCount: 4,
        editable: true,
        newLine: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'EndometriumThickness': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'InternalNote': FormatDefinition(
        wideCount: 8,
        editable: true,
        multiLine: true,
        newLine: true,
        maxLines: 7,
        fieldType: FieldType.text,
      ),
      'Note': FormatDefinition(
        wideCount: 8,
        editable: true,
        multiLine: true,
        newLine: true,
        maxLines: 7,
        fieldType: FieldType.text,
      ),
      'IsShowMore': FormatDefinition(
        wideCount: 2,
        editable: true,
        newLine: true,
        fieldType: FieldType.boolean,
      ),
      'NutritionNotes': FormatDefinition(
        wideCount: 8,
        newLine: true,
        multiLine: true,
        editable: true,
        maxLines: 7,
        fieldType: FieldType.text,
      ),
      'UterusLength': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'UterusWidth': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'UterusThickness': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'UterusPosition': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'UterusNote': FormatDefinition(
        wideCount: 8,
        editable: true,
        multiLine: true,
        newLine: true,
        maxLines: 7,
        fieldType: FieldType.text,
      ),
      'LeftOvaryFollicleCount': FormatDefinition(
        wideCount: 2,
        newLine: true,
        editable: true,
        fieldType: FieldType.number,
      ),
      'LeftOvaryLength': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'LeftOvaryThickness': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'LeftOvaryWidth': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'LeftOvaryNote': FormatDefinition(
        wideCount: 8,
        editable: true,
        multiLine: true,
        newLine: true,
        maxLines: 7,
        fieldType: FieldType.text,
      ),
      'RightOvaryFollicleCount': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'RightOvaryLength': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'RightOvaryThickness': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'RightOvaryWidth': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'RightOvaryNote': FormatDefinition(
        wideCount: 8,
        editable: true,
        multiLine: true,
        newLine: true,
        maxLines: 7,
        fieldType: FieldType.text,
      ),
    },
    'obstetric': {
      'Doctor_ID': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Assistant_ID': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Birthday': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.date,
      ),
      'Age': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.text,
      ),
      'GPA': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.text,
      ),
      'LineNo': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'VisitDate': FormatDefinition(
        wideCount: 2,
        editable: false,
        multiLine: false,
        fieldType: FieldType.date,
      ),
      'NextVisitDate': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.date,
      ),
      'ChiefComplaint': FormatDefinition(
        wideCount: 8,
        editable: true,
        multiLine: true,
        newLine: true,
        maxLines: 7,
        fieldType: FieldType.text,
      ),
      'BodyTemperature': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'Miscarriage': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'PregnancyNo': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'EstimatedDateOfConception': FormatDefinition(
        wideCount: 2,
        editable: false,
        fieldType: FieldType.date,
      ),
      'FirstDayOfMenstrualPeriod': FormatDefinition(
        wideCount: 1,
        editable: true,
        fieldType: FieldType.date,
      ),
      'HPL': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.date,
      ),
      'Riwayat_alergi': FormatDefinition(
        wideCount: 8,
        newLine: true,
        multiLine: true,
        editable: true,
        maxLines: 7,
        fieldType: FieldType.text,
      ),
      'LaborSC': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'LaborSpontanNormal': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'LaborSpontanVacuum': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'BodyHeight': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'BodyWeight': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'SystolicPressure': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'DiastolicPressure': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'LILA': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'BMI': FormatDefinition(
        wideCount: 1,
        editable: true,
        newLine: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'ICD_10': FormatDefinition(
        wideCount: 4,
        newLine: true,
        editable: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Note': FormatDefinition(
        wideCount: 8,
        editable: true,
        multiLine: true,
        maxLines: 6,
        fieldType: FieldType.text,
      ),
      'InternalNote': FormatDefinition(
        wideCount: 8,
        multiLine: true,
        editable: true,
        maxLines: 7,
        fieldType: FieldType.text,
      ),
      'IsShowMore': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.boolean,
      ),
      'NutritionNotes': FormatDefinition(
        wideCount: 8,
        multiLine: true,
        newLine: true,
        editable: true,
        maxLines: 7,
        fieldType: FieldType.text,
      ),
      'Presentation': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'PlacentaGrade': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'PlacentaPosition': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Cairan_Ketuban': FormatDefinition(
        wideCount: 2,
        editable: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Gender': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.generalInfo,
      ),
      'Weight': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        fieldType: FieldType.number,
      ),
      'GS': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        newLine: true,
        fieldType: FieldType.number,
      ),
      'YS': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'DJJ': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'FL': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'CRL': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'BPD': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'HC': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'AC': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'SDP': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
      'AFI': FormatDefinition(
        wideCount: 1,
        editable: true,
        multiLine: false,
        isMandatory: false,
        fieldType: FieldType.number,
      ),
    },
    'encounter_main': {
      'DocumentNo': FormatDefinition(
        wideCount: 2,
        editable: false, // Selalu read-only
      ),
      'Antrian': FormatDefinition(
        wideCount: 1,
        editable: false, // Selalu read-only
      ),
      'DateTrx': FormatDefinition(
        wideCount: 2,
        fieldType: FieldType.date,
        isEditableRule: (data) {
          final id = data['id'] as int?;
          final docNo = data['DocumentNo'] as String?;
          // Hanya enable saat buat baru
          return id == -1 && docNo == 'NEW';
        },
      ),
      'C_DocType_ID': FormatDefinition(
        wideCount: 2,
        fieldType: FieldType.generalInfo,
        isMandatory: true,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
      ),
      'C_EncounterSchedule_ID': FormatDefinition(
        wideCount: 4,
        fieldType: FieldType.generalInfo,
        editable: false,
        isHiddenRule: (data) {
          final docTypeId = _getProp(data, 'C_DocType_ID', 'id');
          final docTypeIdentifier = _getProp(
            data,
            'C_DocType_ID',
            'identifier',
          );
          return !(docTypeId == 1000056 ||
              docTypeIdentifier == 'Booking Online');
        },
      ),
      'C_BPartner_ID': FormatDefinition(
        wideCount: 2,
        fieldType: FieldType.bpartnerSearch,
        isMandatory: true,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
      ),
      'C_BPartnerRelation_ID': FormatDefinition(
        wideCount: 2,
        fieldType: FieldType.bpartnerSearch,
        isEditableRule: (data) {
          return _isSpecialist(data, 'LAKTASI') &&
              !_isReadOnlyStatus(data) &&
              _isEditableStatus(data);
        },
      ),
      'QA_Sources_ID': FormatDefinition(
        wideCount: 2,
        fieldType: FieldType.generalInfo,
        editable: false, // Selalu read-only
      ),
      'C_SalesRegion_ID': FormatDefinition(
        wideCount: 2,
        newLine: true,
        fieldType: FieldType.generalInfo,
        isMandatory: true,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
      ),
      'M_Specialist_ID': FormatDefinition(
        wideCount: 2,
        fieldType: FieldType.generalInfo,
        isMandatory: true,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
      ),
      'Doctor_ID': FormatDefinition(
        wideCount: 2,
        fieldType: FieldType.generalInfo,
        isMandatory: true,
        isEditableRule: (data) {
          final specialist = data['M_Specialist_ID'];
          return specialist != null &&
              !_isReadOnlyStatus(data) &&
              _isEditableStatus(data);
        },
      ),
      'Assistant_ID': FormatDefinition(
        wideCount: 2,
        fieldType: FieldType.generalInfo,
        isMandatory: true,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
        isHiddenRule: (data) => _getProp(data, 'C_DocType_ID', 'id') == 1000047,
      ),
      'Info': FormatDefinition(
        wideCount: 8,
        multiLine: true,
        maxLines: 4,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
      ),
    },
    'encounter_medical': {
      'SystolicPressure': FormatDefinition(
        wideCount: 1,
        fieldType: FieldType.number,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
        isHiddenRule: (data) =>
            _getProp(data, 'M_Specialist_ID', 'id') != null &&
            _isSpecialist(data, 'ANAK'),
      ),
      'DiastolicPressure': FormatDefinition(
        wideCount: 1,
        fieldType: FieldType.number,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
        isHiddenRule: (data) =>
            _getProp(data, 'M_Specialist_ID', 'id') != null &&
            _isSpecialist(data, 'ANAK'),
      ),
      'BodyWeight': FormatDefinition(
        wideCount: 1,
        fieldType: FieldType.number,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
      ),
      'BodyHeight': FormatDefinition(
        wideCount: 1,
        fieldType: FieldType.number,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
      ),
      'PregnancyNo': FormatDefinition(
        wideCount: 1,
        fieldType: FieldType.number,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
        isHiddenRule: (data) =>
            _getProp(data, 'M_Specialist_ID', 'id') != null &&
            !(_isSpecialist(data, 'LAKTASI') ||
                _isSpecialist(data, 'KANDUNGAN')),
      ),
      'Miscarriage': FormatDefinition(
        wideCount: 1,
        fieldType: FieldType.number,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
        isHiddenRule: (data) =>
            _getProp(data, 'M_Specialist_ID', 'id') != null &&
            !_isSpecialist(data, 'KANDUNGAN'),
      ),
      'FirstDayOfMenstrualPeriod': FormatDefinition(
        wideCount: 2,
        fieldType: FieldType.date,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
        isHiddenRule: (data) =>
            _getProp(data, 'M_Specialist_ID', 'id') != null &&
            !_isSpecialist(data, 'KANDUNGAN'),
      ),
      'BodyTemperature': FormatDefinition(
        wideCount: 1,
        fieldType: FieldType.number,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
      ),
      'BirthWeight': FormatDefinition(
        wideCount: 1,
        fieldType: FieldType.number,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
        isHiddenRule: (data) =>
            _getProp(data, 'M_Specialist_ID', 'id') != null &&
            _isSpecialist(data, 'UMUM'),
      ),
      'head_circumference': FormatDefinition(
        wideCount: 1,
        fieldType: FieldType.number,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
        isHiddenRule: (data) =>
            _getProp(data, 'M_Specialist_ID', 'id') != null &&
            _isSpecialist(data, 'UMUM'),
      ),
      'LaborSpontanNormal': FormatDefinition(
        wideCount: 1,
        fieldType: FieldType.number,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
        isHiddenRule: (data) =>
            _getProp(data, 'M_Specialist_ID', 'id') != null &&
            !_isSpecialist(data, 'KANDUNGAN'),
      ),
      'LaborSC': FormatDefinition(
        wideCount: 1,
        fieldType: FieldType.number,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
        isHiddenRule: (data) =>
            _getProp(data, 'M_Specialist_ID', 'id') != null &&
            !_isSpecialist(data, 'KANDUNGAN'),
      ),
      'LaborSpontanForcep': FormatDefinition(
        wideCount: 1,
        fieldType: FieldType.number,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
        isHiddenRule: (data) =>
            _getProp(data, 'M_Specialist_ID', 'id') != null &&
            !_isSpecialist(data, 'KANDUNGAN'),
      ),
      'LaborSpontanVacuum': FormatDefinition(
        wideCount: 1,
        fieldType: FieldType.number,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
        isHiddenRule: (data) =>
            _getProp(data, 'M_Specialist_ID', 'id') != null &&
            !_isSpecialist(data, 'KANDUNGAN'),
      ),
      'LILA': FormatDefinition(
        wideCount: 1,
        fieldType: FieldType.number,
        isEditableRule: (data) =>
            !_isReadOnlyStatus(data) && _isEditableStatus(data),
        isHiddenRule: (data) =>
            _getProp(data, 'M_Specialist_ID', 'id') != null &&
            !_isSpecialist(data, 'KANDUNGAN'),
      ),
    },
  };

  static FormatDefinition getConfig(
    String fieldName, {
    required String section,
  }) {
    // Akses variabel static _sectionConfigurations
    final sectionMap = _sectionConfigurations[section];
    if (sectionMap != null && sectionMap.containsKey(fieldName)) {
      return sectionMap[fieldName]!;
    }
    // Default fallback
    return const FormatDefinition(
      wideCount: 2,
      editable: true,
      icon: Icons.text_fields,
    );
  }

  static List<String> orderedKeysForSection(String section) {
    // Akses variabel static _sectionConfigurations
    final sectionMap = _sectionConfigurations[section];
    if (sectionMap != null && sectionMap.isNotEmpty) {
      return sectionMap.keys.toList();
    }
    return const <String>[];
  }
}
