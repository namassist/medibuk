import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/domain/entities/medical_record.dart';
import 'package:medibuk/presentation/providers/form_data_provider.dart';
import 'package:medibuk/presentation/providers/medical_record_providers.dart';
import 'package:medibuk/presentation/utils/json_patcher.dart';
import 'package:medibuk/presentation/widgets/layouts/app_clock.dart';
import 'package:medibuk/presentation/widgets/layouts/app_topbar.dart';

class AppToolbar extends ConsumerWidget {
  final MedicalRecord record;
  final String medicalRecordId;

  const AppToolbar({
    super.key,
    required this.record,
    required this.medicalRecordId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = record.docStatus.id == 'CO';
    final isModified = ref.watch(formModificationNotifierProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppTopBar(),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Medical Record - ${record.documentNo}',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        _IconButtonChip(
                          icon: Icons.refresh,
                          label: 'Reload',
                          onTap: () => ref.refresh(
                            MedicalRecordNotifierProvider(medicalRecordId),
                          ),
                        ),
                        const SizedBox(width: 10),
                        _StatusChip(
                          text: record.docStatus.identifier,
                          isCompleted: isCompleted,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const AppLiveClock(),
              const SizedBox(width: 12),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: isModified ? () => _save(ref, context) : null,
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[800],
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.badge_outlined),
                label: const Text('Encounter'),
              ),
              const Spacer(),
              if (!isCompleted)
                ElevatedButton.icon(
                  onPressed: () => _markAsComplete(context, ref),
                  icon: const Icon(Icons.check),
                  label: const Text('Complete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _save(WidgetRef ref, dynamic context) async {
    try {
      final formState = ref.read(formDataProvider);
      final patched = buildPatchedJsonFromModel(
        record,
        formState,
        medicalRecordId,
      );

      // Also show the JSON in a modal so it’s visible even if console truncates
      final pretty = const JsonEncoder.withIndent('  ').convert(patched);
      // ignore: use_build_context_synchronously
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Updated Record JSON'),
          content: SizedBox(
            width: 800,
            height: 500,
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: SelectableText(
                  pretty,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            ),
          ],
        ),
      );

      await ref
          .read(MedicalRecordNotifierProvider(medicalRecordId).notifier)
          .updateRecord(record);
      ref.read(formModificationNotifierProvider.notifier).reset();
      ref.read(formDataProvider.notifier).clear();
    } catch (e) {
      rethrow;
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
      final updatedRecord = record.copyWith(
        docStatus: const GeneralInfo(
          propertyLabel: 'Document Status',
          id: 'CO',
          identifier: 'Completed',
          modelName: 'ad_ref_list',
        ),
        processed: true,
      );

      try {
        await ref
            .read(MedicalRecordNotifierProvider(medicalRecordId).notifier)
            .updateRecord(updatedRecord);
        ref.read(formModificationNotifierProvider.notifier).reset();
      } catch (e) {
        rethrow;
      }
    }
  }
}

class _StatusChip extends StatelessWidget {
  final String text;
  final bool isCompleted;
  const _StatusChip({required this.text, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    final bg = isCompleted ? Colors.green[50] : Colors.blueGrey[50];
    final fg = isCompleted ? Colors.green[800] : Colors.blueGrey[800];
    final icon = isCompleted ? Icons.check_circle : Icons.folder_open;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (isCompleted ? Colors.green[200] : Colors.blueGrey[200])!,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: fg),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(color: fg, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _IconButtonChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _IconButtonChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.teal[800],
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
