import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/presentation/pages/dashboard_page.dart';
import 'package:medibuk/presentation/pages/encounter_page.dart';
import 'package:medibuk/presentation/providers/dashboard_provider.dart';
import 'package:medibuk/presentation/utils/date_formatted.dart';
import 'package:medibuk/presentation/widgets/core/app_table.dart';
import 'package:medibuk/presentation/widgets/dashboard/dashboard_header.dart';
import 'package:medibuk/presentation/widgets/dashboard/doctor_schedule_card.dart';
import 'package:medibuk/presentation/widgets/shared/dialogs.dart';

class DashboardAdmin extends ConsumerStatefulWidget {
  const DashboardAdmin({super.key});

  @override
  ConsumerState<DashboardAdmin> createState() => DashboardStateAdmin();
}

class DashboardStateAdmin extends ConsumerState<DashboardAdmin> {
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardProvider);
    final encounterWindowState = dashboardState.encounters;

    return encounterWindowState.when(
      data: (window) {
        final statsCardRow = Row(
          children: [
            StatCard(
              icon: Icons.calendar_today_outlined,
              title: 'Total Registrations',
              count: window.rowCount?.toString() ?? '0',
            ),
            StatCard(
              icon: Icons.calendar_today_outlined,
              title: 'Online Booking',
              count: dashboardState.onlineBookings.toString(),
            ),
          ],
        );

        if (window.windowRecords?.isEmpty ?? true) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [statsCardRow, const EmptyDashboard()]),
          );
        }

        const double rowHeight = 48.0;
        const double headerHeight = 56.0;
        const double toolbarHeight = 50.0;
        final int recordCount = window.windowRecords!.length;

        final double calculatedHeight =
            (recordCount * rowHeight) + headerHeight + toolbarHeight;

        final double tableHeight = calculatedHeight > 600
            ? 600
            : calculatedHeight;

        final List<TableColumn> encounterColumns = [
          TableColumn(
            label: 'Status',
            size: ColumnSize.S,
            cellBuilder: (item) {
              final status = item.docStatus?.identifier;

              if (status == 'Completed') {
                return Center(
                  child: const Icon(Icons.check, color: Colors.green),
                );
              } else if (status == 'Drafted' || status == 'In Progress') {
                return Center(
                  child: Icon(
                    Icons.sentiment_neutral_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              } else {
                return Center(
                  child: Icon(
                    Icons.do_not_disturb_alt_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              }
            },
          ),
          const TableColumn(
            label: 'Document Status',
            key: 'DocStatus',
            size: ColumnSize.M,
          ),
          const TableColumn(
            label: 'Document Type',
            key: 'C_DocType_ID',
            size: ColumnSize.M,
          ),
          const TableColumn(
            label: 'Name',
            key: 'C_BPartner_ID',
            size: ColumnSize.L,
          ),
          const TableColumn(
            label: 'Antrian',
            key: 'Antrian',
            size: ColumnSize.S,
          ),
          const TableColumn(
            label: 'Dokter',
            key: 'Doctor_ID',
            size: ColumnSize.L,
          ),
          const TableColumn(label: 'Tanggal', key: 'DateTrx'),
          const TableColumn(
            label: 'Poli',
            key: 'M_Specialist_ID',
            size: ColumnSize.L,
          ),
        ];

        final sortedData = List.of(window.windowRecords!);
        if (_sortColumnIndex != null) {
          final column = encounterColumns[_sortColumnIndex!];
          sortedData.sort((a, b) {
            final aMap = a.toJson();
            final bMap = b.toJson();

            // Pastikan key tidak null sebelum sorting
            if (column.key == null) return 0;

            dynamic aValue = aMap[column.key];
            dynamic bValue = bMap[column.key];

            // Ambil 'identifier' jika tipenya GeneralInfo
            if (aValue is GeneralInfo) aValue = aValue.identifier;
            if (bValue is GeneralInfo) bValue = bValue.identifier;

            // Handle nilai null
            if (aValue == null && bValue == null) return 0;
            if (aValue == null) return _sortAscending ? -1 : 1;
            if (bValue == null) return _sortAscending ? 1 : -1;

            final comparison = aValue.compareTo(bValue);
            return _sortAscending ? comparison : -comparison;
          });
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  StatCard(
                    icon: Icons.calendar_today_outlined,
                    title: 'Total Registrations',
                    count: window.rowCount.toString(),
                  ),
                  StatCard(
                    icon: Icons.calendar_today_outlined,
                    title: 'Online Booking',
                    count: dashboardState.onlineBookings.toString(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (dashboardState.selectedBPartnerId != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Chip(
                    label: Text(
                      'Filter: ${dashboardState.selectedBPartnerName ?? ''}',
                    ),
                    onDeleted: () {
                      ref
                          .read(dashboardProvider.notifier)
                          .clearBPartnerFilter();
                    },
                    deleteIcon: const Icon(Icons.close, size: 18),
                  ),
                ),
              _buildDoctorCards(context, dashboardState),
              const SizedBox(height: 16),
              SizedBox(
                height: tableHeight,
                child: AppTable(
                  title: "Today's Encounters",
                  columns: encounterColumns,
                  initialData: sortedData,
                  showAddButton: false,
                  showActionColumn: true,
                  enableMultiSelect: false,
                  onDelete: (item) async {
                    if (item is! EncounterRecord) return;

                    final bool? confirmed = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Konfirmasi Hapus'),
                          content: Text(
                            'Anda yakin ingin menghapus pertemuan dengan pasien "${item.cBPartnerId?.identifier ?? 'N/A'}"?',
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Batal'),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              child: const Text('Hapus'),
                              onPressed: () => Navigator.of(context).pop(true),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmed == true) {
                      try {
                        await ref
                            .read(dashboardProvider.notifier)
                            .deleteEncounter(item.id);

                        // Gunakan showSuccessDialog
                        if (mounted) {
                          await showSuccessDialog(
                            context: context,
                            title: 'Berhasil',
                            message: 'Pertemuan berhasil dihapus.',
                          );
                        }
                      } catch (e) {
                        // Gunakan showErrorDialog
                        if (mounted) {
                          await showErrorDialog(
                            context: context,
                            title: 'Gagal',
                            // Ambil pesan error yang lebih bersih
                            message: e.toString().replaceFirst(
                              'Exception: ',
                              '',
                            ),
                          );
                        }
                      }
                    }
                  },
                  onLate: (item) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Delete action for: ${item.cBPartnerId?.identifier}',
                        ),
                      ),
                    );
                  },
                  onRowTap: (item) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            EncounterScreen(encounterId: item.id.toString()),
                      ),
                    );
                  },
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _sortAscending = ascending;
                    });
                  },
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
      error: (err, stack) => Center(child: Text("Gagal memuat data: $err")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildDoctorCards(
    BuildContext context,
    DashboardState dashboardState,
  ) {
    final groupedData = dashboardState.groupedEncounters;
    if (groupedData.isEmpty) {
      return const SizedBox.shrink();
    }
    final today = DateTime.now();
    return SizedBox(
      height: 470,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: groupedData.keys.map((date) {
          final isToday = date.day == today.day && date.month == today.month;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${formatDate(date)}${isToday ? ' (Hari Ini)' : ''}',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: groupedData[date]!.keys.map((doctorName) {
                  final schedules = groupedData[date]![doctorName]!;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: DashboardDoctorCard(
                      doctorName: doctorName,
                      schedules: schedules,
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
