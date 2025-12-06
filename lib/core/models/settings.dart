class Settings {
  String id;
  String color;
  bool mode;

  Settings({required this.id, required this.color, required this.mode});

  Map<String, dynamic> toJson() {
    return {'id': id, 'color': color, 'mode': mode ? 1 : 0};
  }

  static Settings fromJson(Map<String, dynamic> data) {
    return Settings(
      id: data['id'],
      color: data['color'],
      mode: data['mode'] == 1 ? true : false,
    );
  }
}
