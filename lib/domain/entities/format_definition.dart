import 'package:flutter/material.dart';

enum FieldType { text, number, boolean, date, generalInfo }

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
  });
}
