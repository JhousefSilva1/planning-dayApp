// ignore_for_file: depend_on_referenced_packages

import 'dart:convert'; //this library convert datos to jason
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:tasks/data/services/service.dart';

import '../../cubit/authentication/authentication_state.dart'; //using library http to make request http "GET, POST, PUT, DELETE"

class AuthenticationService {
  final baseUrl =
      'http://localhost:9999/api/v1/auth'; // we're setting de url backend

  final _services = Service();
  Future<String> logIn(
      {required String username, required String password}) async {
    String url = '$baseUrl/login';
    var body = jsonEncode({
      'username': username,
      'password': password
    }); // establish that the body  has username and password

    final response = await _services.postHttp(url, body, 1);
    // final response = await http.post(
    //   Uri.parse(
    //       '$baseUrl/login'), //build instance class Uri, and that represent the url of http request "$baseUrl" = representa la url del backend, "/login"= es el endpoint
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Access-Control-Allow-Origin':
    //         '*', // añade el encabezado necesario para CORS
    //   }, //se establish data in json
    //   body: jsonEncode({
    //     'username': username,
    //     'password': password
    //   }), // establish that the body  has username and password
    // );

    if (response is AuthenticationFailure ||
        response is AuthenticationServerFailure ||
        response is AuthenticationTokenExpire) {
      return response.toString();
    } else if (response.statusCode == 200) {
      final data = jsonDecode(response
          .body); // Decode http response that recive of server from Json to Dart

      if (data['code'] == '0000') {
        // ignore: unused_local_variable
        final token = data['response'][
            'authToken']; //extract token value from http authentication response
        //return token; //retrun token value
        // ignore: unused_local_variable
        var jwtToken = _services.parseJwtPayLoad(token);
        // ignore: await_only_futures
        //await _services.secureStorage(decodedData, jwtToken);
  
        return '0000';
      } else {
        //final error = data['response']['message'];
        return '0001';
      }
    } else if (response.statusCode == 400) {
      return '0001';
    } else if (response.statusCode == 500) {
      return '0001';
    } else {
      return '0001';
    }
    // if (response.statusCode == 200) {
    //   /// ask if the http response is 200 code
    //   final data = jsonDecode(response
    //       .body); // Decode http response that recive of server from Json to Dart

    //   if (data['code'] == '0000') {
    //     // ignore: unused_local_variable
    //     final token = data['response'][
    //         'authToken']; //extract token value from http authentication response
    //     //return token; //retrun token value
    //     return '0000';
    //   } else {
    //     //final error = data['response']['message'];
    //     return '0001';
    //   }

    //   //final token =
    //   //data['token']; //extract token value from http authentication response
    //   //return token; //retrun token value
    //   //return response.statusCode.toString();
    // } else {
    //   if (response.statusCode == 500) {
    //     //throw Exception('Server error');
    //     return 'server-error';
    //   }

    //   final error = jsonDecode(response.body)[
    //       'error']; //Extract message error from http request,Decode from json to Dart
    //   throw Exception(error);
    // }
  }

  void logOut() {}

  String? getAuthToken() {
    return null;
  }
}
