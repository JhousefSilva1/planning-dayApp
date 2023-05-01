// To parse this JSON data, do
//
//     final tags = tagsFromJson(jsonString);

import 'dart:convert';

List<Tags> tagsFromJson(String str) => List<Tags>.from(json.decode(str).map((x) => Tags.fromJson(x)));

String tagsToJson(List<Tags> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tags {
  int? labelId;
  String? name;

  Tags({
    this.labelId,
    this.name,
  });

  factory Tags.fromJson(Map<String, dynamic> json) => Tags(
    labelId: json["labelId"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "labelId": labelId,
    "name": name,
  };
}
