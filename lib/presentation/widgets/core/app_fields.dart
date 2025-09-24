import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:medibuk/domain/entities/field_config.dart';
import 'package:medibuk/domain/entities/fields_dictionary.dart';
import 'package:medibuk/presentation/providers/medical_record_providers.dart';
import 'package:medibuk/domain/entities/medical_record.dart';
import 'package:medibuk/domain/entities/format_definition.dart';

class AppFields extends ConsumerStatefulWidget {
  final String fieldName;
  final dynamic value;
  final bool isEditable;
  final ValueChanged<dynamic> onChanged;
  final String? sectionType;

  const AppFields({
    super.key,
    required this.fieldName,
    required this.value,
    required this.isEditable,
    required this.onChanged,
    this.sectionType,
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
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _getDisplayValue(widget.value));

    _config = FieldConfig.getConfig(
      widget.fieldName,
      section: widget.sectionType ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
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
          _wrapWithHover(_buildFieldWidget(), _isDisabled),
        ],
      ),
    );
  }

  Widget _buildFieldLabel() {
    final String labelText =
        fieldLabels[widget.fieldName] ?? _formatFieldName(widget.fieldName);

    return Row(
      children: [
        if (_config.icon != null) ...[
          Icon(_config.icon, size: 16, color: Colors.blue[600]),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            labelText,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ),
        if (_config.isMandatory)
          Text('*', style: TextStyle(color: Colors.red[600])),
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

  bool get _isDisabled => !widget.isEditable || !_config.editable;

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
      height: _config.multiLine == true ? null : 40,
      child: TextFormField(
        controller: _controller,
        readOnly: true,
        style: const TextStyle(fontSize: 14),
        decoration: _inputDecoration(
          true,
          suffix: _buildSuffix(disabled: true, includeType: true),
        ),
      ),
    );
  }

  Widget _buildGeneralInfoDropdown() {
    final modelName = _resolveModelNameFromFieldName(widget.fieldName);
    final currentValue = widget.value is GeneralInfo
        ? widget.value as GeneralInfo
        : null;

    return Consumer(
      builder: (context, ref, _) {
        final optionsAsync = ref.watch(
          cachedGeneralInfoOptionsProvider(modelName),
        );

        return optionsAsync.when(
          data: (options) => DropdownSearch<GeneralInfo>(
            compareFn: (item1, item2) => item1.id == item2.id,
            items: options,
            selectedItem: currentValue,
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
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          loading: () => const SizedBox(
            height: 48,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => Container(
            height: 48,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red[300]!),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                'Error: Options not loaded',
                style: TextStyle(color: Colors.red[600]),
              ),
            ),
          ),
        );
      },
    );
  }

  String _resolveModelNameFromFieldName(String fieldName) {
    switch (fieldName) {
      case 'ICD_10':
        return 'icd_10';
      case 'Doctor_ID':
      case 'Assistant_ID':
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
          Checkbox(
            value: widget.value as bool? ?? false,
            onChanged: (value) => widget.onChanged(value ?? false),
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
          final numValue = num.tryParse(value);
          if (numValue != null) {
            widget.onChanged(numValue);
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
    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.grey[500],
      ),
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );
  }

  Widget _wrapWithHover(Widget child, bool disabled) {
    if (disabled) return child;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: child,
    );
  }

  InputDecoration _inputDecoration(
    bool disabled, {
    Widget? suffix,
    Widget? prefix,
  }) {
    final baseBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[400]!),
    );
    final hoverBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue[300]!),
    );
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: baseBorder,
      enabledBorder: _isHovering ? hoverBorder : baseBorder,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      suffixIcon: suffix,
      prefixIcon: prefix,
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      filled: true,
      fillColor: disabled ? Colors.grey[200] : Colors.white,
    );
  }

  Widget _buildSuffix({
    required bool disabled,
    bool includeType = false,
    Widget? extra,
  }) {
    final children = <Widget>[];

    if (includeType) {
      final typeWidget = _buildInlineTypeText();
      if (typeWidget != null) {
        children.add(typeWidget);
      }
    }

    if (disabled) {
      if (children.isNotEmpty) children.add(const SizedBox(width: 6));
      children.add(Icon(Icons.lock, size: 16, color: Colors.grey[600]));
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
