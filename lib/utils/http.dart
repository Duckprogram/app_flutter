import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    hide Options;

//TO-DO
//추후 API 추가 진행
//postman url

var BACK_END_HOST =
    'https://b4ffd983-ca34-4d5b-ae84-b1db3a438d56.mock.pstmn.io';

Future<dynamic> http_get({header, String? path}) async {
  final storage = FlutterSecureStorage();
  String? jwt = await storage.read(key: 'access_token');

  var url = BACK_END_HOST + path!;

  print('JWT $jwt');
  print(BACK_END_HOST + path);

  var response;

  try {
    response = await http.get(Uri.parse(Uri.encodeFull(url)), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer " + jwt!
    });

    return response;
  } catch (ex) {
    print(ex);
    debugPrint("http.post().exception: " +
        ex.toString() +
        ', statusCode:' +
        response.statusCode.toString() +
        ', url:' +
        url);
    return response;
  }
}

Future<dynamic> http_post(
    {header, String? path, Map<String, dynamic>? body}) async {
  final storage = FlutterSecureStorage();
  String? jwt = await storage.read(key: 'access_token');

  print(BACK_END_HOST + path!);
  print('JWT $jwt');

  var url = BACK_END_HOST + path;

  var response;

  try {
    if (jwt == null) {
      print("jwt 없음");
      response = await http.post(
        Uri.parse(Uri.encodeFull(url)),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          //Authorization 헤더가 있는 경우 Spring Security에서 무조건 검증하기 때문에 포함하면 안됨
          //signin, signup할 때 post사용하므로 꼭 필요한 코드
        },
        body: convert.jsonEncode(body),
      );
    } else {
      response = await http.post(
        Uri.parse(Uri.encodeFull(url)),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer " + jwt,
        },
        body: convert.jsonEncode(body),
      );
    }
    print("post 전송 진행");
    print(Uri.parse(Uri.encodeFull(url)));
    return response;
  } catch (ex) {
    print(ex);
    debugPrint("http.post().exception: " +
        ex.toString() +
        ', statusCode:' +
        response.statusCode.toString() +
        ', url:' +
        url);
    return response;
  }
}

// 추가 구현 필요
Future<dynamic> http_delete(url, path, header) async {
  final storage = FlutterSecureStorage();
  String? jwt = await storage.read(key: 'access_token');

  print(BACK_END_HOST + path);
}

Future<List<String>> getUserRoles() async {
  var response = await http_get(header: null, path: 'api/user');

  print(response);

  final res = (response['data']['user']['roles'] as List)
      .map((e) => e as String)
      .toList();

  return res;
}

// Future<String> getNickname() async {
//   var response = await http_get(header: null, path: 'api/user');

//   print(response['data']['profile']['uspNickname']);

//   return response['data']['profile']['uspNickname'];
// }
