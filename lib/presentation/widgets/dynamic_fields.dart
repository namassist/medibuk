import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import '../providers/medical_record_providers.dart';
import '../../domain/entities/medical_record.dart';
import '../../domain/entities/format_definition.dart';

class DynamicFields extends ConsumerStatefulWidget {
  final String fieldName;
  final dynamic value;
  final bool isEditable;
  final ValueChanged<dynamic> onChanged;
  final String? sectionType;

  const DynamicFields({
    super.key,
    required this.fieldName,
    required this.value,
    required this.isEditable,
    required this.onChanged,
    this.sectionType,
  });

  @override
  ConsumerState<DynamicFields> createState() => _DynamicFieldsState();
}

class _DynamicFieldsState extends ConsumerState<DynamicFields>
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

    _config = MedicalRecordFieldConfiguration.getConfig(
      widget.fieldName,
      section: widget.sectionType ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getDisplayValue(dynamic value) {
    if (value == null) return '';
    if (value is GeneralInfo) return value.identifier;
    if (value is String && _isDateString(value)) {
      return DateFormat('dd/MM/yyyy').format(DateTime.parse(value));
    }
    return value.toString();
  }

  bool _isDateString(String value) {
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
    return Row(
      children: [
        if (_config.icon != null) ...[
          Icon(_config.icon, size: 16, color: Colors.blue[600]),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            _formatFieldName(widget.fieldName),
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

    // Check if field type is explicitly defined in configuration
    if (_config.fieldType != null) {
      return _buildFieldByType(_config.fieldType!);
    }

    // Fallback to runtime type checking
    if (widget.value is GeneralInfo) {
      return _buildOptimizedGeneralInfoDropdown(widget.value as GeneralInfo);
    }

    if (widget.value is String && _isDateString(widget.value.toString())) {
      return _buildDatePicker();
    }

    if (widget.value is bool) {
      return _buildCheckbox();
    }

    if (widget.value is num) {
      return _buildNumberField();
    }

    return _buildTextField();
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

    return Consumer(
      builder: (context, ref, _) {
        final optionsAsync = ref.watch(
          cachedGeneralInfoOptionsProvider(modelName),
        );

        return optionsAsync.when(
          data: (options) => DropdownSearch<GeneralInfo>(
            compareFn: (item1, item2) => item1.id == item2.id,
            items: options,
            selectedItem: widget.value is GeneralInfo
                ? widget.value as GeneralInfo
                : null,
            itemAsString: (item) => item.identifier,
            onChanged: widget.onChanged,
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: TextStyle(
                decorationColor: Theme.of(context).colorScheme.onSurface,
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
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
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'Error loading options',
                style: TextStyle(color: Colors.red[600]),
              ),
            ),
          ),
        );
      },
    );
  }

  String _resolveModelNameFromFieldName(String fieldName) {
    // Map field names to their corresponding model names
    switch (fieldName.toLowerCase()) {
      case 'tipe_pemeriksaan':
        return 'ad_ref_list:tipe_pemeriksaan';
      case 'icd_10':
        return 'icd_10';
      case 'doctor_id':
        return 'c_bpartner';
      case 'm_specialist_id':
        return 'm_specialist';
      case 'c_salesregion_id':
        return 'c_salesregion';
      case 'order_type_id':
        return 'order_type';
      default:
        return 'ad_ref_list:$fieldName';
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
          suffix: _buildSuffix(disabled: true, includeType: false),
        ),
      ),
    );
  }

  Widget _buildOptimizedGeneralInfoDropdown(GeneralInfo currentValue) {
    final modelName = _resolveModelName(currentValue, widget.fieldName);

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
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'Error loading options',
                style: TextStyle(color: Colors.red[600]),
              ),
            ),
          ),
        );
      },
    );
  }

  String _resolveModelName(GeneralInfo currentValue, String fieldName) {
    final raw = (currentValue.modelName ?? '').toLowerCase();
    if (raw == 'ad_ref_list') return 'ad_ref_list:$fieldName';
    if (raw.isEmpty) {
      // Fallbacks for known fields without model-name in payload
      switch (fieldName) {
        case 'ICD_10':
          return 'icd_10';
        default:
          return '';
      }
    }
    return raw;
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
                DateTime.tryParse(widget.value.toString()) ?? DateTime.now(),
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
    return Row(
      children: [
        Checkbox(
          value: widget.value as bool? ?? false,
          onChanged: (value) => widget.onChanged(value ?? false),
        ),
        const Text('Yes'),
      ],
    );
  }

  Widget _buildNumberField() {
    return SizedBox(
      height: 44,
      child: TextFormField(
        controller: _controller,
        decoration: _inputDecoration(
          false,
          suffix: _buildSuffix(disabled: false),
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
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        textInputAction: TextInputAction.done,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d{0,2}')),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    final showType =
        (_config.maxLines == null || _config.maxLines == 1) &&
        (widget.value is String) &&
        !(widget.value is String && _isDateString(widget.value as String));
    return SizedBox(
      height: _config.multiLine == true ? null : 44,
      child: TextFormField(
        controller: _controller,
        maxLines: _config.maxLines ?? 1,
        style: const TextStyle(fontSize: 14),
        decoration: _inputDecoration(
          false,
          suffix: _buildSuffix(disabled: false, forceType: showType),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }

  // Build a small inline text to indicate field type (text vs number)
  Widget? _buildInlineTypeText() {
    if (widget.value is num) {
      return _typeText('123');
    }
    if (widget.value is String && !_isDateString(widget.value as String)) {
      return _typeText('Tt');
    }
    return null;
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

  // Wrap interactive field with hover behavior (no hover when disabled)
  Widget _wrapWithHover(Widget child, bool disabled) {
    if (disabled) return child;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: child,
    );
  }

  // Input decoration that reacts to hover state
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
      contentPadding: const EdgeInsets.all(12),
      border: baseBorder,
      enabledBorder: _isHovering ? hoverBorder : baseBorder,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      suffix: suffix,
      prefixIcon: prefix == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: 8, right: 4),
              child: prefix,
            ),
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      filled: true,
      fillColor: disabled ? Colors.grey[300] : Colors.white,
    );
  }

  // Compose suffix content aligned to the right: type label and optional lock and/or extra widget
  Widget _buildSuffix({
    required bool disabled,
    bool? includeType,
    bool forceType = false,
    Widget? extra,
  }) {
    final children = <Widget>[];
    Widget? typeWidget;
    if (forceType) {
      typeWidget = _typeText(widget.value is num ? '123' : 'Tt');
    } else if (includeType ?? true) {
      typeWidget = _buildInlineTypeText();
    }
    if (typeWidget != null) {
      children.add(Flexible(child: typeWidget));
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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 120),
      child: Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}
