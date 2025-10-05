import 'package:flutter/material.dart';

enum FieldType { text, number, boolean, date, generalInfo, bpartnerSearch }

class FormatDefinition {
  final int wideCount;
  final bool newLine;
  final bool editable;
  final bool? isHidden;
  final bool isMandatory;
  final int? maxLines;
  final bool? multiLine;
  final IconData? icon;
  final FieldType? fieldType;
  final bool Function(Map<String, dynamic> data)? isEditableRule;
  final bool Function(Map<String, dynamic> data)? isHiddenRule;
  final bool Function(Map<String, dynamic> data)? isMandatoryRule;

  const FormatDefinition({
    this.maxLines,
    this.multiLine = false,
    this.editable = true,
    this.newLine = false,
    this.wideCount = 2,
    this.isHidden,
    this.isMandatory = false,
    this.icon,
    this.fieldType,
    this.isEditableRule,
    this.isHiddenRule,
    this.isMandatoryRule,
  });
}
