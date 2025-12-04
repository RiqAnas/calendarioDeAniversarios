class Folder {
  String id;
  String personId;
  String? folderId;
  String name;
  String color;
  DateTime createdAt;

  Folder({
    required this.id,
    required this.personId,
    this.folderId,
    required this.name,
    required this.color,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'personId': personId,
      'folderId': folderId,
      'name': name,
      'color': color,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static Folder fromJson(Map<String, dynamic> data) {
    return Folder(
      id: data['id'],
      personId: data['personId'],
      folderId: data['folderId'],
      name: data['name'],
      color: data['color'],
      createdAt: DateTime.parse(data['createdAt']),
    );
  }
}
