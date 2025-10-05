import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/repositories/encounter_repository.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/domain/entities/paginated.dart';
import 'package:medibuk/presentation/providers/warehouse_provider.dart';

typedef GroupedEncounters =
    Map<DateTime, Map<String, Map<GeneralInfo, List<EncounterRecord>>>>;

class DashboardState {
  final AsyncValue<Paginated<EncounterRecord>> encounters;
  final int onlineBookings;
  final GroupedEncounters groupedEncounters;
  final int? selectedBPartnerId;
  final String? selectedBPartnerName;

  DashboardState({
    required this.encounters,
    this.onlineBookings = 0,
    this.groupedEncounters = const {},
    this.selectedBPartnerId,
    this.selectedBPartnerName,
  });

  DashboardState copyWith({
    AsyncValue<Paginated<EncounterRecord>>? encounters,
    int? onlineBookings,
    GroupedEncounters? groupedEncounters,
    int? selectedBPartnerId,
    String? selectedBPartnerName,
    bool clearBPartner = false,
  }) {
    return DashboardState(
      encounters: encounters ?? this.encounters,
      onlineBookings: onlineBookings ?? this.onlineBookings,
      groupedEncounters: groupedEncounters ?? this.groupedEncounters,
      selectedBPartnerId: clearBPartner
          ? null
          : selectedBPartnerId ?? this.selectedBPartnerId,
      selectedBPartnerName: clearBPartner
          ? null
          : selectedBPartnerName ?? this.selectedBPartnerName,
    );
  }
}

class DashboardNotifier extends StateNotifier<DashboardState> {
  final Ref ref;

  DashboardNotifier(this.ref)
    : super(
        DashboardState(
          encounters: AsyncData(
            Paginated(
              pageCount: 0,
              pageSize: 0,
              pageNumber: 0,
              rowCount: 0,
              windowRecords: [],
            ),
          ),
        ),
      );

  Future<void> fetchEncounters() async {
    if (state.encounters is AsyncLoading) return;

    state = state.copyWith(encounters: const AsyncValue.loading());
    try {
      final salesRegionId = await ref.read(salesRegionProvider.future);
      final encounterRepo = ref.read(encounterRepositoryProvider);

      final result = await encounterRepo.getTodayEncounters(
        salesRegionId: salesRegionId?.id,
        bPartnerId: state.selectedBPartnerId,
      );

      final onlineBookingsCount = _calculateOnlineBookings(result);
      final groupedData = _groupEncounters(result.windowRecords ?? []);

      state = state.copyWith(
        encounters: AsyncValue.data(result),
        groupedEncounters: groupedData,
        onlineBookings: onlineBookingsCount,
      );
    } catch (e, st) {
      state = state.copyWith(encounters: AsyncValue.error(e, st));
    }
  }

  Future<void> deleteEncounter(int encounterId) async {
    final encounterRepo = ref.read(encounterRepositoryProvider);

    final currentState = state.encounters.value;
    if (currentState == null) return;

    try {
      await encounterRepo.deleteEncounterRecord(encounterId.toString());

      final updatedRecords = currentState.windowRecords
          ?.where((record) => record.id != encounterId)
          .toList();

      if (updatedRecords != null) {
        final newPaginatedData = Paginated(
          windowRecords: updatedRecords,
          rowCount: (currentState.rowCount ?? 0) - 1,
        );

        final newGroupedData = _groupEncounters(updatedRecords);

        state = state.copyWith(
          encounters: AsyncData(newPaginatedData),
          groupedEncounters: newGroupedData,
        );
      }
    } catch (e) {
      throw Exception('Gagal menghapus encounter: $e');
    }
  }

  int _calculateOnlineBookings(Paginated<EncounterRecord> data) {
    if (data.windowRecords == null) {
      return 0;
    }
    return data.windowRecords!
        .where(
          (record) =>
              record.cDocTypeId != null &&
              record.cDocTypeId!.identifier == 'Booking Online',
        )
        .length;
  }

  GroupedEncounters _groupEncounters(List<EncounterRecord> records) {
    final groupedByDate = groupBy(
      records,
      (EncounterRecord record) => DateTime.parse(record.dateTrx),
    );

    return groupedByDate.map((date, encounters) {
      final groupedByDoctor = groupBy(
        encounters,
        (EncounterRecord record) => record.doctorId?.identifier ?? 'Farmasi',
      );

      final nestedGroup = groupedByDoctor.map((doctorName, doctorEncounters) {
        final groupedBySchedule = groupBy(
          doctorEncounters,
          (EncounterRecord record) =>
              record.cEncounterScheduleID ??
              const GeneralInfo(
                propertyLabel: '',
                id: 0,
                identifier: 'Offline',
              ),
        );

        // Ambil semua jadwal (keys) dan urutkan
        final sortedKeys = groupedBySchedule.keys.toList()
          ..sort((a, b) {
            final isAOffline = a.identifier == 'Offline';
            final isBOffline = b.identifier == 'Offline';

            if (isAOffline && !isBOffline) {
              return -1; // 'Offline' selalu di depan
            }
            if (!isAOffline && isBOffline) {
              return 1; // 'Offline' selalu di depan
            }
            if (isAOffline && isBOffline) {
              return 0; // Keduanya offline, urutan tidak penting
            }

            // Keduanya online, urutkan berdasarkan jam mulai
            try {
              final timeA = a.identifier.split(' - ')[0]; // "08:00"
              final timeB = b.identifier.split(' - ')[0]; // "09:00"
              return timeA.compareTo(timeB);
            } catch (e) {
              // Fallback jika format jam tidak sesuai
              return a.identifier.compareTo(b.identifier);
            }
          });

        // Buat map baru yang sudah terurut
        final sortedSchedules = {
          for (var key in sortedKeys) key: groupedBySchedule[key]!,
        };

        return MapEntry(doctorName, sortedSchedules);
      });
      return MapEntry(date, nestedGroup);
    });
  }

  Future<void> filterByBPartner(int bPartnerId, String bPartnerName) async {
    state = state.copyWith(
      selectedBPartnerId: bPartnerId,
      selectedBPartnerName: bPartnerName,
    );
    await fetchEncounters();
  }

  Future<void> clearBPartnerFilter() async {
    state = state.copyWith(clearBPartner: true);
    await fetchEncounters();
  }
}

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
      return DashboardNotifier(ref);
    });
