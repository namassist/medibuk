import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/repositories/business_partner_repository.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:collection/collection.dart';
import 'package:medibuk/presentation/pages/encounter_page.dart';
import 'package:medibuk/presentation/utils/date_formatted.dart';

class DashboardDoctorCard extends StatefulWidget {
  final String doctorName;
  final Map<GeneralInfo, List<EncounterRecord>> schedules;

  const DashboardDoctorCard({
    super.key,
    required this.doctorName,
    required this.schedules,
  });

  @override
  State<DashboardDoctorCard> createState() => _DashboardDoctorCardState();
}

class _DashboardDoctorCardState extends State<DashboardDoctorCard> {
  bool _isExpanded = false;
  int _selectedScheduleIndex = 0;

  String? get _currentAntrian {
    // Cari antrian pertama dari semua jadwal yang statusnya 'In Progress'
    final inProgressEncounter = widget.schedules.values
        .expand((list) => list) // Gabungkan semua list encounter menjadi satu
        .firstWhereOrNull(
          (e) => e.docStatus?.identifier == 'In Progress' && e.antrian != null,
        );
    return inProgressEncounter?.antrian;
  }

  @override
  Widget build(BuildContext context) {
    final scheduleKeys = widget.schedules.keys.toList();
    final selectedScheduleKey = scheduleKeys.isNotEmpty
        ? scheduleKeys[_selectedScheduleIndex]
        : null;

    if (_isExpanded) {
      // Tampilan Diperluas
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        width: 565,
        height: 420,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => setState(() => _isExpanded = false),
                  child: Row(
                    children: [
                      const Icon(Icons.remove_circle_outline, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        widget.doctorName,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                Text('Antrian ${_currentAntrian ?? "-"}'),
              ],
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Jadwal Encounter"),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 130,
                    child: ListView.separated(
                      itemCount: scheduleKeys.length,
                      itemBuilder: (context, index) {
                        final scheduleKey = scheduleKeys[index];
                        return InkWell(
                          onTap: () =>
                              setState(() => _selectedScheduleIndex = index),
                          child: EncounterSchedulesItem(
                            schedule: scheduleKey,
                            encounters: widget.schedules[scheduleKey]!,
                            isSelected: _selectedScheduleIndex == index,
                          ),
                        );
                      },
                      separatorBuilder: (c, i) => const SizedBox(height: 4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (selectedScheduleKey != null)
                    Expanded(
                      child: ListView.separated(
                        itemCount:
                            widget.schedules[selectedScheduleKey]!.length,
                        itemBuilder: (context, index) {
                          final encounter =
                              widget.schedules[selectedScheduleKey]![index];
                          return EncounterEntry(encounter: encounter);
                        },
                        separatorBuilder: (c, i) => const SizedBox(height: 4),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      // Tampilan Ciut
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        width: 150,
        height: 420,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 90,
              child: InkWell(
                onTap: () => setState(() => _isExpanded = true),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.add_circle, size: 16),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        widget.doctorName,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text('Antrian ${_currentAntrian ?? "-"}'),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: scheduleKeys.length,
                itemBuilder: (context, index) {
                  final scheduleKey = scheduleKeys[index];
                  return InkWell(
                    onTap: () => setState(() {
                      _isExpanded = true;
                      _selectedScheduleIndex = index;
                    }),
                    child: EncounterSchedulesItem(
                      schedule: scheduleKey,
                      encounters: widget.schedules[scheduleKey]!,
                      isSelected: _selectedScheduleIndex == index,
                    ),
                  );
                },
                separatorBuilder: (c, i) => const SizedBox(height: 4),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class EncounterSchedulesItem extends StatelessWidget {
  final GeneralInfo schedule;
  final List<EncounterRecord> encounters;
  final bool isSelected;

  const EncounterSchedulesItem({
    super.key,
    required this.schedule,
    required this.encounters,
    this.isSelected = false,
  });

  String _getHourRange(String identifier) {
    if (identifier == 'Offline') return 'Offline';
    // Ekstrak bagian jam dari 'dr. ..._18:00-19:00'
    final parts = identifier.split('_');
    if (parts.length > 1) {
      final timePart = parts.last;
      // Cek apakah formatnya HH:mm-HH:mm
      if (RegExp(r'^\d{2}:\d{2}-\d{2}:\d{2}$').hasMatch(timePart)) {
        return timePart;
      }
    }
    return identifier; // Kembalikan string asli jika tidak cocok
  }

  @override
  Widget build(BuildContext context) {
    final arrivedCount = encounters
        .where((e) => e.docStatus?.identifier == 'Completed')
        .length;
    final totalCount = encounters.length;

    return Container(
      padding: const EdgeInsets.all(8),
      height: 115,
      decoration: BoxDecoration(
        border: isSelected
            ? Border(
                right: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 6,
                ),
              )
            : null,
        color: Theme.of(context).colorScheme.inverseSurface,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getHourRange(schedule.identifier), // Gunakan fungsi helper
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                ),
                const Spacer(),
                Text(
                  '$arrivedCount/$totalCount',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                ),
                Text(
                  'Tiba/Total',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: isSelected
                ? Theme.of(context).colorScheme.onInverseSurface
                : Theme.of(
                    context,
                  ).colorScheme.onInverseSurface.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }
}

class EncounterEntry extends ConsumerWidget {
  // Ubah di sini
  final EncounterRecord encounter;

  const EncounterEntry({super.key, required this.encounter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tambahkan WidgetRef ref
    final status = encounter.docStatus?.identifier;
    final isCompleted = status == 'Completed';
    final isInProgress = status == 'In Progress';
    final isDrafted = status == 'Drafted';

    final partnerId = encounter.cBPartnerId?.id;
    final partnerState = partnerId != null
        ? ref.watch(businessPartnerProvider(partnerId))
        : null;

    return InkWell(
      onTap: () {
        // Navigasi ke halaman detail encounter
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                EncounterScreen(encounterId: encounter.id.toString()),
          ),
        );
      },
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          color: isCompleted
              ? Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.onPrimary,
        ),
        child: Row(
          children: [
            const Icon(Icons.arrow_forward_ios_outlined, size: 20),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(encounter.documentNo),
                      Row(
                        children: [
                          Text(
                            encounter.antrian ?? '-',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.file_copy_outlined,
                            size: 16,
                            color: isDrafted
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.person_search_outlined,
                            size: 16,
                            color: isInProgress
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.credit_card_outlined,
                            size: 16,
                            color: isCompleted
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          encounter.cBPartnerId?.identifier ?? 'PATIENT',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),

                      if (partnerState != null)
                        partnerState.when(
                          data: (partner) {
                            DateTime? birthdayDate;
                            if (partner.birthday != null &&
                                partner.birthday!.isNotEmpty) {
                              try {
                                birthdayDate = DateTime.parse(
                                  partner.birthday!,
                                );
                              } catch (e) {
                                birthdayDate = null;
                              }
                            }

                            return Row(
                              children: [
                                Text(partner.phone ?? '-'),
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 10,
                                ),
                                Text(formatDate(birthdayDate)),
                              ],
                            );
                          },
                          loading: () => const SizedBox(
                            width: 120,
                            child: Text(
                              '...',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          error: (err, stack) => const Icon(
                            Icons.error_outline,
                            size: 16,
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
