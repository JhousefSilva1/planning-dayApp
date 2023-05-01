import 'dart:convert';

import 'package:tasks/app/constants.dart';
import 'package:tasks/data/models/tags.dart';
import 'package:tasks/data/service/service.dart';

class TagsService{
  final _services = Service();

  Future allTags() async {
    String url = '${Globals.apiUrl}/label';
    final response = await _services.getHttp(url, 0);
    if(response is String){
      return response;        
    }else{
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Decode http response that recive of server from Json to Dart
        if (data['code'] == '0000') {
          final tags = tagsFromJson(jsonEncode(data['response']));
          return tags;
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

  Future createTags(Tags tags) async {
    String url = '${Globals.apiUrl}/label';
    var body = jsonEncode({
      'name': tags.name,
      'date': "2019-01-01T00:00:00Z"
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

  Future updateTags(Tags tags, int id) async {
    String url = '${Globals.apiUrl}/label/$id';
    var body = jsonEncode({
      'name': tags.name,
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
}