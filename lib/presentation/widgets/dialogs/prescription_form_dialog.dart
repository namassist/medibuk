import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/domain/entities/prescription_record.dart';

class PrescriptionFormDialog extends ConsumerStatefulWidget {
  final PrescriptionRecord initialData;

  const PrescriptionFormDialog({super.key, required this.initialData});

  @override
  ConsumerState<PrescriptionFormDialog> createState() =>
      _PrescriptionFormDialogState();
}

class _PrescriptionFormDialogState
    extends ConsumerState<PrescriptionFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _qtyController;
  late TextEditingController _descriptionController;
  late GeneralInfo _selectedProduct;

  @override
  void initState() {
    super.initState();
    final data = widget.initialData;
    _selectedProduct = data.mProductId!;
    _qtyController = TextEditingController(text: data.qty?.toString() ?? '1');
    _descriptionController = TextEditingController(
      text: data.description ?? '',
    );
  }

  @override
  void dispose() {
    _qtyController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final result = PrescriptionRecord(
        id: widget.initialData.id,
        uid: widget.initialData.uid,
        mProductId: _selectedProduct,
        qty: num.tryParse(_qtyController.text) ?? 1,
        description: _descriptionController.text,
      );
      Navigator.of(context).pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Prescription'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Product', style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 4),
              Text(
                _selectedProduct.identifier,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Quantity Field
              TextFormField(
                controller: _qtyController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Quantity is required';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Please enter a valid quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _saveForm, child: const Text('Save Changes')),
      ],
    );
  }
}
