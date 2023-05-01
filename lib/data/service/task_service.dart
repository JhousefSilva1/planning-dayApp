

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tasks/app/constants.dart';
import 'package:tasks/data/models/tasks.dart';
import 'package:tasks/data/service/service.dart';

import '../models/tasks.dart';


class TaskService {
  final _services = Service();

  Future allTasks() async {
    String url = '${Globals.apiUrl}/task';
    final response = await _services.getHttp(url, 0);
    if(response is String){
      return response;        
    }else{
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Decode http response that recive of server from Json to Dart
        if (data['code'] == '0000') {
          final task = taskFromJson(jsonEncode(data['response']));
          return task;
        } else if (data['code'] == '0001'){
          return '0001';
        } else {
          return Globals.checkInternet;
        }
      } else if (response.statusCode == 500) {
        return Globals.checkServer;
      } else {
        return Globals.checkServer;
      }
    }
  }

  Future createTask(Task task) async {
    String url = '${Globals.apiUrl}/task';
    var body = jsonEncode({
      'description': task.description,
      'date': "2019-03-03T00:00:00Z",
      'labelIds': task.labelIds
    });
    final response = await _services.postHttp(url, body, 0);
    if(response is String){
      return response;        
    }else{
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Decode http response that recive of server from Json to Dart
        if (data['code'] == '0000') {
          print(data);
          // final task = taskFromJson(jsonEncode(data['response']));
          // return task;
        } else if (data['code'] == '0001'){
          print(data);
          // return '0001';
        } else {
          return Globals.checkInternet;
        }
      } else if (response.statusCode == 500) {
        return Globals.checkServer;
      } else {
        return Globals.checkServer;
      }
    }
  }

  Future updateTask(Task task, int id) async {
    String url = '${Globals.apiUrl}/task/$id';
    var body = jsonEncode({
      'description': task.description,
      'date': "2019-01-01T00:00:00Z",
    });
    final response = await _services.putHttp(url, body, 0);
    if(response is String){
      return response;        
    }else{
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Decode http response that recive of server from Json to Dart
        if (data['code'] == '0000') {
          print(data);
          final tags = taskFromJson(jsonEncode(data['response']));
          // return task;
        } else if (data['code'] == '0001'){
          print(data);
          // return '0001';
        } else {
          return Globals.checkInternet;
        }
      } else if (response.statusCode == 500) {
        return Globals.checkServer;
      } else {
        return Globals.checkServer;
      }
    }
  }

  // Future<void> deleteTask(TaskList task) async {
    // final response = await http.delete(Uri.parse('$_baseUrl/${task.id}'));
    // if (response.statusCode != 204) {
    //   throw Exception('Failed to delete task');
    // }
  // }

  /*Tags */

}
