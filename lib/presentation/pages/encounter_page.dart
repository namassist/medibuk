import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';
import 'package:medibuk/presentation/pages/medical_record_page.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';
import 'package:medibuk/presentation/providers/encounter_record_providers.dart';
import 'package:medibuk/presentation/providers/form_data_provider.dart';
import 'package:medibuk/presentation/providers/ui_providers.dart';
import 'package:medibuk/presentation/utils/json_patcher.dart';
import 'package:medibuk/presentation/utils/roles.dart';
import 'package:medibuk/presentation/widgets/auth_interceptor.dart';
import 'package:medibuk/presentation/widgets/core/action_buttons.dart';
import 'package:medibuk/presentation/widgets/core/app_form_section.dart';
import 'package:medibuk/presentation/widgets/core/app_layout.dart';
import 'package:medibuk/presentation/widgets/shared/dialogs.dart';

class EncounterScreen extends ConsumerStatefulWidget {
  final String encounterId;

  const EncounterScreen({super.key, required this.encounterId});

  @override
  ConsumerState<EncounterScreen> createState() => _EncounterScreenState();
}

class _EncounterScreenState extends ConsumerState<EncounterScreen> {
  int _refreshCounter = 0;

  @override
  Widget build(BuildContext context) {
    final providerId = widget.encounterId == '-1' ? 'NEW' : widget.encounterId;
    final encounterAsync = ref.watch(EncounterNotifierProvider(providerId));
    final userRole = ref.watch(currentUserRoleProvider);

    return encounterAsync.when(
      data: (record) {
        if (record == null) {
          return const Scaffold(
            body: Center(child: Text('Encounter not found')),
          );
        }
        return AuthInterceptor(
          child: AppLayout(
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

              setState(() {
                _refreshCounter++;
              });

              ref.invalidate(EncounterNotifierProvider(providerId));

              ref.read(formDataProvider.notifier).clear();
              ref.read(formModificationNotifierProvider.notifier).reset();

              if (!context.mounted) return;
              navigator.pop();
              if (widget.encounterId != '-1' && widget.encounterId != 'NEW') {
                await showSuccessDialog(
                  context: context,
                  title: 'Sukses',
                  message: 'Data encounter berhasil diperbarui.',
                );
              }
            },
            pageActions: [
              if (record.docStatus?.id != 'VO' && record.docStatus?.id != 'CO')
                ActionDefinition(
                  type: ActionButtonType.save,
                  onPressed: () => _save(context, ref, record),
                ),

              if (record.docStatus?.id == 'DR' || record.docStatus?.id == 'IN')
                if (record.cDocTypeId?.id != 1000047 &&
                    (record.isPaid ?? false))
                  ActionDefinition(
                    type: ActionButtonType.prepare,
                    onPressed: () => _prepare(context, ref, record),
                  ),

              if (record.docStatus?.id == 'IP')
                if (userRole == Role.bidan || userRole == Role.key)
                  ActionDefinition(
                    type: ActionButtonType.completed,
                    onPressed: () => _complete(context, ref, record),
                  ),

              if (record.docStatus?.id == 'DR')
                if (record.cDocTypeId?.id == 1000047)
                  ActionDefinition(
                    type: ActionButtonType.createSalesOrder,
                    onPressed: () => _complete(context, ref, record),
                  ),

              if (record.docStatus?.id == 'DR' || record.docStatus?.id == 'IP')
                if ((userRole == Role.admin || userRole == Role.key) &&
                    record.cDocTypeId?.id == 1000056)
                  ActionDefinition(
                    type: ActionButtonType.changePatient,
                    onPressed: () => _save(context, ref, record),
                  ),

              if (record.docStatus?.id == 'DR' || record.docStatus?.id == 'IP')
                if ((userRole == Role.admin || userRole == Role.key) &&
                    record.cDocTypeId?.id == 1000056)
                  ActionDefinition(
                    type: ActionButtonType.changeSchedule,
                    onPressed: () => _save(context, ref, record),
                  ),

              if (record.docStatus?.id == 'CO')
                if (record.cDocTypeId?.id != 1000047)
                  ActionDefinition(
                    type: ActionButtonType.medicalRecord,
                    onPressed: () {
                      final medicalRecordId = record.cMedicalRecordID?.id;
                      if (medicalRecordId != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MedicalRecordScreen(
                              medicalRecordId: medicalRecordId.toString(),
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Medical record ID not found.'),
                          ),
                        );
                      }
                    },
                  ),

              if (record.docStatus?.id == 'CO')
                if (record.cOrderID?.id != null &&
                    (userRole == Role.admin ||
                        userRole == Role.key ||
                        userRole == Role.bidan))
                  ActionDefinition(
                    type: ActionButtonType.order,
                    onPressed: () => _save(context, ref, record),
                  ),
            ],
            slivers: [
              SliverToBoxAdapter(
                child: _Content(
                  record: record,
                  refreshCounter: _refreshCounter,
                ),
              ),
            ],
          ),
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
    final providerId = (record.id == -1) ? 'NEW' : record.id.toString();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final currentState = await ref.read(
        EncounterNotifierProvider(providerId).future,
      );

      if (!context.mounted) return;
      if (currentState == null) {
        throw Exception("Cannot save, current record state is null.");
      }

      final formState = ref.read(formDataProvider);
      final mergedJson = buildPatchedJsonFromModel(
        currentState,
        formState,
        currentState.uid,
        listSections: [],
      );

      if (record.id == -1) {
        final recordToSend = EncounterRecord.fromJson(mergedJson);
        final newRecord = await ref
            .read(EncounterNotifierProvider(providerId).notifier)
            .createRecord(recordToSend);

        if (!context.mounted) return;
        navigator.pop();
        await showSuccessDialog(
          context: context,
          title: 'Sukses',
          message: 'Data encounter baru berhasil dibuat.',
        );

        if (!context.mounted) return;
        navigator.pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                EncounterScreen(encounterId: newRecord.id.toString()),
          ),
        );
      } else {
        var recordToSend = EncounterRecord.fromJson(mergedJson);
        recordToSend = recordToSend.copyWith(processed: null);

        await ref
            .read(EncounterNotifierProvider(providerId).notifier)
            .updateRecord(recordToSend);

        if (!context.mounted) return;
        navigator.pop();
        await showSuccessDialog(
          context: context,
          title: 'Sukses',
          message: 'Data encounter berhasil disimpan.',
        );
      }

      ref.read(formModificationNotifierProvider.notifier).reset();
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

  Future<void> _prepare(
    BuildContext context,
    WidgetRef ref,
    EncounterRecord record,
  ) async {
    final navigator = Navigator.of(context);
    final providerId = record.id.toString();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final currentState = await ref.read(
        EncounterNotifierProvider(providerId).future,
      );
      if (!context.mounted) return;
      if (currentState == null) {
        throw Exception("Cannot prepare, current record state is null.");
      }

      final formState = ref.read(formDataProvider);
      final mergedJson = buildPatchedJsonFromModel(
        currentState,
        formState,
        currentState.uid,
        listSections: [],
      );

      var recordToSend = EncounterRecord.fromJson(mergedJson);
      recordToSend = recordToSend.copyWith(docAction: 'PR', processed: null);

      await ref
          .read(EncounterNotifierProvider(providerId).notifier)
          .updateRecord(recordToSend);

      if (!context.mounted) return;
      navigator.pop();

      ref.invalidate(EncounterNotifierProvider(providerId));

      await showSuccessDialog(
        context: context,
        title: 'Sukses',
        message: 'Data encounter berhasil di-prepare.',
      );

      ref.read(formModificationNotifierProvider.notifier).reset();
    } catch (e) {
      if (!context.mounted) return;
      navigator.pop();
      await showErrorDialog(
        context: context,
        title: 'Gagal Prepare',
        message: e.toString(),
      );
    }
  }

  Future<void> _complete(
    BuildContext context,
    WidgetRef ref,
    EncounterRecord record,
  ) async {
    final navigator = Navigator.of(context);
    final providerId = record.id.toString();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final currentState = await ref.read(
        EncounterNotifierProvider(providerId).future,
      );
      if (!context.mounted) return;
      if (currentState == null) {
        throw Exception("Cannot complete, current record state is null.");
      }

      final formState = ref.read(formDataProvider);
      final mergedJson = buildPatchedJsonFromModel(
        currentState,
        formState,
        currentState.uid,
        listSections: [],
      );

      var recordToSend = EncounterRecord.fromJson(mergedJson);
      recordToSend = recordToSend.copyWith(docAction: 'CO', processed: null);

      await ref
          .read(EncounterNotifierProvider(providerId).notifier)
          .updateRecord(recordToSend);

      if (!context.mounted) return;
      navigator.pop();

      ref.invalidate(EncounterNotifierProvider(providerId));

      await showSuccessDialog(
        context: context,
        title: 'Sukses',
        message: 'Data encounter berhasil di-complete.',
      );

      ref.read(formModificationNotifierProvider.notifier).reset();
    } catch (e) {
      if (!context.mounted) return;
      navigator.pop();
      await showErrorDialog(
        context: context,
        title: 'Gagal Complete',
        message: e.toString(),
      );
    }
  }
}

class _Content extends StatelessWidget {
  final EncounterRecord record;
  final int refreshCounter;

  const _Content({required this.record, required this.refreshCounter});

  @override
  Widget build(BuildContext context) {
    final docStatusId = record.docStatus?.id;

    final bool isEditable = docStatusId != 'CO' && docStatusId != 'VO';
    final bool isPatientInfoEditable =
        docStatusId == 'DR' || docStatusId == 'IP' || docStatusId == 'IN';

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          AppFormSection(
            key: ValueKey('info_${record.uid}_$refreshCounter'),
            title: 'Information',
            originalData: record.toJson(),
            isEditable: isEditable,
            sectionType: 'encounter_main',
            sectionIndex: 0,
            recordId: record.uid,
          ),
          const SizedBox(height: 16),
          AppFormSection(
            key: ValueKey('medical_info_${record.uid}_$refreshCounter'),
            title: 'Patient Medical Information',
            originalData: record.toJson(),
            isEditable: isPatientInfoEditable,
            sectionType: 'encounter_medical',
            sectionIndex: 1,
            recordId: record.uid,
          ),
        ],
      ),
    );
  }
}
