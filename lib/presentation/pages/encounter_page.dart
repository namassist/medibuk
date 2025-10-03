import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';
import 'package:medibuk/presentation/providers/encounter_record_providers.dart';
import 'package:medibuk/presentation/providers/form_data_provider.dart';
import 'package:medibuk/presentation/providers/ui_providers.dart';
import 'package:medibuk/presentation/utils/json_patcher.dart';
import 'package:medibuk/presentation/utils/roles.dart';
import 'package:medibuk/presentation/widgets/core/action_buttons.dart';
import 'package:medibuk/presentation/widgets/core/app_form_section.dart';
import 'package:medibuk/presentation/widgets/core/app_layout.dart';
import 'package:medibuk/presentation/widgets/shared/dialogs.dart';

class EncounterScreen extends ConsumerWidget {
  final String encounterId;

  const EncounterScreen({super.key, required this.encounterId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final encounterAsync = ref.watch(EncounterNotifierProvider(encounterId));
    final userRole = ref.watch(currentUserRoleProvider);

    return encounterAsync.when(
      data: (record) {
        if (record == null) {
          return const Scaffold(
            body: Center(child: Text('Encounter not found')),
          );
        }
        return AppLayout(
          pageTitle: 'Encounter - ${record.documentNo}',
          pageStatus: record.documentStatus,
          onRefresh: () async {
            final navigator = Navigator.of(context);
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );

            ref.invalidate(EncounterNotifierProvider(encounterId));

            // Selalu reset perubahan form yang belum disimpan
            ref.read(formDataProvider.notifier).clear();
            ref.read(formModificationNotifierProvider.notifier).reset();

            if (!context.mounted) return;
            navigator.pop();
            if (encounterId != 'NEW') {
              await showSuccessDialog(
                context: context,
                title: 'Sukses',
                message: 'Data encounter berhasil diperbarui.',
              );
            }
          },
          pageActions: [
            if (userRole == Role.admin || userRole == Role.key)
              ActionDefinition(
                type: ActionButtonType.save,
                onPressed: () => _save(context, ref, record),
              ),

            ActionDefinition(
              type: ActionButtonType.medicalRecord,
              onPressed: () {
                // print('Tombol Delete ditekan!');
              },
            ),
            ActionDefinition(
              type: ActionButtonType.completed,
              onPressed: () {
                // print('Tombol Delete ditekan!');
              },
            ),
            ActionDefinition(
              type: ActionButtonType.order,
              onPressed: () {
                // print('Tombol Delete ditekan!');
              },
            ),
            ActionDefinition(
              type: ActionButtonType.printGeneral,
              onPressed: () {
                // print('Tombol Print ditekan!');
              },
            ),
          ],
          slivers: [SliverToBoxAdapter(child: _Content(record: record))],
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Failed to load encounter: $error')),
      ),
    );
  }

  Future<void> _save(
    BuildContext context,
    WidgetRef ref,
    EncounterRecord record,
  ) async {
    final navigator = Navigator.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final currentState = await ref.read(
        EncounterNotifierProvider(record.id.toString()).future,
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
          .read(EncounterNotifierProvider(record.id.toString()).notifier)
          .updateRecord(updatedRecord);
      ref.read(formModificationNotifierProvider.notifier).reset();

      if (!context.mounted) return;
      navigator.pop();

      await showSuccessDialog(
        context: context,
        title: 'Sukses',
        message: 'Data encounter berhasil disimpan.',
      );
    } catch (e) {
      if (!context.mounted) return;
      navigator.pop();
      await showErrorDialog(
        context: context,
        title: 'Gagal Menyimpan',
        message: e.toString(),
      );
    }
  }
}

class _Content extends ConsumerWidget {
  final EncounterRecord record;

  const _Content({required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isEditable =
        record.docStatus?.id != 'CO' && record.docStatus?.id != 'VO';

    final bool isPatientInfoEditable =
        record.docStatus?.id == 'DR' ||
        record.docStatus?.id == 'IP' ||
        record.docStatus?.id == 'IN';

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          AppFormSection(
            title: 'Information',
            data: record.toJson(),
            isEditable: isEditable,
            sectionType: 'encounter_information',
            sectionIndex: 0,
            recordId: record.uid,
          ),
          const SizedBox(height: 16),
          AppFormSection(
            title: 'Patient Medical Information',
            data: record.toJson(),
            isEditable: isPatientInfoEditable,
            sectionType: 'encounter_patient_medical',
            sectionIndex: 1,
            recordId: record.uid,
          ),
        ],
      ),
    );
  }
}
