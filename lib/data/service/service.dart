// ignore_for_file: prefer_const_constructors, avoid_print, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:io';
//importar http
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../cubit/auth/auth_state.dart';

class Service {
  //String apiSecretKeyKeycloak = keyGlobal.KeyGlobal().apiSecretKeyKeycloak();
  String apiUrl = 'http://localhost:9999/api/v1/auth';
  //final _storage = FlutterSecureStorage();
  //var messages = message.Messages();
  var headerJson = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
  };

  headerAccessToken() async {
    String? accessToken = '';
   // await _storage.read(key: 'accessToken');
    return <String, String>{
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
  }


  Future<bool> verifyInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  Future postHttp(String url, body, int headerAccess) async {
    var header = <String, String>{};
    headerAccess == 0
        ? header = await headerAccessToken()
        : header = headerJson;

    final verifyInternetGoogle = await verifyInternet();
    if (verifyInternetGoogle == true) {
      try {
        final resp =
            await http.post(Uri.parse(url), headers: header, body: body);
        return resp;
      } on TimeoutException catch (e) {
        print(e);

        return AuthServerFailure;
      } on SocketException catch (e) {
        print(e);

        return AuthServerFailure;
      } catch (e) {
        throw const SocketException.closed();
      }
    } else {
      return AuthServerFailure;
    }
  }

  Future getHttp(String url, int headerAccess) async {
    var header;
    headerAccess == 0
        ? header = await headerAccessToken()
        : header = headerJson;
    final verifyInternetGoogle = await verifyInternet();
    if (verifyInternetGoogle == true) {
      try {
        final resp = await http.get(Uri.parse(url), headers: header);
        return resp;
      } on TimeoutException catch (e) {
        print(e);
        return AuthServerFailure;
      } on SocketException catch (e) {
        print(e);
        return AuthServerFailure;
      } catch (e) {
        print(e);
        throw SocketException.closed();
      }
    } else {
      return AuthServerFailure;
    }
  }

  Future putHttp(String url, body, int headerAccess) async {
    var header;
    headerAccess == 0
        ? header = await headerAccessToken()
        : header = headerJson;
    final verifyInternetGoogle = await verifyInternet();
    if (verifyInternetGoogle == true) {
      try {
        final resp =
            await http.put(Uri.parse(url), headers: header, body: body);
        return resp;
      } on TimeoutException catch (e) {
        print(e);
        return AuthServerFailure;
      } on SocketException catch (e) {
        print(e);
        return AuthServerFailure;
      } catch (e) {
        print(e);
        throw SocketException.closed();
      }
    } else {
      return AuthServerFailure;
    }
  }

  Future deleteHttp(String url, int headerAccess) async {
    var header;
    headerAccess == 0
        ? header = await headerAccessToken()
        : header = headerJson;
    final verifyInternetGoogle = await verifyInternet();
    if (verifyInternetGoogle == true) {
      try {
        final resp = await http.delete(Uri.parse(url), headers: header);
        return resp;
      } on TimeoutException catch (e) {
        print(e);
        return AuthServerFailure;
      } on SocketException catch (e) {
        print(e);
        return AuthServerFailure;
      } catch (e) {
        print(e);
        throw SocketException.closed();
      }
    } else {
      return AuthServerFailure;
    }
  }

  Map<String, dynamic> parseJwtPayLoad(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception(AuthTokenExpire);
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception(AuthTokenExpire);
    }
    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }
    return utf8.decode(base64Url.decode(output));
  }
}
