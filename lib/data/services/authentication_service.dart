// ignore_for_file: depend_on_referenced_packages

import 'dart:convert'; //this library convert datos to jason

import 'package:http/http.dart'
    as http; //using library http to make request http "GET, POST, PUT, DELETE"

class AuthenticationService {
  final baseUrl =
      'https://backend-sprint.com/api'; // we're setting de url backend

  Future<String> logIn(
      {required String username, required String password}) async {
    final response = await http.post(
      Uri.parse(
          '$baseUrl/login'), //build instance class Uri, and that represent the url of http request "$baseUrl" = representa la url del backend, "/login"= es el endpoint
      headers: {'Content-Type': 'application/json'}, //se establish data in json
      body: jsonEncode({
        'username': username,
        'password': password
      }), // establish that the body  has username and password
    );
    if (response.statusCode == 200) {
      /// ask if the http response is 200 code
      final data = jsonDecode(response
          .body); // Decode http response that recive of server from Json to Dart
      final token =
          data['token']; //extract token value from http authentication response
      return token; //retrun token value
    } else {
      final error = jsonDecode(response.body)[
          'error']; //Extract message error from http request,Decode from json to Dart
      throw Exception(error);
    }
  }

  void logOut() {}

  String? getAuthToken() {
    return null;
  }
}
