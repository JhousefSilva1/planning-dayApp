// ignore_for_file: depend_on_referenced_packages, unused_import

import 'dart:convert'; //this library convert datos to jason
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:tasks/app/constants.dart';
import 'package:tasks/data/service/service.dart';

import '../../cubit/auth/auth_state.dart'; //using library http to make request http "GET, POST, PUT, DELETE"

class AuthService {
  // final baseUrl = 'http://localhost:9999/api/v1/auth'; // we're setting de url backend

  final _services = Service();
  Future<String> logIn(
      {required String username, required String password}) async {
    String url = '${Globals.apiUrl}/login';
    var body = jsonEncode({
      'username': username,
      'password': password
    }); // establish that the body  has username and password

    final response = await _services.postHttp(url, body, 1);

    if(response is String){
      return response;
    }else{
      if (response.statusCode == 200) {
        final data = jsonDecode(response
            .body); // Decode http response that recive of server from Json to Dart

        if (data['code'] == '0000') {
          // ignore: unused_local_variable
          final token = data['response']['authToken']; //extract token value from http authentication response
          var jwtToken = _services.parseJwtPayLoad(token);
          final decodedData = json.decode(response.body);
          await _services.secureStorage(decodedData, jwtToken);
          // await _services.secureStorage(decodedData, jwtToken);

          return '0000';
        } else {
          //final error = data['response']['message'];
          return '0001';
        }
        // } else {
        //   return response.statusCode.toString();
        // }
      } else if (response.statusCode == 400) {
        return '0001';
      } else if (response.statusCode == 500) {
        return '0001';
      } else {
        return '0001';
      }
    }
  }

  void logOut() {}

  String? getAuthToken() {
    return null;
  }
}
