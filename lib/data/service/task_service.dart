

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/task_list.dart';


class TaskService {
  static const String _baseUrl = 'https://example.com/tasks';

  Future<List> fetchTasks() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Failed to fetch tasks');
    }
  }

  Future<Task> createTask(String description) async {
    final response = await http.post(Uri.parse(_baseUrl), body: {'description': description});
    if (response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Task.fromJson(data);
    } else {
      throw Exception('Failed to create task');
    }
  }

  Future<void> updateTask(Task task) async {
    final response = await http.put(Uri.parse('$_baseUrl/${task.id}'), body: {'isDone': task.isDone.toString()});
    if (response.statusCode != 204) {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(Task task) async {
    final response = await http.delete(Uri.parse('$_baseUrl/${task.id}'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete task');
    }
  }

  /*Tags */

}
