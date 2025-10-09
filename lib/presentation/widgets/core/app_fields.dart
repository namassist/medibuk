import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:medibuk/data/repositories/shared_data_repository.dart';
import 'package:medibuk/domain/entities/app_theme_extension.dart';
import 'package:medibuk/domain/entities/field_config.dart';
import 'package:medibuk/domain/entities/fields_dictionary.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/domain/entities/format_definition.dart';
import 'package:medibuk/presentation/providers/form_data_provider.dart';
import 'package:medibuk/presentation/providers/ui_providers.dart';
import 'package:medibuk/presentation/utils/formatter.dart';
import 'package:medibuk/presentation/widgets/shared/bpartner_search_dialog.dart';

class AppFields extends ConsumerStatefulWidget {
  final String fieldName;
  final Map<String, dynamic> originalData;
  final String recordId;
  final String sectionType;
  final int sectionIndex;
  final bool? isEditable;
  final bool? isMandatory;

  const AppFields({
    super.key,
    required this.fieldName,
    required this.originalData,
    required this.recordId,
    required this.sectionType,
    required this.sectionIndex,
    this.isEditable,
    this.isMandatory,
  });

  @override
  ConsumerState<AppFields> createState() => _AppFieldsState();
}

class _AppFieldsState extends ConsumerState<AppFields>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final TextEditingController _controller;
  late final FormatDefinition _config;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _hasBeenTouched = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _config = FieldConfig.getConfig(
      widget.fieldName,
      section: widget.sectionType,
    );

    if (widget.isMandatory ?? _config.isMandatory) {
      _hasBeenTouched = true;
    }

    _focusNode.addListener(() {
      if (mounted) {
        setState(() {
          _isFocused = _focusNode.hasFocus;
          if (!_isFocused && !_hasBeenTouched) {
            _hasBeenTouched = true;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(dynamic newValue) {
    final notifier = ref.read(formDataProvider.notifier);

    notifier.updateField(
      recordId: widget.recordId,
      sectionType: widget.sectionType,
      sectionIndex: widget.sectionIndex,
      fieldName: widget.fieldName,
      originalValue: widget.originalData[widget.fieldName],
      newValue: newValue,
    );

    if (widget.fieldName == 'C_SalesRegion_ID') {
      _resetDependentField('M_Specialist_ID', 'encounter_main', 0);
      _resetDependentField('Doctor_ID', 'encounter_main', 0);
    } else if (widget.fieldName == 'M_Specialist_ID') {
      _resetDependentField('Doctor_ID', 'encounter_main', 0);
    }

    ref.read(formModificationNotifierProvider.notifier).setModified(true);
  }

  void _resetDependentField(
    String fieldName,
    String sectionType,
    int sectionIndex,
  ) {
    ref
        .read(formDataProvider.notifier)
        .updateField(
          recordId: widget.recordId,
          sectionType: sectionType,
          sectionIndex: sectionIndex,
          fieldName: fieldName,
          originalValue: widget.originalData[fieldName],
          newValue: null,
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final dataForRules = _buildDataForRules(
      ref,
      widget.originalData,
      widget.recordId,
    );

    bool isHidden = false;
    if (_config.isHiddenRule != null) {
      isHidden = _config.isHiddenRule!(dataForRules);
    }

    if (isHidden) {
      return const SizedBox.shrink();
    }

    final currentValue = ref.watch(
      formDataProvider.select((state) {
        final key =
            '${widget.recordId}|${widget.sectionType}:${widget.sectionIndex}';
        if (state.current.containsKey(key) &&
            state.current[key]!.containsKey(widget.fieldName)) {
          return state.current[key]![widget.fieldName];
        }
        return widget.originalData[widget.fieldName];
      }),
    );

    _updateController(currentValue);

    bool finalIsEditable;
    if (_config.isEditableRule != null) {
      finalIsEditable =
          (widget.isEditable ?? true) && _config.isEditableRule!(dataForRules);
    } else {
      finalIsEditable = (widget.isEditable ?? true) && _config.editable;
    }

    final bool isMandatory = widget.isMandatory ?? _config.isMandatory;
    final bool showErrorState =
        isMandatory &&
        (_hasBeenTouched || _isFocused) &&
        _isValueEmpty(currentValue);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldLabel(showErrorState),
          const SizedBox(height: 4),
          _buildFieldWidget(
            currentValue,
            dataForRules,
            finalIsEditable,
            showErrorState,
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _buildDataForRules(
    WidgetRef ref,
    Map<String, dynamic> originalData,
    String recordId,
  ) {
    final specialistValue = ref.watch(
      formDataProvider.select((state) {
        final key = '$recordId|encounter_main:0';
        return state.current[key]?['M_Specialist_ID'] ??
            originalData['M_Specialist_ID'];
      }),
    );
    final docTypeValue = ref.watch(
      formDataProvider.select((state) {
        final key = '$recordId|encounter_main:0';
        return state.current[key]?['C_DocType_ID'] ??
            originalData['C_DocType_ID'];
      }),
    );

    final dataForRules = Map<String, dynamic>.from(originalData);
    dataForRules['M_Specialist_ID'] = specialistValue;
    dataForRules['C_DocType_ID'] = docTypeValue;
    return dataForRules;
  }

  void _updateController(dynamic value) {
    final newText = _getDisplayValue(value);
    if (_controller.text != newText) {
      _controller.text = newText;
    }
  }

  String _getDisplayValue(dynamic value) {
    if (value == null) return '';
    if (value is GeneralInfo) return value.identifier;
    if (value is Map) return value['identifier']?.toString() ?? '';
    if (value is DateTime) return DateFormat('dd/MM/yyyy').format(value);
    if (value is String && _isDateString(value)) {
      try {
        return DateFormat('dd/MM/yyyy').format(DateTime.parse(value));
      } catch (_) {
        return value;
      }
    }
    return value.toString();
  }

  bool _isValueEmpty(dynamic value) {
    if (value == null) return true;
    if (value is String && value.isEmpty) return true;
    if (value is GeneralInfo && (value.identifier.isEmpty)) return true;
    if (value is Map &&
        (value['identifier'] == null ||
            (value['identifier'] as String).isEmpty)) {
      return true;
    }
    return false;
  }

  bool _isDateString(String value) {
    try {
      DateTime.parse(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  Widget _buildFieldWidget(
    dynamic currentValue,
    Map<String, dynamic> dataForRules,
    bool isEditable,
    bool showErrorState,
  ) {
    if (!isEditable) {
      return _buildReadOnlyField();
    }
    return _buildFieldByType(
      _config.fieldType ?? FieldType.text,
      currentValue,
      dataForRules,
      showErrorState,
    );
  }

  Widget _buildFieldByType(
    FieldType fieldType,
    dynamic currentValue,
    Map<String, dynamic> dataForRules,
    bool showErrorState,
  ) {
    switch (fieldType) {
      case FieldType.generalInfo:
        return _buildGeneralInfoDropdown(
          currentValue,
          dataForRules,
          showErrorState,
        );
      case FieldType.multipleGeneralInfo:
        return _buildMultipleGeneralInfoDropdown(
          currentValue,
          dataForRules,
          showErrorState,
        );

      case FieldType.bpartnerSearch:
        return _buildBPartnerSearchField(dataForRules, showErrorState);
      case FieldType.date:
        return _buildDatePicker(currentValue, showErrorState);
      case FieldType.boolean:
        return _buildCheckbox(currentValue);
      case FieldType.number:
        return _buildNumberField(showErrorState);
      default:
        return _buildTextField(showErrorState);
    }
  }

  InputDecoration _inputDecoration(
    bool showErrorState, {
    Widget? suffix,
    Widget? prefix,
    bool isDisabled = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = Theme.of(context).extension<AppThemeExtension>()!;

    final focusedBorderColor = colorScheme.primary;
    final focusedFillColor = appColors.focusedFillColor!;
    final enabledBorderColor = appColors.enabledBorderColor!;
    final disabledFillColor = appColors.disabledFillColor!;
    final disabledBorderColor = appColors.disabledBorderColor!;
    final enabledFillColor = appColors.enabledFillColor!;

    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: showErrorState ? colorScheme.error : enabledBorderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: showErrorState ? colorScheme.error : focusedBorderColor,
          width: 2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: disabledBorderColor),
      ),
      hoverColor: Colors.transparent,
      suffixIcon: suffix,
      prefixIcon: prefix,
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      filled: true,
      fillColor: isDisabled
          ? disabledFillColor
          : _isFocused
          ? focusedFillColor
          : enabledFillColor,
    );
  }

  String _buildFilterFor(String fieldName, Map<String, dynamic> dataForRules) {
    dynamic getDependencyId(String key) {
      final value = dataForRules[key];
      if (value is GeneralInfo) return value.id;
      if (value is Map) return value['id'];
      return null;
    }

    switch (fieldName) {
      case 'M_Specialist_ID':
        final salesRegionId = getDependencyId('C_SalesRegion_ID');
        return 'C_SalesRegion_ID=${salesRegionId ?? 0}';
      case 'Doctor_ID':
        final specialistId = getDependencyId('M_Specialist_ID');
        return 'M_Specialist_ID=${specialistId ?? 0}';
      case 'Assistant_ID':
        final salesRegionId = getDependencyId('C_SalesRegion_ID');
        return 'C_SalesRegion_ID=${salesRegionId ?? 0}';
      default:
        return '';
    }
  }

  Widget _buildFieldLabel(bool showErrorState) {
    final appColors = Theme.of(context).extension<AppThemeExtension>()!;
    final String labelText =
        fieldLabels[widget.fieldName] ?? _formatFieldName(widget.fieldName);

    return Row(
      children: [
        if (_config.icon != null) ...[
          Icon(_config.icon, size: 16, color: appColors.labelIconColor),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            labelText,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: appColors.labelTextColor,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ),
        if (showErrorState)
          Text(
            '*',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
      ],
    );
  }

  String _formatFieldName(String fieldName) => fieldName
      .replaceAll('_', ' ')
      .split(' ')
      .map(
        (w) => w.isEmpty
            ? ''
            : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}',
      )
      .join(' ');

  Widget _buildReadOnlyField() => SizedBox(
    height: _config.multiLine == true ? null : 44,
    child: TextFormField(
      controller: _controller,
      readOnly: true,
      maxLines: _config.maxLines ?? 1,
      style: const TextStyle(fontSize: 14),
      decoration: _inputDecoration(
        false,
        suffix: _buildSuffix(disabled: true, includeType: false),
        isDisabled: true,
      ),
    ),
  );

  String _resolveModelNameFromFieldName(String fieldName) =>
      fieldName.contains('_ID')
      ? fieldName.replaceAll('_ID', '').toLowerCase()
      : fieldName.toLowerCase();

  Widget _buildGeneralInfoDropdown(
    dynamic currentValue,
    Map<String, dynamic> dataForRules,
    bool showErrorState,
  ) {
    final modelName = _resolveModelNameFromFieldName(widget.fieldName);
    GeneralInfo? selectedValue;
    if (currentValue is GeneralInfo) {
      selectedValue = currentValue;
    } else if (currentValue is Map<String, dynamic>) {
      selectedValue = GeneralInfo.fromJson(currentValue);
    }

    bool isDropdownEnabled = true;
    if (widget.fieldName == 'M_Specialist_ID' &&
        dataForRules['C_SalesRegion_ID'] == null) {
      isDropdownEnabled = false;
    }
    if (widget.fieldName == 'Doctor_ID' &&
        dataForRules['M_Specialist_ID'] == null) {
      isDropdownEnabled = false;
    }

    return SizedBox(
      height: 44,
      child: DropdownSearch<GeneralInfo>(
        enabled: isDropdownEnabled,
        selectedItem: selectedValue,
        asyncItems: (String filter) {
          if (widget.fieldName == 'BirthControlMethod') {
            return ref
                .read(sharedDataRepositoryProvider)
                .getReferenceList('1000007');
          } else if (widget.fieldName == 'UterusPosition') {
            return ref
                .read(sharedDataRepositoryProvider)
                .getReferenceList('1000008');
          } else if (widget.fieldName == 'Presentation') {
            return ref
                .read(sharedDataRepositoryProvider)
                .getReferenceList('1000010');
          } else if (widget.fieldName == 'PlacentaPosition') {
            return ref
                .read(sharedDataRepositoryProvider)
                .getReferenceList('1000009');
          } else if (widget.fieldName == 'Gender') {
            return ref
                .read(sharedDataRepositoryProvider)
                .getReferenceList('1000005');
          } else if (widget.fieldName == 'Cairan_Ketuban') {
            return ref
                .read(sharedDataRepositoryProvider)
                .getReferenceList('1000030');
          } else {
            final filterString = _buildFilterFor(
              widget.fieldName,
              dataForRules,
            );
            return ref
                .read(sharedDataRepositoryProvider)
                .searchModelData(
                  modelName: modelName,
                  query: filter,
                  filter: filterString,
                );
          }
        },
        compareFn: (item1, item2) => item1.id == item2.id,
        itemAsString: (item) => item.identifier,
        onChanged: _onChanged,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          dropdownSearchDecoration: _inputDecoration(
            showErrorState,
            isDisabled: !isDropdownEnabled,
          ),
        ),
        popupProps: const PopupProps.menu(
          showSelectedItems: true,
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: 'Cari...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMultipleGeneralInfoDropdown(
    dynamic currentValue,
    Map<String, dynamic> dataForRules,
    bool showErrorState,
  ) {
    final List<GeneralInfo> selectedItems = parseMultipleGeneralInfo(
      currentValue,
    );

    bool isDropdownEnabled = widget.isEditable ?? _config.editable;
    return DropdownSearch<GeneralInfo>.multiSelection(
      enabled: isDropdownEnabled,
      selectedItems: selectedItems,
      compareFn: (item1, item2) => item1.id == item2.id,
      itemAsString: (item) => item.identifier,
      asyncItems: (String filter) =>
          ref.read(sharedDataRepositoryProvider).searchIcd10(filter),
      onChanged: (List<GeneralInfo> selectedList) {
        if (selectedList.isEmpty) {
          _onChanged(null);
          return;
        }
        final combinedIds = selectedList.map((e) => e.id).join(',');
        final combinedIdentifiers = selectedList
            .map((e) => e.identifier)
            .join(',');
        final singleGeneralInfo = GeneralInfo(
          id: combinedIds,
          identifier: combinedIdentifiers,
          propertyLabel: 'ICD_10',
          modelName: 'icd',
        );
        _onChanged(singleGeneralInfo);
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        dropdownSearchDecoration: _inputDecoration(
          showErrorState,
          isDisabled: !isDropdownEnabled,
        ),
      ),
      popupProps: PopupPropsMultiSelection.menu(
        showSelectedItems: true,
        showSearchBox: true,
        isFilterOnline: true,
        loadingBuilder: (context, searchEntry) =>
            const Center(child: CircularProgressIndicator()),
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Cari berdasarkan kode atau nama...',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCECECE)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBPartnerSearchField(
    Map<String, dynamic> dataForRules,
    bool showErrorState,
  ) {
    bool isFieldEnabled = true;
    if (widget.fieldName == 'C_BPartnerRelation_ID' &&
        _config.isEditableRule != null) {
      isFieldEnabled = _config.isEditableRule!(dataForRules);
    }
    return SizedBox(
      height: 44,
      child: TextFormField(
        controller: _controller,
        readOnly: true,
        style: const TextStyle(fontSize: 14),
        onTap: !isFieldEnabled
            ? null
            : () async {
                final result = await showDialog<GeneralInfo>(
                  context: context,
                  builder: (context) =>
                      BPartnerSearchDialog(initialQuery: _controller.text),
                );
                if (result != null) _onChanged(result);
              },
        decoration: _inputDecoration(
          showErrorState,
          isDisabled: !isFieldEnabled,
          suffix: _buildSuffix(
            disabled: false,
            includeType: false,
            extra: Icon(
              Icons.tab_unselected_outlined,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(dynamic currentValue, bool showErrorState) {
    return SizedBox(
      height: 44,
      child: TextFormField(
        focusNode: _focusNode,
        controller: _controller,
        readOnly: true,
        style: const TextStyle(fontSize: 14),
        decoration: _inputDecoration(
          showErrorState,
          suffix: _buildSuffix(
            disabled: false,
            includeType: false,
            extra: const Icon(Icons.calendar_today, size: 20),
          ),
        ),
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate:
                DateTime.tryParse(currentValue?.toString() ?? '') ??
                DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (date != null) _onChanged(DateFormat('yyyy-MM-dd').format(date));
        },
      ),
    );
  }

  Widget _buildCheckbox(dynamic currentValue) => SizedBox(
    height: 44,
    child: Row(
      children: [
        Focus(
          focusNode: _focusNode,
          child: Checkbox(
            value: currentValue as bool? ?? false,
            onChanged: (value) => _onChanged(value ?? false),
          ),
        ),
        const Text('Yes'),
      ],
    ),
  );

  Widget _buildNumberField(bool showErrorState) => SizedBox(
    height: 44,
    child: TextFormField(
      focusNode: _focusNode,
      controller: _controller,
      decoration: _inputDecoration(
        showErrorState,
        suffix: _buildSuffix(disabled: false, includeType: true),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontSize: 14,
      ),
      onChanged: (value) =>
          value.isEmpty ? _onChanged(null) : _onChanged(num.tryParse(value)),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d{0,2}')),
      ],
    ),
  );

  Widget _buildTextField(bool showErrorState) => SizedBox(
    height: _config.multiLine == true ? null : 44,
    child: TextFormField(
      focusNode: _focusNode,
      controller: _controller,
      maxLines: _config.maxLines ?? 1,
      style: const TextStyle(fontSize: 14),
      decoration: _inputDecoration(
        showErrorState,
        suffix: _buildSuffix(disabled: false, includeType: true),
      ),
      onChanged: _onChanged,
    ),
  );

  Widget? _buildInlineTypeText() {
    switch (_config.fieldType) {
      case FieldType.number:
        return _typeText('123');
      case FieldType.text:
        return _typeText('Tt');
      default:
        return null;
    }
  }

  Widget _typeText(String label) => Text(
    label,
    style: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).extension<AppThemeExtension>()!.helperTextColor,
    ),
    overflow: TextOverflow.ellipsis,
    softWrap: false,
  );

  Widget _buildSuffix({
    required bool disabled,
    bool includeType = false,
    Widget? extra,
  }) {
    final children = <Widget>[];
    if (includeType) {
      final typeWidget = _buildInlineTypeText();
      if (typeWidget != null) children.add(typeWidget);
    }
    if (disabled) {
      if (children.isNotEmpty) children.add(const SizedBox(width: 6));
      children.add(
        Icon(
          Icons.lock,
          size: 16,
          color: Theme.of(
            context,
          ).extension<AppThemeExtension>()!.disabledIconColor,
        ),
      );
    }
    if (extra != null) {
      if (children.isNotEmpty) children.add(const SizedBox(width: 6));
      children.add(extra);
    }
    if (children.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: children,
      ),
    );
  }
}
