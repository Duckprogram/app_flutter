import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../utils/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    hide Options;

Future<dynamic> api_userRegisterInformation({header, String path}) async {
  var response = await http_get(header: header, path: path);

  var responseJson = json.decode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    print(responseJson);
    return responseJson;
  } else {
    var responseCode = _getResponseCode(responseJson);
    if (responseCode == null) throw Exception("Failed to HTTP GET");
    if (responseCode == -9999) {
      //이미 가입된 회원
      return responseJson;
    } else if (responseCode == -9998) {
      //만료된 Access Token
      print("만료된 Access Token");
      if (await _reissueAccessToken())
        return await http_get(header: header, path: path);
      else
        return responseJson;
    } else {
      throw Exception('Failed to HTTP GET(2)');
    }
  }
}

Future<dynamic> api_userRegisterCheck(
    {header, String path, Map<String, dynamic> body}) async {
  var response = await http_post(header: header, path: path, body: body);
  String expiredTokenUrl = BACK_END_HOST + "exception/expiredtoken";

  print(response.headers['location'].toString());
  if (response.body.isNotEmpty && response.statusCode == 200) {
    //Response가 비어있지 않고 정상응답인 경우
    var responseJson = json.decode(utf8.decode(response.bodyBytes));
    print(responseJson);
    return responseJson;
  } else if (!response.body.isNotEmpty &&
      response.statusCode == 302 &&
      response.headers['location'].toString() == expiredTokenUrl) {
    // HTTP 라이브러리에서 HTTP POST가 redirect 되는 경우 302 응답을 받음(Postman이나 Swagger에서는 발생하지 않는 문제)
    // 302 응답을 받는 경우 response body는 비어있어서 URL과 응답코드로 액세스 토큰 만료 여부를 판단
    if (await _reissueAccessToken()) {
      //AccessToken 재발급
      return await http_post(
          header: header, path: path, body: body); //HTTP POST 재시도
    }
  } else {
    var responseJson = json.decode(utf8.decode(response.bodyBytes));
    print(responseJson);
    var responseCode = _getResponseCode(responseJson);
    if (responseCode == null) throw Exception("Failed to HTTP POST");
    if (responseCode == -9999) {
      //이미 가입된 회원
      return responseJson;
    } else if (responseCode == -9997) {
      //TODO 만료된 Refresh Token(아예 로그아웃 처리)
      return responseJson;
    } else {
      throw Exception("Failed to HTTP POST(2)");
    }
  }
}

dynamic _getResponseCode(dynamic responseJson) {
  var responseCode = responseJson['code'];
  if (responseCode != null) {
    return responseCode;
  } else {
    return null;
  }
}

// 혹시 몰라 token issue 추가
Future<bool> _reissueAccessToken() async {
  final storage = FlutterSecureStorage();
  String accessToken = await storage.read(key: 'access_token');
  String refreshToken = await storage.read(key: 'refresh_token');

  var url = BACK_END_HOST + 'api/token/refreshrefreshToken=' + refreshToken;

  print(url);

  var response;

  try {
    response = await http.get(
      Uri.parse(Uri.encodeFull(url)),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer " + accessToken
      },
    );

    var responseJson = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      print(responseJson);
      await storage.write(
          key: "access_token", value: responseJson['data']['access_token']);
      return true;
    } else {
      return false;
    }
  } catch (ex) {
    print(ex);
    return false;
  }
}
