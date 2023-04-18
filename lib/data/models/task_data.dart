class Task {
  final String title;
  final String subTitle;
  final String description;
  final DateTime date;
  final String tag;
  final bool isDone;

  Task({
    required this.title,
    required this.subTitle,
    required this.description,
    required this.date,
    required this.tag,
    required this.isDone,
  });
}
