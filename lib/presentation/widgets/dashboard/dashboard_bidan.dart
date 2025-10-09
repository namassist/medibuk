import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/presentation/pages/encounter_page.dart';
import 'package:medibuk/presentation/providers/dashboard_bidan_provider.dart';

class DashboardBidan extends ConsumerWidget {
  const DashboardBidan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWideScreen = constraints.maxWidth > 1000;
        if (isWideScreen) {
          return _buildWideLayout(context, ref);
        } else {
          return _buildNarrowLayout(context, ref);
        }
      },
    );
  }

  Widget _buildWideLayout(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bidanDashboardProvider);
    final notifier = ref.read(bidanDashboardProvider.notifier);
    final encounterState = state.encounters;

    return encounterState.when(
      data: (allEncounters) {
        final filteredEncounters = allEncounters
            .where((e) => e.doctorId?.id == state.selectedDoctor?.id)
            .toList();

        final inProgressEncounters = filteredEncounters
            .where((e) => e.docStatus?.identifier == 'In Progress')
            .toList();
        final totalQueue = inProgressEncounters.length;
        final firstEncounterInProgress = inProgressEncounters.firstOrNull;

        final allDisplayableEncounters = filteredEncounters
            .where(
              (e) =>
                  e.docStatus?.identifier == 'In Progress' ||
                  e.docStatus?.identifier == 'Completed',
            )
            .toList();

        final firstEncounterToShow = allDisplayableEncounters.firstOrNull;
        final remainingEncountersToShow = allDisplayableEncounters
            .skip(1)
            .toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: SizedBox(
            height: 450,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 245,
                  child: Column(
                    children: [
                      _InfoCard(
                        title: 'Antrian Pasien',
                        value: totalQueue.toString(),
                      ),
                      const SizedBox(height: 16),
                      _InfoCard(
                        title: 'Antrian Berikutnya',
                        value:
                            firstEncounterInProgress?.cBPartnerId?.identifier ??
                            '~Kosong~',
                      ),
                      const SizedBox(height: 16),
                      _InfoCard(
                        title: 'No. Antrian Berikutnya',
                        value: firstEncounterInProgress?.antrian ?? '-',
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: _PatientList(
                    selectedDoctor: state.selectedDoctor,
                    firstEncounter: firstEncounterToShow,
                    remainingEncounters: remainingEncountersToShow,
                  ),
                ),
                const SizedBox(width: 16),

                SizedBox(
                  width: 245,
                  child: _DoctorDropdown(
                    doctorList: state.availableDoctors,
                    selectedDoctor: state.selectedDoctor,
                    isLoading: state.encounters is AsyncLoading,
                    onChanged: (doctor) => notifier.selectDoctor(doctor),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (err, stack) => Center(child: Text("Gagal memuat data: $err")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildNarrowLayout(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bidanDashboardProvider);
    final notifier = ref.read(bidanDashboardProvider.notifier);
    final encounterState = state.encounters;

    return encounterState.when(
      data: (allEncounters) {
        final filteredEncounters = allEncounters
            .where((e) => e.doctorId?.id == state.selectedDoctor?.id)
            .toList();
        final inProgressEncounters = filteredEncounters
            .where((e) => e.docStatus?.identifier == 'In Progress')
            .toList();
        final totalQueue = inProgressEncounters.length;
        final firstEncounterInProgress = inProgressEncounters.firstOrNull;
        final allDisplayableEncounters = filteredEncounters
            .where(
              (e) =>
                  e.docStatus?.identifier == 'In Progress' ||
                  e.docStatus?.identifier == 'Completed',
            )
            .toList();
        final firstEncounterToShow = allDisplayableEncounters.firstOrNull;
        final remainingEncountersToShow = allDisplayableEncounters
            .skip(1)
            .toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            children: [
              _DoctorDropdown(
                doctorList: state.availableDoctors,
                selectedDoctor: state.selectedDoctor,
                isLoading: state.encounters is AsyncLoading,
                onChanged: (doctor) => notifier.selectDoctor(doctor),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _InfoCard(
                      title: 'Antrian Pasien',
                      value: totalQueue.toString(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _InfoCard(
                      title: 'Antrian Berikutnya',
                      value: firstEncounterInProgress?.antrian ?? '-',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 400,
                child: _PatientList(
                  selectedDoctor: state.selectedDoctor,
                  firstEncounter: firstEncounterToShow,
                  remainingEncounters: remainingEncountersToShow,
                ),
              ),
            ],
          ),
        );
      },
      error: (err, stack) => Center(child: Text("Gagal memuat data: $err")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _DoctorDropdown extends StatelessWidget {
  final List<GeneralInfo> doctorList;
  final GeneralInfo? selectedDoctor;
  final bool isLoading;
  final ValueChanged<GeneralInfo?> onChanged;

  const _DoctorDropdown({
    required this.doctorList,
    this.selectedDoctor,
    required this.isLoading,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<GeneralInfo>(
      items: doctorList,
      selectedItem: selectedDoctor,
      itemAsString: (GeneralInfo d) => d.identifier,
      onChanged: onChanged,
      popupProps: const PopupProps.menu(showSearchBox: true),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: 'Pilih Dokter',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
      ),
      enabled: !isLoading,
    );
  }
}

class _PatientList extends StatelessWidget {
  final GeneralInfo? selectedDoctor;
  final EncounterRecord? firstEncounter;
  final List<EncounterRecord> remainingEncounters;

  const _PatientList({
    this.selectedDoctor,
    this.firstEncounter,
    required this.remainingEncounters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(3)),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            selectedDoctor?.identifier ?? "Pilih Dokter",
            style: TextStyle(
              fontSize: 21,
              color: Theme.of(context).colorScheme.onSurface,
              height: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (selectedDoctor == null)
            const Expanded(child: Center(child: Text("Silakan pilih Dokter.")))
          else if (firstEncounter != null) ...[
            _MainPatientCard(encounter: firstEncounter!),
            const SizedBox(height: 4),
            Expanded(
              child: ListView.separated(
                itemCount: remainingEncounters.length,
                itemBuilder: (context, index) {
                  return _QueueItem(encounter: remainingEncounters[index]);
                },
                separatorBuilder: (context, index) => const SizedBox(height: 4),
              ),
            ),
          ] else
            const Expanded(child: Center(child: Text("Tidak ada antrian."))),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  const _InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(3)),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface,
              height: 1,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 36,
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _MainPatientCard extends StatelessWidget {
  final EncounterRecord encounter;
  const _MainPatientCard({required this.encounter});

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = encounter.docStatus?.identifier == 'Completed';
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                EncounterScreen(encounterId: encounter.id.toString()),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          color: isCompleted
              ? Theme.of(context).disabledColor.withValues(alpha: 0.2)
              : Theme.of(context).colorScheme.onPrimary,
        ),
        child: Row(
          children: [
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: isCompleted ? Theme.of(context).disabledColor : null,
            ),
            const SizedBox(width: 8),
            Text(
              encounter.antrian ?? '-',
              style: TextStyle(
                fontSize: 36,
                color: isCompleted
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).colorScheme.onSurface,
                height: 1,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  encounter.documentNo ?? '-',
                  style: TextStyle(
                    fontSize: 18,
                    color: isCompleted
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).colorScheme.onSurface,
                    height: 1,
                  ),
                ),
                Text(
                  encounter.cBPartnerId!.identifier,
                  style: TextStyle(
                    fontSize: 30,
                    color: isCompleted
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).colorScheme.onSurface,
                    height: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QueueItem extends StatelessWidget {
  final EncounterRecord encounter;
  const _QueueItem({required this.encounter});

  @override
  Widget build(BuildContext context) {
    final isCompleted = encounter.docStatus?.identifier == 'Completed';
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                EncounterScreen(encounterId: encounter.id.toString()),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          color: isCompleted
              ? Theme.of(context).disabledColor.withValues(alpha: 0.2)
              : Theme.of(context).colorScheme.onPrimary,
        ),
        child: Row(
          children: [
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: isCompleted ? Theme.of(context).disabledColor : null,
            ),
            const SizedBox(width: 8),
            Text(
              encounter.antrian ?? "-",
              style: TextStyle(
                fontSize: 25,
                color: isCompleted
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).colorScheme.onSurface,
                height: 1,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  encounter.documentNo ?? '-',
                  style: TextStyle(
                    fontSize: 14,
                    color: isCompleted
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).colorScheme.onSurface,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  encounter.cBPartnerId!.identifier,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isCompleted
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
