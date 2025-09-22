import 'dart:convert';
import 'package:medibuk/domain/entities/medical_record.dart';
import 'package:medibuk/presentation/providers/form_data_provider.dart';

/// Build a JSON map from the model (json_serializable) and apply current edits.
/// - Starts from the model object (not assets), deep-converted to pure maps/lists
/// - Patches main (top-level) and list sections (e.g., obstetric, gynecology)
/// - Converts GeneralInfo values into nested JSON maps
Map<String, dynamic> buildPatchedJsonFromModel(
  MedicalRecord record,
  FormDataState formState,
  String recordId, {
  List<String> listSections = const [
    'obstetric',
    'gynecology',
    'prescriptions',
  ],
}) {
  final base = (jsonDecode(jsonEncode(record)) as Map).cast<String, dynamic>();
  final prefix = '$recordId|';

  dynamic encodeValue(dynamic v) {
    if (v is GeneralInfo) {
      return (jsonDecode(jsonEncode(v)) as Map).cast<String, dynamic>();
    }
    return v;
  }

  void applyMain(Map<String, dynamic> fields) {
    fields.forEach((k, v) => base[k] = encodeValue(v));
  }

  void applyListItem(String section, int index, Map<String, dynamic> fields) {
    final anyList = base[section];
    if (anyList is! List || index < 0 || index >= anyList.length) return;
    final list = anyList;
    var entry = list[index];
    if (entry is! Map) {
      try {
        entry = (jsonDecode(jsonEncode(entry)) as Map).cast<String, dynamic>();
        list[index] = entry;
      } catch (_) {
        entry = <String, dynamic>{};
        list[index] = entry;
      }
    }
    final item = (entry).cast<String, dynamic>();
    fields.forEach((k, v) => item[k] = encodeValue(v));
  }

  formState.current.forEach((sectionKey, fields) {
    if (!sectionKey.startsWith(prefix)) return;
    final after = sectionKey.substring(prefix.length); // e.g., 'main:0'
    final parts = after.split(':');
    if (parts.length != 2) return;
    final section = parts[0];
    final idx = int.tryParse(parts[1]) ?? 0;
    if (section == 'main') {
      applyMain(fields);
    } else if (listSections.contains(section)) {
      applyListItem(section, idx, fields);
    }
  });

  return base;
}
