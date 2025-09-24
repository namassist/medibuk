import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormDataState {
  final Map<String, Map<String, dynamic>> original;
  final Map<String, Map<String, dynamic>> current;

  const FormDataState({required this.original, required this.current});

  FormDataState copyWith({
    Map<String, Map<String, dynamic>>? original,
    Map<String, Map<String, dynamic>>? current,
  }) => FormDataState(
    original: original ?? this.original,
    current: current ?? this.current,
  );

  static FormDataState empty() =>
      const FormDataState(original: {}, current: {});
}

class FormDataNotifier extends StateNotifier<FormDataState> {
  FormDataNotifier() : super(FormDataState.empty());

  static String _key(String recordId, String sectionType, int sectionIndex) =>
      '$recordId|$sectionType:$sectionIndex';

  /// Record a field update. The first time a field is seen, [originalValue]
  /// is stored so we can compute diffs later.
  void updateField({
    required String recordId,
    required String sectionType,
    required int sectionIndex,
    required String fieldName,
    required dynamic originalValue,
    required dynamic newValue,
  }) {
    final key = _key(recordId, sectionType, sectionIndex);
    final original = Map<String, Map<String, dynamic>>.from(state.original);
    final current = Map<String, Map<String, dynamic>>.from(state.current);

    original.putIfAbsent(key, () => {});
    current.putIfAbsent(key, () => {});

    // Store original only once
    original[key]!.putIfAbsent(fieldName, () => originalValue);

    // Always update current with latest value
    current[key]![fieldName] = newValue;

    state = state.copyWith(original: original, current: current);
  }

  /// Initialize a section with a baseline map of values.
  /// If the section already exists, this is a no-op to keep the original snapshot stable.
  void ensureSectionInitialized({
    required String recordId,
    required String sectionType,
    required int sectionIndex,
    required Map<String, dynamic> fields,
  }) {
    final key = _key(recordId, sectionType, sectionIndex);
    if (state.original.containsKey(key) && state.current.containsKey(key)) {
      return;
    }
    final original = Map<String, Map<String, dynamic>>.from(state.original);
    final current = Map<String, Map<String, dynamic>>.from(state.current);
    original[key] = Map<String, dynamic>.from(fields);
    current[key] = Map<String, dynamic>.from(fields);
    state = state.copyWith(original: original, current: current);
  }

  /// Clear all tracked changes
  void clear() => state = FormDataState.empty();

  /// Compute diffs as a list of maps for easy logging/inspection
  List<Map<String, dynamic>> computeDiff() {
    final diffs = <Map<String, dynamic>>[];
    state.current.forEach((section, fields) {
      final origFields = state.original[section] ?? const {};
      fields.forEach((name, newVal) {
        final oldVal = origFields[name];
        if (!_equals(oldVal, newVal)) {
          diffs.add({
            'section': section,
            'field': name,
            'from': oldVal,
            'to': newVal,
          });
        }
      });
    });
    return diffs;
  }

  bool _equals(dynamic a, dynamic b) {
    try {
      return a == b;
    } catch (_) {
      return identical(a, b);
    }
  }
}

final formDataProvider = StateNotifierProvider<FormDataNotifier, FormDataState>(
  (ref) => FormDataNotifier(),
);
