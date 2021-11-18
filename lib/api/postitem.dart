import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../utils/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    hide Options;



Future<dynamic> api_getPostlList({header, required String path}) async {
  var response = await http_get(header: header, path : path);

  var responseJson = json.decode(utf8.decode(response.bodyBytes));
  responseJson = responseJson['data']['content'];
  if (response.statusCode == 200) {
    print(responseJson);
    return responseJson;
  } else{
    throw Exception('Failed to HTTP GET Channellist');
  }
}


Future<dynamic> api_postPost({header, required String path, required Map<String, dynamic> body}) async {
  var response = await http_post(header: header, path: path, body: body);

  var responseJson = json.decode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    print(responseJson);
    return responseJson;
  } else{
    throw Exception("Failed to HTTP POST(2)");
  }
}