import 'dart:convert';
import 'package:medibuk/domain/entities/record.dart';
import 'package:medibuk/presentation/providers/form_data_provider.dart';

Map<String, dynamic> buildPatchedJsonFromModel<T extends Record>(
  T record,
  FormDataState formState,
  String recordId, {
  List<String> listSections = const [
    'medrec_obstetric',
    'medrec_gynecology',
    'medrec_anak',
    'medrec_laktasi',
    'medrec_umum',
    'medrec_andrologi',
    'prescriptions',
    'services',
  ],
}) {
  final base = (jsonDecode(jsonEncode(record)) as Map).cast<String, dynamic>();
  final prefix = '$recordId|';

  dynamic encodeValue(dynamic v) {
    if (v != null && v is! String && v is! num && v is! bool) {
      try {
        return (jsonDecode(jsonEncode(v)) as Map).cast<String, dynamic>();
      } catch (_) {
        return v;
      }
    }
    return v;
  }

  void applyFields(Map<String, dynamic> fields) {
    fields.forEach((key, value) => base[key] = encodeValue(value));
  }

  void applyListItem(String section, int index, Map<String, dynamic> fields) {
    final jsonKey = section.startsWith('medrec_')
        ? section.substring(7)
        : section;

    final anyList = base[jsonKey];
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
    fields.forEach((key, value) => item[key] = encodeValue(value));
  }

  formState.current.forEach((sectionKey, fields) {
    if (!sectionKey.startsWith(prefix)) return;

    final after = sectionKey.substring(prefix.length);
    final parts = after.split(':');
    if (parts.length != 2) return;

    final section = parts[0];
    final idx = int.tryParse(parts[1]) ?? 0;

    if (listSections.contains(section)) {
      applyListItem(section, idx, fields);
    } else {
      applyFields(fields);
    }
  });

  return base;
}
