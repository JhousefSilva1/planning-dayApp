class Task {
  String ?id;
  String title;
  String subtitle;
  String description;
  DateTime date;
  String tag;
  bool isDone;


  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.date,
    required this.tag,
    this.isDone = false,
  });

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        subtitle = json['subtitle'],
        description = json['description'],
        date = DateTime.parse(json['date']),
        tag = json['tag'],
        isDone = json['isDone'];

  Map<String, dynamic> toJson() => {
        'id':id,
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'date': date.toIso8601String(),
        'tag': tag,
        'isDone': isDone,
      };


}
