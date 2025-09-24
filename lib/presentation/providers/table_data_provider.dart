import 'package:flutter_riverpod/flutter_riverpod.dart';

class TableState {
  final List<dynamic> data;
  final Set<String> selectedUids;

  TableState({required this.data, this.selectedUids = const {}});

  TableState copyWith({List<dynamic>? data, Set<String>? selectedUids}) {
    return TableState(
      data: data ?? this.data,
      selectedUids: selectedUids ?? this.selectedUids,
    );
  }
}

class TableDataNotifier extends StateNotifier<TableState> {
  TableDataNotifier(List<dynamic> initialData)
    : super(TableState(data: initialData));

  void selectRow(String uid, bool isSelected) {
    final newSelected = Set<String>.from(state.selectedUids);
    if (isSelected) {
      newSelected.add(uid);
    } else {
      newSelected.remove(uid);
    }
    state = state.copyWith(selectedUids: newSelected);
  }

  void selectAllRows(bool isSelected, List<String> allUids) {
    state = state.copyWith(
      selectedUids: isSelected ? allUids.toSet() : <String>{},
    );
  }

  void addOrUpdateItem(dynamic item) {
    final List<dynamic> currentList = List.from(state.data);
    final int index = currentList.indexWhere((d) => d.uid == item.uid);

    if (index != -1) {
      currentList[index] = item;
    } else {
      currentList.add(item);
    }
    state = state.copyWith(data: currentList);
  }

  void deleteSelected() {
    final List<dynamic> newList = List.from(state.data);
    newList.removeWhere((d) => state.selectedUids.contains(d.uid));
    state = state.copyWith(data: newList, selectedUids: {});
  }
}

final tableDataProvider =
    StateNotifierProvider.family<TableDataNotifier, TableState, List<dynamic>>(
      (ref, initialData) => TableDataNotifier(initialData),
    );
