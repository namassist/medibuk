import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/presentation/providers/medical_record_providers.dart';
import 'package:medibuk/presentation/widgets/dynamic_field_widget.dart';
import 'package:medibuk/presentation/widgets/responsive_grid.dart';

// 🎯 OPTIMIZATION 16: StatelessWidget with focused state management
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
  // 🎯 OPTIMIZATION 17: Keep widget alive to prevent recreation
  @override
  bool get wantKeepAlive => true;

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

    // 🎯 OPTIMIZATION 18: Notify form modification without rebuilding parent
    ref.read(formModificationNotifierProvider.notifier).setModified(true);

    // TODO: Implement actual data update logic
    print('${widget.sectionType}[${widget.sectionIndex}] $fieldName: $value');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return Container(
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

  // 🎯 OPTIMIZATION 19: Memoized form fields generation
  List<Widget> _buildFormFields() {
    final fields = <Widget>[];

    for (final entry in _localData.entries) {
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
}
