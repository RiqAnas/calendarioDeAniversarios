class Note {
  String id;
  String personid;
  String title;
  String description;
  int mark;
  DateTime createdAt;
  int? marked;
  DateTime? date;

  Note({
    required this.id,
    required this.personid,
    required this.title,
    required this.description,
    required this.mark,
    required this.createdAt,
    this.marked,
    this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'personId': personid,
      'title': title,
      'description': description,
      'mark': mark,
      'marked': marked,
      'date': date?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static Note fromJson(Map<String, dynamic> data) {
    return Note(
      id: data['id'],
      personid: data['personId'],
      title: data['title'],
      description: data['description'],
      mark: data['mark'],
      marked: data['marked'],
      createdAt: DateTime.parse(data['createdAt']),
      date: data['date'] == null ? null : DateTime.parse(data['date']),
    );
  }
}
