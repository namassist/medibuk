class RoleSelectionItem {
  final int id;
  final String name;

  RoleSelectionItem({required this.id, required this.name});

  factory RoleSelectionItem.fromJson(Map<String, dynamic> json) {
    return RoleSelectionItem(id: json['id'], name: json['name']);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoleSelectionItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class InitialLoginData {
  final String token;
  final List<RoleSelectionItem> clients;

  InitialLoginData({required this.token, required this.clients});

  factory InitialLoginData.fromJson(Map<String, dynamic> json) {
    var clientsList = json['clients'] as List;
    List<RoleSelectionItem> clients = clientsList
        .map((i) => RoleSelectionItem.fromJson(i))
        .toList();
    return InitialLoginData(token: json['token'], clients: clients);
  }
}
