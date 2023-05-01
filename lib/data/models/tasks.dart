// // To parse this JSON data, do
// //
// //     final task = taskFromJson(jsonString);

// // import 'package:meta/meta.dart';
// import 'dart:convert';

// List<Task> taskFromJson(String str) => List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

// String taskToJson(List<Task> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Task {
//     int? taskId;
//     String? description;
//     DateTime? date;
//     List<int> labelIds;
//     bool isDone;

//     Task({
//       this.taskId,
//       this.description,
//       this.date,
//       required this.labelIds,
//       required this.isDone
//     });

//     factory Task.fromJson(Map<String, dynamic> json) => Task(
//       taskId: json["taskId"],
//       description: json["description"],
//       date: DateTime.parse(json["date"]),
//       labelIds: List<int>.from(json["labelIds"].map((x) => x)),
//       isDone: json['isDone']
//     );

//     Map<String, dynamic> toJson() => {
//       "taskId": taskId,
//       "description": description,
//       "date": date,
//       "labelIds": List<dynamic>.from(labelIds!.map((x) => x)),
//       "isDone": isDone
//     };
// }
// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<Task> taskFromJson(String str) => List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
    int? taskId;
    String? title;
    String? description;
    String? date;
    List<int> labelIds;
    bool isDone;
    bool isDelete;

    Task({
      this.taskId,
      this.title,
      this.description,
      this.date,
      required this.labelIds,
      required this.isDone,
      required this.isDelete
    });

    factory Task.fromJson(Map<String, dynamic> json) => Task(
      taskId: json["taskId"],
      title: json["title"],
      description: json["description"],
      date: json["date"],
      labelIds: List<int>.from(json["labelIds"].map((x) => x)),
      isDone: json['isDone'],
      isDelete: json['isDelete']
    );

    Map<String, dynamic> toJson() => {
      "taskId": taskId,
      "title": title,
      "description": description,
      "date": date,
      "labelIds": List<dynamic>.from(labelIds!.map((x) => x)),
      "isDone": isDone,
      "isDelete": isDelete,
    };
}
