import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:medibuk/data/repositories/encounter_repository.dart';
import 'package:medibuk/domain/entities/paginated.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/presentation/providers/warehouse_provider.dart';

// Tipe data baru untuk grouping 3 tingkat
// Map<Tanggal, Map<NamaDokter, Map<Jadwal, List<EncounterRecord>>>>
typedef GroupedEncounters =
    Map<DateTime, Map<String, Map<GeneralInfo, List<EncounterRecord>>>>;

class DashboardState {
  final AsyncValue<Paginated<EncounterRecord>> encounters;
  final int onlineBookings;
  final GroupedEncounters groupedEncounters;

  DashboardState({
    required this.encounters,
    this.onlineBookings = 0,
    this.groupedEncounters = const {},
  });

  DashboardState copyWith({
    AsyncValue<Paginated<EncounterRecord>>? encounters,
    int? onlineBookings,
    GroupedEncounters? groupedEncounters,
  }) {
    return DashboardState(
      encounters: encounters ?? this.encounters,
      onlineBookings: onlineBookings ?? this.onlineBookings,
      groupedEncounters: groupedEncounters ?? this.groupedEncounters,
    );
  }
}

class DashboardNotifier extends StateNotifier<DashboardState> {
  final Ref ref;

  DashboardNotifier(this.ref)
    : super(DashboardState(encounters: const AsyncValue.loading())) {
    _init();
  }

  void _init() {
    ref.listen<AsyncValue<int>>(salesRegionIdProvider, (previous, next) {
      if (next.hasValue) {
        fetchEncounters(salesRegionId: next.requireValue);
      }
    }, fireImmediately: true);
  }

  Future<void> fetchEncounters({required int salesRegionId}) async {
    state = state.copyWith(encounters: const AsyncValue.loading());
    try {
      final encounterRepo = ref.read(encounterRepositoryProvider);
      // Untuk dashboard, kita ambil data beberapa hari ke depan jika perlu
      // Di sini kita tetap ambil data hari ini saja sesuai logika sebelumnya
      final result = await encounterRepo.getTodayEncounters(
        salesRegionId: salesRegionId,
      );

      final bookings = _calculateOnlineBookings(result);
      final groupedData = _groupEncounters(result.windowRecords);

      state = state.copyWith(
        encounters: AsyncValue.data(result),
        onlineBookings: bookings,
        groupedEncounters: groupedData,
      );
    } catch (e, st) {
      state = state.copyWith(encounters: AsyncValue.error(e, st));
    }
  }

  // --- FUNGSI GROUPING YANG DIPERBARUI ---
  GroupedEncounters _groupEncounters(List<EncounterRecord> records) {
    // 1. Grup per Tanggal
    final groupedByDate = groupBy(
      records,
      (EncounterRecord record) => DateTime.parse(record.dateTrx),
    );

    // 2. Untuk setiap tanggal, grup lagi per dokter dan jadwal
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
              GeneralInfo(propertyLabel: '', id: 0, identifier: 'Offline'),
        );
        return MapEntry(doctorName, groupedBySchedule);
      });
      return MapEntry(date, nestedGroup);
    });
  }

  int _calculateOnlineBookings(Paginated<EncounterRecord> data) {
    // ... (fungsi ini tidak berubah)
    return 0; // Placeholder
  }
}

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
      return DashboardNotifier(ref);
    });
