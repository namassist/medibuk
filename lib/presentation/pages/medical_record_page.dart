import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/domain/entities/medical_record.dart';
import 'package:medibuk/presentation/providers/medical_record_providers.dart';
import 'package:medibuk/presentation/providers/form_data_provider.dart';
import 'package:medibuk/presentation/providers/table_data_provider.dart';
import 'package:medibuk/presentation/widgets/dialogs/prescription_form_dialog.dart';
import 'package:medibuk/presentation/widgets/dialogs/prescription_service_dialog.dart';
import 'package:medibuk/presentation/widgets/fields/form_section.dart';
import 'package:medibuk/presentation/widgets/layouts/app_toolbar.dart';
import 'package:medibuk/presentation/widgets/tables/data_table.dart';
import 'package:medibuk/presentation/widgets/tabs/tab_view.dart';

class MedicalRecordScreen extends ConsumerWidget {
  final String medicalRecordId;

  const MedicalRecordScreen({super.key, required this.medicalRecordId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicalRecordAsync = ref.watch(
      MedicalRecordNotifierProvider(medicalRecordId),
    );

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: medicalRecordAsync.when(
        data: (record) => record != null
            ? _Content(record: record, medicalRecordId: medicalRecordId)
            : const _EmptyState(),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorState(
          error: error.toString(),
          onRetry: () =>
              ref.refresh(MedicalRecordNotifierProvider(medicalRecordId)),
        ),
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  final MedicalRecord record;
  final String medicalRecordId;

  const _Content({required this.record, required this.medicalRecordId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditable = record.docStatus.id != 'CO';

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _PinnedHeaderDelegate(
            minExtentHeight: 210,
            maxExtentHeight: 210,
            child: AppToolbar(record: record, medicalRecordId: medicalRecordId),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Consumer(
                builder: (context, ref, _) {
                  final mainData = ref.watch(processedMainDataProvider(record));
                  return FormSection(
                    key: const ValueKey('main_information'),
                    title: 'Information',
                    data: mainData,
                    isEditable: isEditable,
                    sectionType: 'main',
                    sectionIndex: 0,
                    medicalRecordId: medicalRecordId,
                    collapsible: true,
                    initiallyExpanded: true,
                  );
                },
              ),
            ]),
          ),
        ),

        if (record.gynecology?.isNotEmpty ?? false)
          _buildVirtualizedSections(
            'gynecology',
            record.gynecology!,
            isEditable,
            ref,
          ),

        if (record.obstetric?.isNotEmpty ?? false) ...[
          _buildVirtualizedSections(
            'obstetric',
            record.obstetric!,
            isEditable,
            ref,
          ),

          if (isEditable)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () => _addObstetric(ref),
                    icon: const Icon(Icons.copy_all),
                    label: const Text('Add Obstetric'),
                  ),
                ),
              ),
            ),
        ] else if (isEditable) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: () => _addObstetric(ref),
                  icon: const Icon(Icons.copy_all),
                  label: const Text('Add Obstetric'),
                ),
              ),
            ),
          ),
        ],

        SliverToBoxAdapter(
          child: Builder(
            builder: (context) {
              final List<TabData> clinicalFindingTabs = [
                TabData(
                  title: 'Prescriptions',
                  icon: Icons.medication,
                  content: buildPrescriptionTabContent(record, context, ref),
                ),
                TabData(
                  title: 'Services',
                  icon: Icons.miscellaneous_services,
                  content: buildServiceTabContent(record, context, ref),
                ),
              ];

              return TabView(
                title: 'Clinical Findings',
                subtitle: 'Prescriptions & Services Provided',
                headerIcon: Icons.medical_services_outlined,
                tabs: clinicalFindingTabs,
                record: record,
              );
            },
          ),
        ),

        const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
      ],
    );
  }

  Widget _buildVirtualizedSections<T>(
    String sectionType,
    List<T> items,
    bool isEditable,
    WidgetRef ref,
  ) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = items[index];
        Map<String, dynamic> data;

        if (item is ObstetricRecord) {
          data = item.toJson();
        } else if (item is GynecologyRecord) {
          data = item.toJson();
        } else if (item is PrescriptionRecord) {
          data = item.toJson();
        } else {
          data = {};
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FormSection(
            key: ValueKey('${sectionType}_$index'),
            title:
                '${sectionType == 'obstetric' ? 'Obstetric' : 'Gynecology'} ${index + 1}',
            data: data,
            isEditable: isEditable,
            sectionType: sectionType,
            sectionIndex: index,
            medicalRecordId: medicalRecordId,
            collapsible: true,
            initiallyExpanded: sectionType == 'information',
            onDelete:
                sectionType == 'obstetric' && isEditable && items.length > 1
                ? () => _deleteObstetric(ref, index)
                : null,
          ),
        );
      }, childCount: items.length),
    );
  }

  Future<void> _addObstetric(WidgetRef ref) async {
    final list = List<ObstetricRecord>.from(record.obstetric ?? const []);
    Map<String, dynamic> json;
    if (list.isNotEmpty) {
      // Deep clone using JSON roundtrip to ensure nested GeneralInfo become maps
      json = (jsonDecode(jsonEncode(list.last)) as Map).cast<String, dynamic>();
    } else {
      json = <String, dynamic>{};
    }
    // Set new identity
    json['id'] = 0;
    json['uid'] = 'tmp-${DateTime.now().millisecondsSinceEpoch}';
    final cloned = ObstetricRecord.fromJson(json);
    list.add(cloned);
    final updated = record.copyWith(obstetric: list);
    await ref
        .read(MedicalRecordNotifierProvider(medicalRecordId).notifier)
        .updateRecord(updated);
    // Clear and mark modified so new section initializes and changes are tracked fresh
    ref.read(formDataProvider.notifier).clear();
    ref.read(formModificationNotifierProvider.notifier).setModified(true);
  }

  Future<void> _deleteObstetric(WidgetRef ref, int index) async {
    final list = List<ObstetricRecord>.from(record.obstetric ?? const []);
    if (index < 0 || index >= list.length) return;
    list.removeAt(index);
    final updated = record.copyWith(obstetric: list);
    await ref
        .read(MedicalRecordNotifierProvider(medicalRecordId).notifier)
        .updateRecord(updated);
    // Reset change tracking so indices realign
    ref.read(formDataProvider.notifier).clear();
    ref.read(formModificationNotifierProvider.notifier).setModified(true);
  }

  Widget buildPrescriptionTabContent(
    MedicalRecord record,
    BuildContext context,
    WidgetRef ref,
  ) {
    void showAddItemDialog(List<PrescriptionRecord> items) {
      showDialog<List<PrescriptionRecord>>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => PrescriptionServiceDialog(initialItems: items),
      ).then((result) {
        if (result != null) {
          final notifier = ref.read(
            tableDataProvider(record.prescriptions ?? []).notifier,
          );
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          notifier.state = notifier.state.copyWith(data: result);
        }
      });
    }

    void showEditItemDialog(PrescriptionRecord prescription) {
      showDialog<PrescriptionRecord>(
        context: context,
        builder: (ctx) => PrescriptionFormDialog(initialData: prescription),
      ).then((result) {
        if (result != null) {
          ref
              .read(tableDataProvider(record.prescriptions ?? []).notifier)
              .addOrUpdateItem(result);
        }
      });
    }

    return Tablegrid(
      title: 'Prescriptions',
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
      onAdd: () => showAddItemDialog(record.prescriptions ?? []),
      onEdit: (item) => showEditItemDialog(item as PrescriptionRecord),
    );
  }

  Widget buildServiceTabContent(
    MedicalRecord record,
    BuildContext context,
    WidgetRef ref,
  ) {
    return Tablegrid(
      title: 'Services',
      initialData: record.services ?? [],
      columns: const [
        TableColumn(label: 'Service Name', key: 'uid', size: ColumnSize.L),
        TableColumn(label: 'Notes', key: 'Note', size: ColumnSize.M),
      ],
      onAdd: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Add Service dialog not implemented yet.'),
          ),
        );
      },
      onEdit: (item) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Edit Service dialog not implemented yet.'),
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.description, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No medical record found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorState({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 64, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(
            'Error loading medical record',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.red[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
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
    return oldDelegate.minExtentHeight != minExtentHeight ||
        oldDelegate.maxExtentHeight != maxExtentHeight ||
        oldDelegate.child != child;
  }
}

extension StringCapitalization on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
