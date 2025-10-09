import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/repositories/medical_record_repository.dart';
import 'package:medibuk/domain/entities/medical_record.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';
import 'package:medibuk/presentation/providers/medical_record_providers.dart';
import 'package:medibuk/presentation/providers/form_data_provider.dart';
import 'package:medibuk/presentation/providers/ui_providers.dart';
import 'package:medibuk/presentation/utils/json_patcher.dart';
import 'package:medibuk/presentation/utils/roles.dart';
import 'package:medibuk/presentation/widgets/core/action_buttons.dart';
import 'package:medibuk/presentation/widgets/core/app_buttons.dart';
import 'package:medibuk/presentation/widgets/core/app_form_section.dart';
import 'package:medibuk/presentation/widgets/core/app_layout.dart';
import 'package:medibuk/presentation/widgets/core/app_tab.dart';
import 'package:medibuk/presentation/widgets/core/app_table.dart';
import 'package:medibuk/presentation/widgets/shared/dialogs.dart';
import 'package:medibuk/presentation/widgets/shared/prescription_form_dialog.dart';
import 'package:medibuk/presentation/widgets/shared/prescription_service_dialog.dart';

class MedicalRecordScreen extends ConsumerStatefulWidget {
  final String medicalRecordId;

  const MedicalRecordScreen({super.key, required this.medicalRecordId});

  @override
  ConsumerState<MedicalRecordScreen> createState() =>
      _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends ConsumerState<MedicalRecordScreen> {
  int _refreshCounter = 0;

  @override
  Widget build(BuildContext context) {
    final medicalRecordAsync = ref.watch(
      MedicalRecordNotifierProvider(widget.medicalRecordId),
    );
    final userRole = ref.watch(currentUserRoleProvider);

    return medicalRecordAsync.when(
      data: (record) {
        if (record == null) {
          return const Scaffold(
            body: Center(child: Text('Medical Record not found')),
          );
        }
        return AppLayout(
          pageTitle: 'Medical Record - ${record.documentNo}',
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

            ref.invalidate(
              MedicalRecordNotifierProvider(widget.medicalRecordId),
            );
            ref.read(formDataProvider.notifier).clear();
            ref.read(formModificationNotifierProvider.notifier).reset();

            if (!context.mounted) return;
            navigator.pop();
            await showSuccessDialog(
              context: context,
              title: 'Sukses',
              message: 'Data rekam medis berhasil diperbarui.',
            );
          },
          pageActions: [
            if (record.docStatus.id != 'VO' && record.docStatus.id != 'CO')
              ActionDefinition(
                type: ActionButtonType.save,
                onPressed: () => _save(context, ref, record),
              ),
            if (record.docStatus.id == 'DR')
              ActionDefinition(
                type: ActionButtonType.completed,
                onPressed: () => _save(context, ref, record),
              ),
          ],
          slivers: [
            SliverToBoxAdapter(
              child: _Content(
                record: record,
                refreshCounter: _refreshCounter,
                medicalRecordId: widget.medicalRecordId,
                userRole: userRole,
              ),
            ),
          ],
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Gagal memuat rekam medis: $error')),
      ),
    );
  }

  Future<void> _save(
    BuildContext context,
    WidgetRef ref,
    MedicalRecord record,
  ) async {
    final navigator = Navigator.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final List<String> sectionsToSave = [];
      if (record.obstetric != null && record.obstetric!.isNotEmpty) {
        sectionsToSave.add('medrec_obstetric');
      }
      if (record.gynecology != null && record.gynecology!.isNotEmpty) {
        sectionsToSave.add('medrec_gynecology');
      }
      if (record.anak != null && record.anak!.isNotEmpty) {
        sectionsToSave.add('medrec_anak'); // Gunakan nama JSON key
      }
      if (record.laktasi != null && record.laktasi!.isNotEmpty) {
        sectionsToSave.add('medrec_laktasi');
      }
      if (record.umum != null && record.umum!.isNotEmpty) {
        sectionsToSave.add('medrec_umum'); // Gunakan nama JSON key
      }
      if (record.andrologi != null && record.andrologi!.isNotEmpty) {
        sectionsToSave.add('medrec_andrologi');
      }

      final formState = ref.read(formDataProvider);
      final mergedJson = buildPatchedJsonFromModel(
        record,
        formState,
        record.uid,
        listSections: sectionsToSave,
      );

      final recordToSend = MedicalRecord.fromJson(mergedJson);

      await ref
          .read(MedicalRecordNotifierProvider(widget.medicalRecordId).notifier)
          .updateRecord(recordToSend);

      if (!context.mounted) return;
      navigator.pop();
      await showSuccessDialog(
        context: context,
        title: 'Sukses',
        message: 'Data rekam medis berhasil disimpan.',
      );
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
}

class _Content extends ConsumerWidget {
  final MedicalRecord record;
  final String medicalRecordId;
  final int refreshCounter;
  final Role userRole;

  const _Content({
    required this.record,
    required this.medicalRecordId,
    required this.refreshCounter,
    required this.userRole,
  });

  Future<void> _addObstetric(WidgetRef ref) async {
    final list = List<ObstetricRecord>.from(record.obstetric ?? const []);

    Map<String, dynamic> json;
    if (list.isNotEmpty) {
      json = (jsonDecode(jsonEncode(list.last)) as Map).cast<String, dynamic>();
    } else {
      json = <String, dynamic>{};
    }
    json['id'] = 0;
    json['uid'] = 'tmp-${DateTime.now().millisecondsSinceEpoch}';

    final cloned = ObstetricRecord.fromJson(json);
    list.add(cloned);

    final updated = record.copyWith(obstetric: list);

    ref
        .read(MedicalRecordNotifierProvider(medicalRecordId).notifier)
        .updateStateLocally(updated);

    ref.read(formModificationNotifierProvider.notifier).setModified(true);
  }

  Future<void> _deleteObstetric(
    BuildContext context,
    WidgetRef ref,
    int index,
  ) async {
    final list = List<ObstetricRecord>.from(record.obstetric ?? const []);
    if (index < 0 || index >= list.length) return;

    final recordToDelete = list[index];
    final idToDelete = recordToDelete.id;

    final persistedRecordCount = list.where((item) => item.id != 0).length;

    if (idToDelete != 0 && persistedRecordCount <= 1) {
      await showErrorDialog(
        context: context,
        title: 'Aksi Ditolak',
        message:
            'Anda tidak dapat menghapus data obstetric terakhir yang sudah tersimpan. Harap sisakan minimal satu data.',
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus data obstetric ini?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    if (idToDelete == 0) {
      list.removeAt(index);
      final updated = record.copyWith(obstetric: list);
      ref
          .read(MedicalRecordNotifierProvider(medicalRecordId).notifier)
          .updateStateLocally(updated);
      ref.read(formModificationNotifierProvider.notifier).setModified(true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item baru berhasil dihapus.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await ref
          .read(medicalRecordRepositoryProvider)
          .deleteObstetricRecord(idToDelete);

      if (context.mounted) Navigator.of(context).pop();

      ref.invalidate(MedicalRecordNotifierProvider(medicalRecordId));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data Obstetric berhasil dihapus dari server.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        await showErrorDialog(
          context: context,
          title: 'Gagal Menghapus',
          message: e.toString(),
        );
      }
    }
  }

  void _showAddPrescriptionDialog(BuildContext context, WidgetRef ref) {
    showDialog<List<PrescriptionRecord>>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) =>
          PrescriptionServiceDialog(initialItems: record.prescriptions ?? []),
    ).then((result) {
      if (result != null) {
        final updatedRecord = record.copyWith(prescriptions: result);
        ref
            .read(MedicalRecordNotifierProvider(medicalRecordId).notifier)
            .updateRecord(updatedRecord);
      }
    });
  }

  void _showEditPrescriptionDialog(
    BuildContext context,
    WidgetRef ref,
    PrescriptionRecord itemToEdit,
  ) {
    showDialog<PrescriptionRecord>(
      context: context,
      builder: (ctx) => PrescriptionFormDialog(initialData: itemToEdit),
    ).then((result) {
      if (result != null) {
        final currentList = List<PrescriptionRecord>.from(
          record.prescriptions ?? [],
        );
        final index = currentList.indexWhere(
          (item) => item.id == result.id || item.uid == result.uid,
        );

        if (index != -1) {
          currentList[index] = result;
        } else {
          currentList.add(result);
        }

        final updatedRecord = record.copyWith(prescriptions: currentList);
        ref
            .read(MedicalRecordNotifierProvider(medicalRecordId).notifier)
            .updateRecord(updatedRecord);
      }
    });
  }

  Widget buildPrescriptionTabContent(BuildContext context, WidgetRef ref) {
    return AppTable(
      title: '',
      initialData: record.prescriptions ?? [],
      columns: const [
        TableColumn(label: 'Product', key: 'M_Product_ID', size: ColumnSize.L),
        TableColumn(
          label: 'Qty',
          key: 'Qty',
          isNumeric: true,
          size: ColumnSize.S,
        ),
        TableColumn(
          label: 'Description',
          key: 'Description',
          size: ColumnSize.M,
        ),
      ],
      onAdd: () => _showAddPrescriptionDialog(context, ref),
      onEdit: (item) =>
          _showEditPrescriptionDialog(context, ref, item as PrescriptionRecord),
    );
  }

  Widget buildServiceTabContent(BuildContext context, WidgetRef ref) {
    return AppTable(
      title: '',
      initialData: record.services ?? [],
      columns: const [
        TableColumn(label: 'Service Name', key: 'uid', size: ColumnSize.L),
        TableColumn(label: 'Notes', key: 'Note', size: ColumnSize.M),
      ],
      onAdd: () => _showAddPrescriptionDialog(context, ref),
      onEdit: (item) =>
          _showEditPrescriptionDialog(context, ref, item as PrescriptionRecord),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docStatusId = record.docStatus.id;
    final isEditable =
        (docStatusId != 'CO' && docStatusId != 'VO') &&
        (userRole == Role.bidan || userRole == Role.key);
    final originalJson = record.toJson();

    final List<TabData> clinicalFindingTabs = [
      TabData(
        title: 'Prescriptions',
        icon: Icons.medication,
        content: Consumer(
          builder: (context, ref, _) =>
              buildPrescriptionTabContent(context, ref),
        ),
      ),
      TabData(
        title: 'Services',
        icon: Icons.miscellaneous_services,
        content: Consumer(
          builder: (context, ref, _) => buildServiceTabContent(context, ref),
        ),
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          AppFormSection(
            key: ValueKey('main_${record.uid}_$refreshCounter'),
            title: 'Information',
            originalData: originalJson,
            isEditable: isEditable,
            sectionType: 'medicalrecord_main',
            sectionIndex: 0,
            recordId: record.uid,
          ),
          const SizedBox(height: 8),

          // Section Gynecology
          if (record.gynecology != null && record.gynecology!.isNotEmpty)
            ...record.gynecology!.asMap().entries.map((entry) {
              int index = entry.key;
              var gynecologyRecord = entry.value;

              final sectionData = Map<String, dynamic>.from(originalJson)
                ..addAll(gynecologyRecord.toJson());

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: AppFormSection(
                  key: ValueKey(
                    'gynecology_${gynecologyRecord.uid}_$refreshCounter',
                  ),
                  title: 'Gynecology',
                  originalData: sectionData,
                  isEditable: isEditable,
                  sectionType: 'medrec_gynecology',
                  sectionIndex: index,
                  recordId: record.uid,
                  initiallyExpanded: false,
                ),
              );
            }),

          // Section Obstetric
          if (record.obstetric != null && record.obstetric!.isNotEmpty)
            ...record.obstetric!.asMap().entries.map((entry) {
              int index = entry.key;
              var obstetricRecord = entry.value;

              final sectionData = Map<String, dynamic>.from(originalJson)
                ..addAll(obstetricRecord.toJson());

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: AppFormSection(
                  key: ValueKey(
                    'obstetric_${obstetricRecord.uid}_$refreshCounter',
                  ),
                  title: 'Obstetric #${index + 1}',
                  originalData: sectionData,
                  isEditable: isEditable,
                  sectionType: 'medrec_obstetric',
                  sectionIndex: index,
                  recordId: record.uid,
                  initiallyExpanded: false,
                  onDelete: isEditable && (record.obstetric?.length ?? 0) > 1
                      ? () => _deleteObstetric(context, ref, index)
                      : null,
                ),
              );
            }),

          // Section Anak
          if (record.anak != null && record.anak!.isNotEmpty)
            ...record.anak!.asMap().entries.map((entry) {
              int index = entry.key;
              var anakRecord = entry.value;

              final sectionData = Map<String, dynamic>.from(originalJson)
                ..addAll(anakRecord.toJson());

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: AppFormSection(
                  key: ValueKey('anak_${anakRecord.uid}_$refreshCounter'),
                  title: 'Anak',
                  originalData: sectionData,
                  isEditable: isEditable,
                  sectionType: 'medrec_anak',
                  sectionIndex: index,
                  recordId: record.uid,
                ),
              );
            }),

          // Section Laktasi
          if (record.laktasi != null && record.laktasi!.isNotEmpty)
            ...record.laktasi!.asMap().entries.map((entry) {
              int index = entry.key;
              var laktasiRecord = entry.value;

              final sectionData = Map<String, dynamic>.from(originalJson)
                ..addAll(laktasiRecord.toJson());

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: AppFormSection(
                  key: ValueKey('laktasi_${laktasiRecord.uid}_$refreshCounter'),
                  title: 'Laktasi',
                  originalData: sectionData,
                  isEditable: isEditable,
                  sectionType: 'medrec_laktasi',
                  sectionIndex: index,
                  recordId: record.uid,
                ),
              );
            }),

          // Section Andrologi
          if (record.andrologi != null && record.andrologi!.isNotEmpty)
            ...record.andrologi!.asMap().entries.map((entry) {
              int index = entry.key;
              var andrologiRecord = entry.value;

              final sectionData = Map<String, dynamic>.from(originalJson)
                ..addAll(andrologiRecord.toJson());

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: AppFormSection(
                  key: ValueKey(
                    'andrologi_${andrologiRecord.uid}_$refreshCounter',
                  ),
                  title: 'Andrologi',
                  originalData: sectionData,
                  isEditable: isEditable,
                  sectionType: 'medrec_andrologi',
                  sectionIndex: index,
                  recordId: record.uid,
                ),
              );
            }),

          // Section Umum
          if (record.umum != null && record.umum!.isNotEmpty)
            ...record.umum!.asMap().entries.map((entry) {
              int index = entry.key;
              var umumRecord = entry.value;

              final sectionData = Map<String, dynamic>.from(originalJson)
                ..addAll(umumRecord.toJson());

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: AppFormSection(
                  key: ValueKey('umum_${umumRecord.uid}_$refreshCounter'),
                  title: 'Umum',
                  originalData: sectionData,
                  isEditable: isEditable,
                  sectionType: 'medrec_umum',
                  sectionIndex: index,
                  recordId: record.uid,
                ),
              );
            }),

          if (isEditable)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppButton(
                  text: 'Add Obstetric',
                  icon: Icons.add_circle_outline,
                  onPressed: () => _addObstetric(ref),
                  width: 150,
                ),
              ),
            ),

          AppTab(
            title: 'Medical Records',
            subtitle: 'Manage Prescriptions, Services & diagnostics',
            headerIcon: Icons.medical_services_outlined,
            tabs: clinicalFindingTabs,
          ),
        ],
      ),
    );
  }
}
