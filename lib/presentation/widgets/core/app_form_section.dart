import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/repositories/encounter_repository.dart';
import 'package:medibuk/domain/entities/field_config.dart';
import 'package:medibuk/domain/entities/general_info.dart';
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

  bool _isQaSourceEditable = false;

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
  }

  void _onFieldChanged(String fieldName, dynamic newValue) async {
    final stateChanges = <String, dynamic>{};

    if (fieldName == 'C_BPartner_ID') {
      final bpartnerId = (newValue is GeneralInfo)
          ? newValue.id
          : (newValue is Map ? newValue['id'] : null);

      bool shouldEnableQaSource = false;
      if (bpartnerId != null) {
        shouldEnableQaSource = await ref
            .read(encounterRepositoryProvider)
            .isNewPatientForQaSource(bpartnerId);
      }

      if (_isQaSourceEditable != shouldEnableQaSource) {
        _isQaSourceEditable = shouldEnableQaSource;
        if (!shouldEnableQaSource) {
          stateChanges['QA_Sources_ID'] = null;
        }
      }
    }

    if (newValue is GeneralInfo) {
      stateChanges[fieldName] = newValue.toJson();
    } else {
      stateChanges[fieldName] = newValue;
    }

    if (fieldName == 'C_SalesRegion_ID') {
      stateChanges['M_Specialist_ID'] = null;
      stateChanges['Doctor_ID'] = null;
    } else if (fieldName == 'M_Specialist_ID') {
      stateChanges['Doctor_ID'] = null;
    }

    if (mounted) {
      setState(() {
        _localData.addAll(stateChanges);
      });
    }

    ref.read(formModificationNotifierProvider.notifier).setModified(true);
    for (var entry in stateChanges.entries) {
      _updateFormData(entry.key, entry.value);
    }

    _updateFormData(fieldName, newValue);
  }

  void _updateFormData(String fieldName, dynamic newValue) {
    if (_originalData.containsKey(fieldName)) {
      ref
          .read(formDataProvider.notifier)
          .updateField(
            recordId: widget.recordId,
            sectionType: widget.sectionType,
            sectionIndex: widget.sectionIndex,
            fieldName: fieldName,
            originalValue: _originalData[fieldName],
            newValue: newValue,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: [_buildHeader(), if (_isExpanded) _buildContent()],
      ),
    );
  }

  Widget _buildHeader() {
    final colorScheme = Theme.of(context).colorScheme;

    final header = Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant, width: 3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: colorScheme.onPrimaryContainer,
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
              icon: Icon(Icons.delete_forever, color: colorScheme.error),
            ),
          ],
          Icon(Icons.info_outline, color: colorScheme.onSecondaryContainer),
          const SizedBox(width: 8),
          if (widget.collapsible)
            Icon(
              _isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
              color: colorScheme.onSecondaryContainer,
            ),
        ],
      ),
    );

    if (!widget.collapsible) return header;
    return InkWell(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
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

      final config = FieldConfig.getConfig(
        fieldName,
        section: widget.sectionType,
      );

      bool? isEditable;
      if (config.isEditableRule != null) {
        isEditable = widget.isEditable && config.isEditableRule!(_localData);
      } else {
        isEditable = widget.isEditable && config.editable;
      }

      if (fieldName == 'QA_Sources_ID') {
        isEditable = _isQaSourceEditable;
      }

      bool? isMandatory;
      if (config.isMandatoryRule != null) {
        isMandatory = config.isMandatoryRule!(_localData);
      }

      fields.add(
        AppFields(
          key: ValueKey(
            '${widget.sectionType}_${widget.sectionIndex}_$fieldName',
          ),
          fieldName: fieldName,
          value: value,
          isEditable: isEditable,
          isMandatory: isMandatory,
          sectionType: widget.sectionType,
          onChanged: (newValue) => _onFieldChanged(fieldName, newValue),
          allSectionData: _localData,
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

      bool isHidden = cfg.isHidden ?? false;
      if (cfg.isHiddenRule != null) {
        isHidden = cfg.isHiddenRule!(_localData);
      }

      if (isHidden) continue;

      result.add(MapEntry(key, _localData[key]));
    }
    return result;
  }
}
