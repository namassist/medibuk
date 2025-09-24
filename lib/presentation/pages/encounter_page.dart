import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';
import 'package:medibuk/presentation/providers/encounter_record_providers.dart';
import 'package:medibuk/presentation/providers/form_data_provider.dart';
import 'package:medibuk/presentation/providers/ui_providers.dart';
import 'package:medibuk/presentation/utils/json_patcher.dart';
import 'package:medibuk/presentation/widgets/core/app_toolbar.dart';
import 'package:medibuk/presentation/widgets/fields/form_section.dart';

class EncounterScreen extends ConsumerWidget {
  final String encounterId;

  const EncounterScreen({super.key, required this.encounterId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final encounterAsync = ref.watch(EncounterNotifierProvider(encounterId));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: encounterAsync.when(
        data: (record) => record != null
            ? _Content(record: record)
            : const Center(child: Text('Encounter not found')),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Failed to load encounter: $error')),
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  final EncounterRecord record;

  const _Content({required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isModified = ref.watch(formModificationNotifierProvider);

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _PinnedHeaderDelegate(
            minExtentHeight: 210,
            maxExtentHeight: 210,
            child: AppToolbar(
              title: 'Encounter - ${record.documentNo}',
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Reload Data',
                  onPressed: () {
                    ref.invalidate(
                      EncounterNotifierProvider(record.id.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data reloaded.')),
                    );
                  },
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: isModified
                      ? () => _save(ref, context, record.id)
                      : null,
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[800],
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              FormSection(
                title: 'Information',
                data: record.toJson(),
                isEditable: record.docStatus.id != 'CO',
                sectionType: 'encounter_information',
                sectionIndex: 0,
                recordId: record.uid,
              ),
              const SizedBox(height: 16),
              FormSection(
                title: 'Patient Medical Information',
                data: record.toJson(),
                isEditable: record.docStatus.id != 'CO',
                sectionType: 'encounter_patient_medical',
                sectionIndex: 1,
                recordId: record.uid,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Future<void> _save(WidgetRef ref, BuildContext context, int recordId) async {
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(const SnackBar(content: Text('Saving...')));

    try {
      final currentState = await ref.read(
        EncounterNotifierProvider(recordId.toString()).future,
      );
      if (currentState == null) {
        throw Exception("Cannot save, record not found in state.");
      }

      final formState = ref.read(formDataProvider);

      final patchedJson = buildPatchedJsonFromModel(
        currentState,
        formState,
        currentState.uid,
        listSections: [],
      );

      final updatedRecord = EncounterRecord.fromJson(patchedJson);

      await ref
          .read(EncounterNotifierProvider(recordId.toString()).notifier)
          .updateRecord(updatedRecord);

      ref.read(formModificationNotifierProvider.notifier).reset();

      if (!context.mounted) return;
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Save successful!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Save failed: $e'), backgroundColor: Colors.red),
      );
    }
  }
}

class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minExtentHeight;
  final double maxExtentHeight;
  final Widget child;

  _PinnedHeaderDelegate({
    required this.minExtentHeight,
    required this.maxExtentHeight,
    required this.child,
  });

  @override
  double get minExtent => minExtentHeight;

  @override
  double get maxExtent => maxExtentHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(
      height: maxExtent,
      child: Container(color: Colors.white, child: child),
    );
  }

  @override
  bool shouldRebuild(covariant _PinnedHeaderDelegate oldDelegate) {
    return true;
  }
}
