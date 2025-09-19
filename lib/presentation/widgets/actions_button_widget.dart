import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/presentation/providers/medical_record_providers.dart';
import '../../domain/entities/medical_record.dart';

// 🎯 OPTIMIZATION 23: Separate action buttons to prevent AppBar rebuilds
class ActionButtonsWidget extends ConsumerWidget {
  final MedicalRecord record;
  final String medicalRecordId;

  const ActionButtonsWidget({
    super.key,
    required this.record,
    required this.medicalRecordId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = record.docStatus.id == 'CO';
    final canEdit = !isCompleted;

    // 🎯 OPTIMIZATION 24: Watch only modification state
    final isModified = ref.watch(formModificationNotifierProvider);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStatusChip(isCompleted),
        const SizedBox(width: 8),
        if (canEdit && isModified) ...[
          _buildSaveButton(ref),
          const SizedBox(width: 8),
        ],
        if (canEdit) _buildCompleteButton(context, ref),
      ],
    );
  }

  Widget _buildStatusChip(bool isCompleted) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCompleted ? Colors.green[200]! : Colors.orange[200]!,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.edit,
            size: 16,
            color: isCompleted ? Colors.green[600] : Colors.orange[600],
          ),
          const SizedBox(width: 4),
          Text(
            record.docStatus.identifier,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isCompleted ? Colors.green[700] : Colors.orange[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(WidgetRef ref) {
    return TextButton.icon(
      onPressed: () => _saveChanges(ref),
      icon: const Icon(Icons.save, size: 18),
      label: const Text('Save'),
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue[50],
        foregroundColor: Colors.blue[700],
      ),
    );
  }

  Widget _buildCompleteButton(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () => _markAsComplete(context, ref),
      icon: const Icon(Icons.check, size: 18),
      label: const Text('Complete'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
      ),
    );
  }

  Future<void> _saveChanges(WidgetRef ref) async {
    try {
      await ref
          .read(
            optimizedMedicalRecordNotifierProvider(medicalRecordId).notifier,
          )
          .updateRecord(record);

      ref.read(formModificationNotifierProvider.notifier).reset();

      // Show success message without context dependency
      // TODO: Implement proper success feedback
    } catch (e) {
      // TODO: Implement proper error handling
      print('Save failed: $e');
    }
  }

  Future<void> _markAsComplete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mark as Complete'),
        content: const Text(
          'Are you sure you want to mark this record as complete? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Complete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final updatedRecord = record.copyWith(
          docStatus: const GeneralInfo(
            propertyLabel: 'Document Status',
            id: 'CO',
            identifier: 'Completed',
            modelName: 'ad_ref_list',
          ),
          processed: true,
        );

        await ref
            .read(
              optimizedMedicalRecordNotifierProvider(medicalRecordId).notifier,
            )
            .updateRecord(updatedRecord);

        ref.read(formModificationNotifierProvider.notifier).reset();
      } catch (e) {
        // TODO: Implement proper error handling
        print('Complete failed: $e');
      }
    }
  }
}
