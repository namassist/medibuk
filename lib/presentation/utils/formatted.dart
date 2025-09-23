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
