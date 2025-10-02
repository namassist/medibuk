import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/repositories/encounter_repository.dart';
import 'package:medibuk/domain/entities/encounter_record.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/presentation/providers/warehouse_provider.dart';
import 'package:collection/collection.dart';

class BidanDashboardState {
  final AsyncValue<List<EncounterRecord>> encounters;
  final List<GeneralInfo> availableDoctors;
  final GeneralInfo? selectedDoctor;

  BidanDashboardState({
    required this.encounters,
    this.availableDoctors = const [],
    this.selectedDoctor,
  });

  BidanDashboardState copyWith({
    AsyncValue<List<EncounterRecord>>? encounters,
    List<GeneralInfo>? availableDoctors,
    GeneralInfo? selectedDoctor,
  }) {
    return BidanDashboardState(
      encounters: encounters ?? this.encounters,
      availableDoctors: availableDoctors ?? this.availableDoctors,
      selectedDoctor: selectedDoctor ?? this.selectedDoctor,
    );
  }
}

class BidanDashboardNotifier extends StateNotifier<BidanDashboardState> {
  final Ref ref;
  BidanDashboardNotifier(this.ref)
    : super(BidanDashboardState(encounters: const AsyncValue.loading())) {
    _init();
  }

  void _init() {
    ref.listen<AsyncValue<int>>(salesRegionIdProvider, (prev, next) {
      if (next.hasValue) {
        fetchBidanEncounters(salesRegionId: next.requireValue);
      }
    }, fireImmediately: true);
  }

  Future<void> fetchBidanEncounters({
    required int salesRegionId,
    String? date,
  }) async {
    state = state.copyWith(encounters: const AsyncValue.loading());
    try {
      final repo = ref.read(encounterRepositoryProvider);
      final result = await repo.getTodayBidanEncounters(
        salesRegionId: salesRegionId,
        date: date,
      );

      final doctors = result.windowRecords
          .map((e) => e.doctorId)
          .whereNotNull()
          .toSet()
          .toList();

      state = state.copyWith(
        encounters: AsyncValue.data(result.windowRecords),
        availableDoctors: doctors,
        selectedDoctor: state.selectedDoctor ?? doctors.firstOrNull,
      );
    } catch (e, st) {
      state = state.copyWith(encounters: AsyncValue.error(e, st));
    }
  }

  void selectDoctor(GeneralInfo? doctor) {
    state = state.copyWith(selectedDoctor: doctor);
  }
}

final bidanDashboardProvider =
    StateNotifierProvider<BidanDashboardNotifier, BidanDashboardState>((ref) {
      return BidanDashboardNotifier(ref);
    });
