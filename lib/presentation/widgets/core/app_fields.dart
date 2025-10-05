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

class AppFields extends ConsumerStatefulWidget {
  final String fieldName;
  final dynamic value;
  final ValueChanged<dynamic> onChanged;
  final String? sectionType;
  final Map<String, dynamic> allSectionData;

  final bool? isEditable;
  final bool? isMandatory;

  const AppFields({
    super.key,
    required this.fieldName,
    required this.value,
    required this.onChanged,
    this.sectionType,
    required this.allSectionData,
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

  bool get _isDisabled => !(widget.isEditable ?? _config.editable);
  bool get _isMandatory => widget.isMandatory ?? _config.isMandatory;

  bool get _showErrorState {
    if (_isDisabled || !_isMandatory) {
      return false;
    }
    return (_hasBeenTouched || _isFocused) && _isValueEmpty();
  }

  bool _isValueEmpty() {
    final value = widget.value;
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

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _config = FieldConfig.getConfig(
      widget.fieldName,
      section: widget.sectionType ?? '',
    );

    if (_isMandatory) {
      _hasBeenTouched = true;
    }

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
        if (!_isFocused && !_hasBeenTouched) {
          _hasBeenTouched = true;
        }
      });
    });

    _updateController(widget.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AppFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _updateController(widget.value);
    }
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

  bool _isDateString(String value) {
    if (value.length < 10) return false;
    try {
      DateTime.parse(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldLabel(),
          const SizedBox(height: 4),
          _buildFieldWidget(),
        ],
      ),
    );
  }

  Widget _buildFieldWidget() {
    final bool isFieldDisabled = !(widget.isEditable ?? _config.editable);

    if (isFieldDisabled) {
      return _buildReadOnlyField();
    }
    return _buildFieldByType(_config.fieldType ?? FieldType.text);
  }

  Widget _buildFieldByType(FieldType fieldType) {
    switch (fieldType) {
      case FieldType.generalInfo:
        return _buildGeneralInfoDropdown();
      case FieldType.date:
        return _buildDatePicker();
      case FieldType.boolean:
        return _buildCheckbox();
      case FieldType.number:
        return _buildNumberField();
      case FieldType.text:
        return _buildTextField();
    }
  }

  Widget _buildGeneralInfoDropdown() {
    final modelName = _resolveModelNameFromFieldName(widget.fieldName);

    GeneralInfo? currentValue;
    if (widget.value is GeneralInfo) {
      currentValue = widget.value as GeneralInfo;
    } else if (widget.value is Map<String, dynamic>) {
      currentValue = GeneralInfo.fromJson(widget.value);
    }

    bool isDropdownEnabled = !(widget.isEditable == false);

    if (widget.fieldName == 'M_Specialist_ID') {
      final salesRegionValue = widget.allSectionData['C_SalesRegion_ID'];
      if (salesRegionValue == null) {
        isDropdownEnabled = false;
      }
    }

    if (widget.fieldName == 'Doctor_ID' &&
        widget.allSectionData['M_Specialist_ID'] == null) {
      isDropdownEnabled = false;
    }

    return SizedBox(
      height: 44,
      child: DropdownSearch<GeneralInfo>(
        enabled: isDropdownEnabled,
        selectedItem: currentValue,
        asyncItems: (String filter) {
          String filterString = _buildFilterFor(widget.fieldName);
          return ref
              .read(sharedDataRepositoryProvider)
              .searchModelData(
                modelName: modelName,
                query: filter,
                filter: filterString,
              );
        },
        compareFn: (item1, item2) => item1.id == item2.id,
        itemAsString: (item) => item.identifier,
        onChanged: widget.onChanged,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          dropdownSearchDecoration: _inputDecoration(
            false,
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
        validator: (item) {
          if (_isMandatory && item == null) {
            return 'Wajib diisi';
          }
          return null;
        },
      ),
    );
  }

  InputDecoration _inputDecoration(
    bool disabled, {
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
          color: _showErrorState ? colorScheme.error : enabledBorderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: _showErrorState ? colorScheme.error : focusedBorderColor,
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
      fillColor: (disabled || isDisabled)
          ? disabledFillColor
          : _isFocused
          ? focusedFillColor
          : enabledFillColor,
    );
  }

  String _buildFilterFor(String fieldName) {
    dynamic getDependencyId(String key) {
      final value = widget.allSectionData[key];
      if (value == null) return null;
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

  Widget _buildFieldLabel() {
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
        if (_showErrorState)
          Text(
            '*',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
      ],
    );
  }

  String _formatFieldName(String fieldName) {
    return fieldName
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? ''
              : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }

  Widget _buildReadOnlyField() {
    return SizedBox(
      height: _config.multiLine == true ? null : 44,
      child: TextFormField(
        controller: _controller,
        readOnly: true,
        maxLines: _config.maxLines ?? 1,
        style: const TextStyle(fontSize: 14),
        decoration: _inputDecoration(
          true,
          suffix: _buildSuffix(disabled: true, includeType: false),
        ),
      ),
    );
  }

  String _resolveModelNameFromFieldName(String fieldName) {
    if (fieldName.contains('_ID')) {
      return fieldName.replaceAll('_ID', '').toLowerCase();
    }
    return fieldName.toLowerCase();
  }

  Widget _buildDatePicker() {
    return SizedBox(
      height: 44,
      child: TextFormField(
        focusNode: _focusNode,
        controller: _controller,
        readOnly: true,
        style: const TextStyle(fontSize: 14),
        decoration: _inputDecoration(
          false,
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
                DateTime.tryParse(widget.value?.toString() ?? '') ??
                DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (date != null) {
            final formattedDate = DateFormat('yyyy-MM-dd').format(date);
            _controller.text = DateFormat('dd/MM/yyyy').format(date);
            widget.onChanged(formattedDate);
          }
        },
      ),
    );
  }

  Widget _buildCheckbox() {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          Focus(
            focusNode: _focusNode,
            child: Checkbox(
              value: widget.value as bool? ?? false,
              onChanged: (value) => widget.onChanged(value ?? false),
            ),
          ),
          const Text('Yes'),
        ],
      ),
    );
  }

  Widget _buildNumberField() {
    return SizedBox(
      height: 44,
      child: TextFormField(
        focusNode: _focusNode,
        controller: _controller,
        decoration: _inputDecoration(
          false,
          suffix: _buildSuffix(disabled: false, includeType: true),
        ),
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontSize: 14,
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            widget.onChanged(null);
          } else {
            final numValue = num.tryParse(value);
            if (numValue != null) {
              widget.onChanged(numValue);
            }
          }
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputAction: TextInputAction.done,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d{0,2}')),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return SizedBox(
      height: _config.multiLine == true ? null : 44,
      child: TextFormField(
        focusNode: _focusNode,
        controller: _controller,
        maxLines: _config.maxLines ?? 1,
        style: const TextStyle(fontSize: 14),
        decoration: _inputDecoration(
          false,
          suffix: _buildSuffix(disabled: false, includeType: true),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }

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

  Widget _typeText(String label) {
    final appColors = Theme.of(context).extension<AppThemeExtension>()!;

    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: appColors.helperTextColor,
      ),
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );
  }

  Widget _buildSuffix({
    required bool disabled,
    bool includeType = false,
    Widget? extra,
  }) {
    final appColors = Theme.of(context).extension<AppThemeExtension>()!;
    final children = <Widget>[];

    if (includeType) {
      final typeWidget = _buildInlineTypeText();
      if (typeWidget != null) {
        children.add(typeWidget);
      }
    }

    if (disabled) {
      if (children.isNotEmpty) children.add(const SizedBox(width: 6));
      children.add(
        Icon(Icons.lock, size: 16, color: appColors.disabledIconColor),
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
