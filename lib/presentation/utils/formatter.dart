import 'package:medibuk/domain/entities/general_info.dart';

/// Menghapus semua pasangan key-value dari sebuah Map di mana valuenya adalah null.
/// Fungsi ini bekerja secara rekursif, sehingga juga akan membersihkan Map dan List di dalam Map.
Map<String, dynamic> removeNullValues(Map<String, dynamic> json) {
  final Map<String, dynamic> cleanedJson = {};

  json.forEach((key, value) {
    if (value != null) {
      if (value is Map<String, dynamic>) {
        // Jika value adalah Map, bersihkan secara rekursif
        cleanedJson[key] = removeNullValues(value);
      } else if (value is List) {
        // Jika value adalah List, proses setiap item di dalamnya
        cleanedJson[key] = _cleanList(value);
      } else {
        // Jika bukan null, Map, atau List, tambahkan langsung
        cleanedJson[key] = value;
      }
    }
    // Jika value adalah null, key tidak akan ditambahkan ke cleanedJson
  });

  return cleanedJson;
}

/// Helper function untuk membersihkan item di dalam sebuah List.
List _cleanList(List list) {
  final List cleanedList = [];
  for (var item in list) {
    if (item is Map<String, dynamic>) {
      cleanedList.add(removeNullValues(item));
    } else if (item is List) {
      cleanedList.add(_cleanList(item));
    } else if (item != null) {
      // Hanya tambahkan item jika tidak null (untuk tipe data primitif di dalam list)
      cleanedList.add(item);
    }
  }
  return cleanedList;
}

List<GeneralInfo> parseMultipleGeneralInfo(dynamic rawData) {
  if (rawData == null) return [];

  String? combinedIds;
  String? rawIdentifiers;

  // Ekstrak string id dan identifier dari Map atau GeneralInfo
  if (rawData is Map) {
    combinedIds = rawData['id']?.toString();
    rawIdentifiers = rawData['identifier']?.toString();
  } else if (rawData is GeneralInfo) {
    combinedIds = rawData.id?.toString();
    rawIdentifiers = rawData.identifier;
  }

  if (combinedIds == null || rawIdentifiers == null) return [];

  final ids = combinedIds.split(',').map((e) => e.trim()).toList();
  final regex = RegExp(
    r'([A-Z]\d{2}(?:\.\d)?)-([^,]*(?:,[^A-Z]*?)*?)(?=,\s*[A-Z]\d{2}(?:\.\d)?-|$)',
  );
  final matches = regex.allMatches(rawIdentifiers);
  final List<GeneralInfo> result = [];
  int index = 0;

  for (final match in matches) {
    if (index >= ids.length) break;

    final code = match.group(1)?.trim();
    final description = match.group(2)?.trim();
    final id = ids[index];

    result.add(
      GeneralInfo(
        id: id,
        identifier: '$code-$description', // Gabungkan kembali untuk tampilan
        propertyLabel: code, // Label bisa diisi dengan kode saja
        modelName: 'icd-10-info',
      ),
    );
    index++;
  }

  return result;
}

enum DocumentTypeEnum { bookingOnline, poli, pharmacy }

int getDocumentTypeID(DocumentTypeEnum dt) {
  if (dt == DocumentTypeEnum.bookingOnline) {
    return 1000056;
  } else if (dt == DocumentTypeEnum.poli) {
    return 1000049;
  } else if (dt == DocumentTypeEnum.pharmacy) {
    return 1000047;
  }

  return -1;
}

enum DocumentStatus { drafted, inprogress, complete, invalid, voided }

String? getDocumentStatusID(DocumentStatus dStat) {
  if (dStat == DocumentStatus.drafted) {
    return "DR";
  } else if (dStat == DocumentStatus.inprogress) {
    return "IP";
  } else if (dStat == DocumentStatus.complete) {
    return "CO";
  } else if (dStat == DocumentStatus.invalid) {
    return "IN";
  } else if (dStat == DocumentStatus.voided) {
    return "VO";
  }

  return "";
}
