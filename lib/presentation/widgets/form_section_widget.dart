import 'package:flutter/material.dart';
import '../../domain/entities/format_definition.dart';
import 'dynamic_field_widget.dart';
import 'responsive_grid.dart';

class FormSectionWidget extends StatefulWidget {
  final String title;
  final Map<String, dynamic> data;
  final bool isEditable;
  final ValueChanged<Map<String, dynamic>> onDataChanged;
  final bool initiallyExpanded;

  const FormSectionWidget({
    super.key,
    required this.title,
    required this.data,
    required this.isEditable,
    required this.onDataChanged,
    this.initiallyExpanded = true,
  });

  @override
  State<FormSectionWidget> createState() => _FormSectionWidgetState();
}

class _FormSectionWidgetState extends State<FormSectionWidget> {
  late bool _isExpanded;
  late Map<String, dynamic> _localData;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _localData = Map.from(widget.data);
  }

  void _onFieldChanged(String fieldName, dynamic value) {
    setState(() {
      _localData[fieldName] = value;
    });
    widget.onDataChanged(_localData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                border: Border(bottom: BorderSide(color: Colors.blue[100]!)),
              ),
              child: Row(
                children: [
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.blue[600],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.blue[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(16),
              child: ResponsiveGrid(
                maxWidth: MediaQuery.of(context).size.width,
                children: _buildFormFields(),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildFormFields() {
    final fields = <Widget>[];

    for (final entry in _localData.entries) {
      final fieldName = entry.key;
      final value = entry.value;
      final config =
          FieldConfiguration.configurations[fieldName] ??
          const FormatDefinition();

      fields.add(
        ResponsiveGridItem(
          wideCount: config.wideCount,
          newLine: config.newLine,
          child: DynamicFieldWidget(
            fieldName: fieldName,
            value: value,
            config: config,
            isEditable: widget.isEditable,
            onChanged: (newValue) => _onFieldChanged(fieldName, newValue),
          ),
        ),
      );
    }

    return fields;
  }
}
