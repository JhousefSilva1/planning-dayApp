import 'dart:async';
import 'dart:convert';
import 'dart:io';
//importar http
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../cubit/authentication/authentication_state.dart';

class Service {
  //String apiSecretKeyKeycloak = keyGlobal.KeyGlobal().apiSecretKeyKeycloak();
  String apiUrl = 'http://localhost:9999/api/v1/auth';
  final _storage = FlutterSecureStorage();
  //var messages = message.Messages();
  var headerJson = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
  };

  headerAccessToken() async {
    String? accessToken = await _storage.read(key: 'accessToken');
    return <String, String>{
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
  }

  // headerKeyCloak() async {
  //   var bytes = utf8.encode('web:' + apiSecretKeyKeycloak);
  //   var base64Str = base64.encode(bytes).toString();
  //   return <String, String>{
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //     'Authorization': 'Basic $base64Str'
  //   };
  // }

  // Future refreshToken() async {
  //   String url =
  //       '$apiUrlKeycloak/auth/realms/master/protocol/openid-connect/token';
  //   String refreshToken = await _storage.read(key: 'refreshToken');
  //   var header = await headerKeyCloak();
  //   var body = <String, String>{
  //     'grant_type': 'refresh_token',
  //     'refresh_token': refreshToken,
  //   };
  //   final verifyInternetGoogle = await verifyInternet('google.com');
  //   if (verifyInternetGoogle == true) {
  //     try {
  //       final resp =
  //           await http.post(Uri.parse(url), headers: header, body: body);
  //       return resp;
  //     } on TimeoutException catch (e) {
  //       print(e);
  //       return messages.checkServer();
  //     } on SocketException catch (e) {
  //       print(e);
  //       return messages.checkServer();
  //     } catch (e) {
  //       print(e);
  //       return messages.refreshToken();
  //     }
  //   } else {
  //     return messages.checkInternet();
  //   }
  // }

  // Future verifyInternet(String url) async {

  //   try {
  //     final result = await InternetAddress.lookup(url);
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

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
    var header;
    headerAccess == 0
        ? header = await headerAccessToken()
        : header == headerJson;
    // ? header = headerJson
    // : headerAccess == messages.headerKeyCloak()
    //     ? header = await headerKeyCloak()
    //     : header = null;
    final verifyInternetGoogle = await verifyInternet();
    if (verifyInternetGoogle == true) {
      try {
        final resp =
            await http.post(Uri.parse(url), headers: header, body: body);
        return resp;
      } on TimeoutException catch (e) {
        print(e);

        return AuthenticationServerFailure;
      } on SocketException catch (e) {
        print(e);

        return AuthenticationServerFailure;
      } catch (e) {
        throw const SocketException.closed();
      }
    } else {
      return AuthenticationServerFailure;
    }
  }

  Future getHttp(String url, int headerAccess) async {
    var header;
    headerAccess == 0
        ? header = await headerAccessToken()
        : header == headerJson;
    final verifyInternetGoogle = await verifyInternet();
    if (verifyInternetGoogle == true) {
      try {
        final resp = await http.get(Uri.parse(url), headers: header);
        return resp;
      } on TimeoutException catch (e) {
        print(e);
        return AuthenticationServerFailure;
      } on SocketException catch (e) {
        print(e);
        return AuthenticationServerFailure;
      } catch (e) {
        print(e);
        throw SocketException.closed();
      }
    } else {
      return AuthenticationServerFailure;
    }
  }

  Future putHttp(String url, body, int headerAccess) async {
    var header;
   headerAccess == 0
        ? header = await headerAccessToken()
        : header == headerJson;
    final verifyInternetGoogle = await verifyInternet();
    if (verifyInternetGoogle == true) {
      try {
        final resp =
            await http.put(Uri.parse(url), headers: header, body: body);
        return resp;
      } on TimeoutException catch (e) {
        print(e);
        return AuthenticationServerFailure;
      } on SocketException catch (e) {
        print(e);
        return AuthenticationServerFailure;
      } catch (e) {
        print(e);
        throw SocketException.closed();
      }
    } else {
      return AuthenticationServerFailure;
    }
  }

/*
  Future uploadSingleFile(file, url, formData) async {
    var dio = Dio();
    var header = await headerAccessToken();
    final verifyInternetGoogle = await verifyInternet();
    if (verifyInternetGoogle == true) {
      try {
        dio.options.headers = header;
        dio.options.followRedirects = false;
        dio.options.validateStatus = (status) {
          return status < 500;
        };
        final resp = await dio.post(url, data: formData);
        return resp;
      } on TimeoutException catch (e) {
        print(e);
        return messages.checkServer();
      } on SocketException catch (e) {
        print(e);
        return messages.checkServer();
      } catch (e) {
        if (e.error == 'Http status error [401]') {
          return messages.refreshToken();
        } else {
          throw SocketException.closed();
        }
      }
    } else {
      return messages.checkInternet();
    }
  }
*/
  
  Future secureStorage(decodedData, jwtToken) async {
    // final accessToken = decodedData.accessToken;
    // final refreshToken = decodedData.refreshToken;
    // const String accessTokenKey = 'accessToken';
    // final String accessTokenValue = accessToken;
    // const String refreshTokenKey = 'refreshToken';
    // final String refreshTokenValue = refreshToken;
    // const String firstNameKey = 'firstName';
    // final String firstNameValue = jwtToken['given_name'];
    // const String firstLastNameKey = 'firstLastName';
    // final String firstLastNameValue = jwtToken['family_name'];
    // const String emailKey = 'email';
    // final String emailValue = jwtToken['email'];
    // const String photoKey = 'photo';
    // const String photoValue = '';
    // await _storage.write(key: accessTokenKey, value: accessTokenValue);
    // await _storage.write(key: refreshTokenKey, value: refreshTokenValue);
    // await _storage.write(key: firstNameKey, value: firstNameValue);
    // await _storage.write(key: firstLastNameKey, value: firstLastNameValue);
    // await _storage.write(key: emailKey, value: emailValue);
    // await _storage.write(key: photoKey, value: photoValue);
  }

  Map<String, dynamic> parseJwtPayLoad(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception(AuthenticationTokenExpire);
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception(AuthenticationTokenExpire);
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
