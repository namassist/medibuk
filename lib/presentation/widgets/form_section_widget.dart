import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/medical_record_providers.dart';
import 'dynamic_field_widget.dart';
import 'responsive_grid.dart';

class OptimizedFormSectionWidget extends ConsumerStatefulWidget {
  final String title;
  final Map<String, dynamic> data;
  final bool isEditable;
  final String sectionType;
  final int sectionIndex;
  final String medicalRecordId;
  final bool initiallyExpanded;

  const OptimizedFormSectionWidget({
    super.key,
    required this.title,
    required this.data,
    required this.isEditable,
    required this.sectionType,
    required this.sectionIndex,
    required this.medicalRecordId,
    this.initiallyExpanded = true,
  });

  @override
  ConsumerState<OptimizedFormSectionWidget> createState() =>
      _OptimizedFormSectionWidgetState();
}

class _OptimizedFormSectionWidgetState
    extends ConsumerState<OptimizedFormSectionWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late bool _isExpanded;
  late Map<String, dynamic> _localData;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _localData = Map<String, dynamic>.from(widget.data);

    // 🎯 FIX: Debug print to see actual data
    print('=== ${widget.title} ===');
    print('Data keys: ${_localData.keys.toList()}');
    print('Data length: ${_localData.length}');
  }

  void _onFieldChanged(String fieldName, dynamic value) {
    setState(() {
      _localData[fieldName] = value;
    });

    ref.read(formModificationNotifierProvider.notifier).setModified(true);
    print('Field changed: $fieldName = $value');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
        children: [_buildHeader(), if (_isExpanded) _buildContent()],
      ),
    );
  }

  Widget _buildHeader() {
    return InkWell(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          border: Border(bottom: BorderSide(color: Colors.blue[100]!)),
        ),
        child: Row(
          children: [
            Icon(
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.blue[600],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${widget.title} (${_localData.length} fields)',
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
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: OptimizedResponsiveGrid(
        maxWidth: MediaQuery.of(context).size.width,
        children: _buildFormFields(),
      ),
    );
  }

  // 🎯 FIX: Properly build unique fields
  List<Widget> _buildFormFields() {
    final fields = <Widget>[];
    final processedKeys = <String>{}; // Track processed keys

    // 🎯 FIX: Filter out internal fields and duplicates
    final filteredData = <String, dynamic>{};
    for (final entry in _localData.entries) {
      final key = entry.key;
      final value = entry.value;

      // Skip internal fields
      if (_isInternalField(key)) continue;

      // Skip if already processed
      if (processedKeys.contains(key)) continue;

      filteredData[key] = value;
      processedKeys.add(key);
    }

    print('Filtered data for ${widget.title}: ${filteredData.keys.toList()}');

    for (final entry in filteredData.entries) {
      final fieldName = entry.key;
      final value = entry.value;

      fields.add(
        OptimizedDynamicFieldWidget(
          key: ValueKey(
            '${widget.sectionType}_${widget.sectionIndex}_$fieldName',
          ),
          fieldName: fieldName,
          value: value,
          isEditable: widget.isEditable,
          onChanged: (newValue) => _onFieldChanged(fieldName, newValue),
        ),
      );
    }

    return fields;
  }

  // 🎯 FIX: Filter out internal/system fields
  bool _isInternalField(String fieldName) {
    final internalFields = {
      'id',
      'uid',
      'C_MedicalRecord_ID',
      'LineNo',
      'AD_Client_ID',
      'AD_Org_ID',
      'C_SalesRegion_ID',
    };
    return internalFields.contains(fieldName);
  }
}
