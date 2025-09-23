// lib/presentation/widgets/tab_view.dart

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/domain/entities/medical_record.dart';
import 'package:medibuk/presentation/providers/table_data_provider.dart';
import 'package:medibuk/presentation/widgets/dialogs/prescription_form_dialog.dart';
import 'package:medibuk/presentation/widgets/dialogs/prescription_service_dialog.dart';
import 'package:medibuk/presentation/widgets/tables/data_table.dart';

class TabData {
  final String title;
  final IconData icon;
  final Widget content;

  TabData({required this.title, required this.icon, required this.content});
}

class TabView extends ConsumerWidget {
  final String title;
  final String subtitle;
  final IconData headerIcon;
  final List<TabData> tabs;

  const TabView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.headerIcon,
    required this.tabs,
    required MedicalRecord record,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Gunakan panjang dari list untuk DefaultTabController
    return DefaultTabController(
      length: tabs.length,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  headerIcon,
                  color: Theme.of(context).primaryColor,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Langkah 3: Buat TabBar secara dinamis
            TabBar(
              isScrollable:
                  tabs.length > 3, // Buat bisa di-scroll jika tab banyak
              tabs: tabs
                  .map((tab) => Tab(icon: Icon(tab.icon), text: tab.title))
                  .toList(),
            ),
            // Langkah 3: Buat TabBarView secara dinamis
            SizedBox(
              height: 400, // Beri tinggi tetap untuk area tabel
              child: TabBarView(
                children: tabs.map((tab) => tab.content).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper method untuk membuat konten Prescription (agar kode utama tetap bersih)
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
      TableColumn(label: 'Description', key: 'Description', size: ColumnSize.M),
    ],
    onAdd: () => showAddItemDialog(record.prescriptions ?? []),
    onEdit: (item) => showEditItemDialog(item as PrescriptionRecord),
  );
}

// Helper method untuk membuat konten Service
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
