import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../utils/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    hide Options;

Future<dynamic> api_getChannelList({header, required String path}) async {
  var response = await http_get(header: header, path: path);
  var responseJson = json.decode(utf8.decode(response.bodyBytes));
  if (response.statusCode == 200) {
    print( "getChannelList" + responseJson);
    return responseJson;
  } else {
    throw Exception('Failed to HTTP GET Channellist');
  }
}

Future<dynamic> api_getMyChannelList({header, required String path}) async {
  var response = await http_get(header: header, path: path);
  var responseJson = json.decode(utf8.decode(response.bodyBytes));
  if (response.statusCode == 200) {
    print( "getMyChannelList" + responseJson);
    return responseJson;
  } else {
    throw Exception('Failed to HTTP GET MyChannel');
  }
}

Future<dynamic> api_getChannel({header, required String path}) async {
  var response = await http_get(header: header, path: path);
  var responseJson = json.decode(utf8.decode(response.bodyBytes));
  if (response.statusCode == 200) {
    return responseJson;
  } else {
    throw Exception('Failed to HTTP GET Channel');
  }
}
