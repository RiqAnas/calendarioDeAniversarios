class Folder {
  String id;
  String personId;
  String folderId;
  String name;
  String color;

  Folder({
    required this.id,
    required this.personId,
    required this.folderId,
    required this.name,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'personId': personId,
      'folderId': folderId,
      'name': name,
      'color': color,
    };
  }

  Folder fromJson(Map<String, dynamic> data) {
    return Folder(
      id: data['id'],
      personId: data['personId'],
      folderId: data['folderId'],
      name: data['name'],
      color: data['color'],
    );
  }
}
