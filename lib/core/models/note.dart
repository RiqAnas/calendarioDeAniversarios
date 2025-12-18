class Note {
  String id;
  String personid;
  String? folderid;
  String title;
  String description;
  int mark;
  DateTime createdAt;
  int? marked;
  DateTime? date;
  String? color;
  String? textcolor;
  bool markview;
  bool favorite;

  Note({
    required this.id,
    required this.personid,
    this.folderid,
    required this.title,
    required this.description,
    required this.mark,
    required this.createdAt,
    required this.favorite,
    this.marked,
    this.color,
    this.textcolor,
    this.markview = false,
    this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'personId': personid,
      'folderId': folderid,
      'title': title,
      'description': description,
      'mark': mark,
      'marked': marked,
      'date': date?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'color': color,
      'textcolor': textcolor,
      'markview': markview ? 1 : 0,
      'favorite': favorite ? 1 : 0,
    };
  }

  static Note fromJson(Map<String, dynamic> data) {
    return Note(
      id: data['id'],
      personid: data['personId'],
      folderid: data['folderId'],
      title: data['title'],
      description: data['description'],
      mark: data['mark'],
      marked: data['marked'],
      createdAt: DateTime.parse(data['createdAt']),
      date: data['date'] == null ? null : DateTime.parse(data['date']),
      color: data['color'],
      textcolor: data['textcolor'],
      markview: data['markview'] == 1 ? true : false,
      favorite: data['favorite'] == 1 ? true : false,
    );
  }
}
