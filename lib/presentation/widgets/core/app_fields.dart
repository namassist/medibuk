import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:medibuk/domain/entities/app_theme_extension.dart';
import 'package:medibuk/domain/entities/field_config.dart';
import 'package:medibuk/domain/entities/fields_dictionary.dart';
import 'package:medibuk/domain/entities/medical_record.dart';
import 'package:medibuk/domain/entities/format_definition.dart';
import 'package:medibuk/presentation/providers/shared_providers.dart';

class AppFields extends ConsumerStatefulWidget {
  final String fieldName;
  final dynamic value;
  final bool isEditable;
  final ValueChanged<dynamic> onChanged;
  final String? sectionType;
  final Map<String, dynamic> allSectionData;

  const AppFields({
    super.key,
    required this.fieldName,
    required this.value,
    required this.isEditable,
    required this.onChanged,
    this.sectionType,
    required this.allSectionData,
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

  bool get _showErrorState {
    if (_isDisabled || !_config.isMandatory) {
      return false;
    }
    return (_hasBeenTouched || _isFocused) && _isValueEmpty();
  }

  bool _isValueEmpty() {
    final value = widget.value;
    if (value == null) return true;
    if (value is String && value.isEmpty) return true;
    if (value is num && value == 0) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _getDisplayValue(widget.value));
    _config = FieldConfig.getConfig(
      widget.fieldName,
      section: widget.sectionType ?? '',
    );

    if (_config.isMandatory) {
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
      final newText = _getDisplayValue(widget.value);
      if (_controller.text != newText) {
        _controller.text = newText;
      }
    }
  }

  String _getDisplayValue(dynamic value) {
    if (value == null) return '';
    if (value is GeneralInfo) return value.identifier;
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

    if (_config.isHidden == true) return const SizedBox.shrink();

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

  bool get _isDisabled {
    if (widget.fieldName == 'C_BPartnerRelation_ID') {
      final specialist = widget.allSectionData['M_Specialist_ID'];

      if (specialist is GeneralInfo &&
          specialist.identifier.toLowerCase().contains('laktasi')) {
        return !widget.isEditable;
      } else {
        return true;
      }
    }

    return !widget.isEditable || !_config.editable;
  }

  Widget _buildFieldWidget() {
    if (_isDisabled) {
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

  Widget _buildGeneralInfoDropdown() {
    final modelName = _resolveModelNameFromFieldName(widget.fieldName);
    final currentValue = widget.value is GeneralInfo
        ? widget.value as GeneralInfo
        : null;

    return SizedBox(
      height: 44,
      child: DropdownSearch<GeneralInfo>(
        selectedItem: currentValue,
        asyncItems: (String filter) async {
          late final GeneralInfoParameter providerParam;

          if (modelName == 'Doctor_ID') {
            final specialist =
                widget.allSectionData['M_Specialist_ID'] as GeneralInfo?;
            if (specialist == null) return [];

            providerParam = GeneralInfoParameter(
              modelName: modelName,
              dependencies: {'M_Specialist_ID': specialist.id},
            );
          } else {
            providerParam = GeneralInfoParameter(modelName: modelName);
          }

          return await ref.read(
            cachedGeneralInfoOptionsProvider(providerParam).future,
          );
        },
        compareFn: (item1, item2) => item1.id == item2.id,
        itemAsString: (item) => item.identifier,
        onChanged: widget.onChanged,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(
            decorationColor: Theme.of(context).colorScheme.onSurface,
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 14,
          ),
          dropdownSearchDecoration: _inputDecoration(false),
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

  String _resolveModelNameFromFieldName(String fieldName) {
    switch (fieldName) {
      case 'ICD_10':
        return 'icd_10';
      case 'Doctor_ID':
        return 'Doctor_ID';
      case 'Assistant_ID':
        return 'Assistant_ID';
      case 'C_BPartner_ID':
        return 'c_bpartner';
      case 'M_Specialist_ID':
        return 'm_specialist';
      case 'C_SalesRegion_ID':
        return 'c_salesregion';
      case 'OrderType_ID':
        return 'ordertype';
      default:
        return 'ad_ref_list:${fieldName.toLowerCase()}';
    }
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

  InputDecoration _inputDecoration(
    bool disabled, {
    Widget? suffix,
    Widget? prefix,
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
      fillColor: disabled
          ? disabledFillColor
          : _isFocused
          ? focusedFillColor
          : enabledFillColor,
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
