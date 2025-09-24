import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/domain/entities/field_config.dart';
import 'package:medibuk/presentation/providers/ui_providers.dart';
import 'package:medibuk/presentation/widgets/core/app_fields.dart';
import 'package:medibuk/presentation/widgets/core/responsive_grid.dart';
import 'package:medibuk/presentation/providers/form_data_provider.dart';

class AppFormSection extends ConsumerStatefulWidget {
  final String title;
  final Map<String, dynamic> data;
  final bool isEditable;
  final String sectionType;
  final int sectionIndex;
  final String recordId;
  final bool initiallyExpanded;
  final VoidCallback? onDelete;
  final bool collapsible;

  const AppFormSection({
    super.key,
    required this.title,
    required this.data,
    required this.isEditable,
    required this.sectionType,
    required this.sectionIndex,
    required this.recordId,
    this.initiallyExpanded = true,
    this.onDelete,
    this.collapsible = true,
  });

  @override
  ConsumerState<AppFormSection> createState() => _AppFormSectionState();
}

class _AppFormSectionState extends ConsumerState<AppFormSection>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late bool _isExpanded;
  late Map<String, dynamic> _localData;
  late Map<String, dynamic> _originalData;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _localData = Map<String, dynamic>.from(widget.data);
    _originalData = Map<String, dynamic>.from(widget.data);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final entries = _getFilteredEntries();
      final initMap = {for (final e in entries) e.key: e.value};
      ref
          .read(formDataProvider.notifier)
          .ensureSectionInitialized(
            recordId: widget.recordId,
            sectionType: widget.sectionType,
            sectionIndex: widget.sectionIndex,
            fields: initMap,
          );
    });
  }

  @override
  void didUpdateWidget(covariant AppFormSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.recordId != widget.recordId ||
        oldWidget.sectionIndex != widget.sectionIndex ||
        oldWidget.sectionType != widget.sectionType) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final entries = _getFilteredEntries();
        final initMap = {for (final e in entries) e.key: e.value};
        ref
            .read(formDataProvider.notifier)
            .ensureSectionInitialized(
              recordId: widget.recordId,
              sectionType: widget.sectionType,
              sectionIndex: widget.sectionIndex,
              fields: initMap,
            );
      });
    }
  }

  void _onFieldChanged(String fieldName, dynamic value) {
    setState(() {
      _localData[fieldName] = value;
    });

    ref.read(formModificationNotifierProvider.notifier).setModified(true);

    ref
        .read(formDataProvider.notifier)
        .updateField(
          recordId: widget.recordId,
          sectionType: widget.sectionType,
          sectionIndex: widget.sectionIndex,
          fieldName: fieldName,
          originalValue: _originalData[fieldName],
          newValue: value,
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 250, 250),
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
    final header = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xffcde7ed),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        border: Border(bottom: BorderSide(color: Colors.blue[100]!)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (widget.sectionType == 'obstetric' &&
              widget.isEditable &&
              widget.onDelete != null) ...[
            IconButton(
              onPressed: widget.onDelete,
              tooltip: 'Delete',
              icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
            ),
          ],
          Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.info_outline,
              size: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          if (widget.collapsible)
            Icon(
              _isExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              color: Colors.black,
            ),
        ],
      ),
    );

    if (!widget.collapsible) return header;
    return InkWell(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: header,
    );
  }

  Widget _buildContent() {
    final entries = _getFilteredEntries();
    final children = _buildFormFieldsFromEntries(entries);

    final spans = <int>[];
    final breaks = <bool>[];
    for (final entry in entries) {
      final config = FieldConfig.getConfig(
        entry.key,
        section: widget.sectionType,
      );
      spans.add(config.wideCount);
      breaks.add(config.newLine);
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ResponsiveGrid(
            maxWidth: constraints.maxWidth,
            spans: spans,
            breakBefore: breaks,
            children: children,
          );
        },
      ),
    );
  }

  List<Widget> _buildFormFieldsFromEntries(
    List<MapEntry<String, dynamic>> entries,
  ) {
    final fields = <Widget>[];

    for (final entry in entries) {
      final fieldName = entry.key;
      final value = entry.value;

      fields.add(
        AppFields(
          key: ValueKey(
            '${widget.sectionType}_${widget.sectionIndex}_$fieldName',
          ),
          fieldName: fieldName,
          value: value,
          isEditable: widget.isEditable,
          sectionType: widget.sectionType,
          onChanged: (newValue) => _onFieldChanged(fieldName, newValue),
        ),
      );
    }

    return fields;
  }

  List<MapEntry<String, dynamic>> _getFilteredEntries() {
    final allowedKeys = FieldConfig.orderedKeysForSection(widget.sectionType);
    if (allowedKeys.isEmpty) return const <MapEntry<String, dynamic>>[];

    final result = <MapEntry<String, dynamic>>[];
    for (final key in allowedKeys) {
      if (!_localData.containsKey(key)) continue;
      final cfg = FieldConfig.getConfig(key, section: widget.sectionType);
      if (cfg.isHidden == true) continue;
      result.add(MapEntry(key, _localData[key]));
    }
    return result;
  }
}
