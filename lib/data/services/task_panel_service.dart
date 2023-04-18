// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart';

class TaskPanelService {
  final baseUrl = 'http://localhost:9999/api/v1/task';

  Future<String> AddTask(
      {required String Titlle,
      required String SubTile,
      required String Description,
      required String Date,
      required String Time,
      required String tag,
      required String Status}) async {
    final response = await post(
      Uri.parse('$baseUrl/add'),
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode({
        'title': Titlle,
        'subtitle': SubTile,
        'description': Description,
        'date': Date,
        'time': Time,
        'tag': tag,
        'status': Status
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['code'] == '0000') {
        return '0000';
      } else {
        return '0001';
      }
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }
}
