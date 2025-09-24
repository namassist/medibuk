import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';
import 'package:medibuk/presentation/providers/encounter_record_providers.dart';
import 'package:medibuk/presentation/providers/form_data_provider.dart';
import 'package:medibuk/presentation/providers/ui_providers.dart';
import 'package:medibuk/presentation/utils/json_patcher.dart';
import 'package:medibuk/presentation/widgets/core/app_form_section.dart';
import 'package:medibuk/presentation/widgets/core/app_toolbar.dart';
import 'package:medibuk/presentation/widgets/shared/dialogs.dart';

class EncounterScreen extends ConsumerWidget {
  final String encounterId;

  const EncounterScreen({super.key, required this.encounterId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final encounterAsync = ref.watch(EncounterNotifierProvider(encounterId));

    return Scaffold(
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

class _Content extends ConsumerStatefulWidget {
  final EncounterRecord record;

  const _Content({required this.record});

  @override
  ConsumerState<_Content> createState() => _ContentState();
}

class _ContentState extends ConsumerState<_Content> {
  Future<void> _save(int recordId) async {
    final navigator = Navigator.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

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

      if (!mounted) return;
      navigator.pop();

      await showSuccessDialog(
        context: context,
        title: 'Sukses',
        message: 'Data encounter berhasil disimpan.',
      );
    } catch (e) {
      if (!mounted) return;
      navigator.pop();
      await showErrorDialog(
        context: context,
        title: 'Gagal Menyimpan',
        message: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isModified = ref.watch(formModificationNotifierProvider);
    final record = widget.record;

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _PinnedHeaderDelegate(
            minExtentHeight: 215,
            maxExtentHeight: 215,
            child: AppToolbar(
              title: 'Encounter - ${record.documentNo}',
              status: record.documentStatus,
              onRefresh: () {
                ref.invalidate(EncounterNotifierProvider(record.id.toString()));
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Data reloaded.')));
              },
              actions: [
                SizedBox(
                  height: 40,
                  child: FilledButton.icon(
                    icon: Icon(Icons.save, size: 18),
                    label: Text(
                      "Save",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: isModified ? () => _save(record.id) : null,
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
              AppFormSection(
                title: 'Information',
                data: record.toJson(),
                isEditable: record.docStatus.id != 'CO',
                sectionType: 'encounter_information',
                sectionIndex: 0,
                recordId: record.uid,
              ),
              const SizedBox(height: 16),
              AppFormSection(
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
