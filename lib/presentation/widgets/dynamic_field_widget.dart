import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:medibuk/presentation/providers/medical_record_providers.dart';
import '../../domain/entities/medical_record.dart';
import '../../domain/entities/format_definition.dart';

// 🎯 OPTIMIZATION 20: Pure widget with minimal state
class OptimizedDynamicFieldWidget extends ConsumerStatefulWidget {
  final String fieldName;
  final dynamic value;
  final bool isEditable;
  final ValueChanged<dynamic> onChanged;

  const OptimizedDynamicFieldWidget({
    super.key,
    required this.fieldName,
    required this.value,
    required this.isEditable,
    required this.onChanged,
  });

  @override
  ConsumerState<OptimizedDynamicFieldWidget> createState() =>
      _OptimizedDynamicFieldWidgetState();
}

class _OptimizedDynamicFieldWidgetState
    extends ConsumerState<OptimizedDynamicFieldWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final TextEditingController _controller;
  late final FormatDefinition _config;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _getDisplayValue(widget.value));
    _config =
        FieldConfiguration.configurations[widget.fieldName] ??
        const FormatDefinition();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 🎯 OPTIMIZATION 21: Cached display value computation
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
          _buildFieldWidget(),
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
            widget.fieldName,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
              fontSize: 12,
            ),
          ),
        ),
        if (_config.isMandatory)
          Text('*', style: TextStyle(color: Colors.red[600])),
      ],
    );
  }

  Widget _buildFieldWidget() {
    if (!widget.isEditable || !_config.editable) {
      return _buildReadOnlyField();
    }

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

  Widget _buildReadOnlyField() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _getDisplayValue(widget.value),
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }

  // 🎯 OPTIMIZATION 22: Use cached dropdown options
  Widget _buildOptimizedGeneralInfoDropdown(GeneralInfo currentValue) {
    final modelName = currentValue.modelName ?? '';

    return Consumer(
      builder: (context, ref, _) {
        final optionsAsync = ref.watch(
          cachedGeneralInfoOptionsProvider(modelName),
        );

        return optionsAsync.when(
          data: (options) => DropdownSearch<GeneralInfo>(
            items: options,
            selectedItem: currentValue,
            itemAsString: (item) => item.identifier,
            onChanged: widget.onChanged,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
              ),
            ),
            popupProps: const PopupProps.menu(
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

  Widget _buildDatePicker() {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        suffixIcon: const Icon(Icons.calendar_today, size: 20),
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
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      onChanged: (value) {
        final numValue = num.tryParse(value);
        if (numValue != null) {
          widget.onChanged(numValue);
        }
      },
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      controller: _controller,
      maxLines: _config.maxLines ?? 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
