import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    hide Options;

var BACK_END_HOST =
    'https://621b7c0e-4c1b-4ef3-ae88-814814c0c06e.mock.pstmn.io';

// var BACK_END_HOST =
//     'https://1b4bc78c-8c0f-4944-a114-a34b8223d2e9.mock.pstmn.io';
// var BACK_END_HOST = 'http://133.186.251.46';

var IMAGE_PUT_URL =
    'https://api-image.cloud.toast.com/image/v2.0/appkeys/tUtVzC4V8dqjKqtP/images';

var IMAGE_SECRET_KEY = '4qjSFP9z';

Future<dynamic> http_get({header, String? path}) async {
  final storage = FlutterSecureStorage();
  String? jwt = await storage.read(key: 'accessToken');

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
    debugPrint("http.get().exception: " +
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
  String? jwt = await storage.read(key: 'accessToken');

  print(BACK_END_HOST + path!);
  print('JWT $jwt');
  print(body);
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
    print(response);
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
  String? jwt = await storage.read(key: 'accessToken');

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

Future<dynamic> http_image_get({required String path}) async {
  var url = path;
  var response;
  try {
    response = await http.get(Uri.parse(Uri.encodeFull(url)));
    return response;
  } catch (ex) {
    print(ex);
    debugPrint("http_image_get().exception: " +
        ex.toString() +
        ', statusCode:' +
        response.statusCode.toString() +
        ', url:' +
        url);
    return response;
  }
}

Future<dynamic> http_image_put(
    {required String role,
    required String id,
    required List<String> image_files}) async {

 /*
  {
    "header": {
        // 생략
    },
    "file": {
        "isFolder": false,
        "id": "9cf11176-045c-4708-8dbd-35633f029a91",
        "url": "http://image.toast.com/aaaaach/myfolder/sample.png",
        "name": "sample.png",
        "path": "/myfolder/sample.png",
        "bytes": 54684,
        "createdBy": "U",
        "updatedAt": "2016-02-26T16:38:34+0900",
        "operationId": "100x100",
        "imageProperty": {
            "width": 200,
            "height": 150,
            "createdAt": "2016-02-26T16:38:11+0900",
            "coordinate": {
                "lat": null,
                "lng": null
            }
        },
        "queues": [
            "queueId": "0256316c-7dcf-4940-975b-673afb62e8a3",
            "queueType": "image",
            "status": "W",
            "tryCount": 0,
            "queuedAt": "2016-02-26T16:38:11+0900",
            "operationId": "100x100",
            "url": "http://image.toast.com/aaaaach/myfolder/sample_100x100.png",
            "name": "sample_100x100.png",
            "path": "/myfolder/sample_100x100.png"
        ],
    }
  }
  이미지 전송 결과로 response["file"]["queues"]["url"] 를 받아서 저장.. 
  아직 다중 파일 저장 방법 개발 미흡.. 
  
*/
  print(IMAGE_PUT_URL);
  var url = IMAGE_PUT_URL;

  //nhn클라우드 특성상 길이가 무조건 2이상이어야한다. 따라서 00001 이런식으로 폴더를 생성하게 만들었다.
  id = id.padLeft(5, '0');
  if (image_files.length == 1) {
    var querypath =
        'path=/' + role + '/' + id + '/' + image_files[0].split('/').last;
    print(querypath);
    final queryParameters = {
      'overwrite': 'true',
    };
    var path = url +
        '?' +
        querypath +
        '&' +
        Uri(queryParameters: queryParameters).query;
    var response;
    try {
      response = await http.put(
        Uri.parse(Uri.encodeFull(path)),
        headers: {
          "Content-Type": "application/octet-stream",
          "Authorization": IMAGE_SECRET_KEY,
          "Accept": "*/*",
          "Connection": 'keep-alive',
        },
        body: File(image_files[0]).readAsBytesSync(),
      );
      print(File(image_files[0]).readAsBytesSync().toString());
      print("image put 전송 진행");
      print(Uri.parse(Uri.encodeFull(path)));
      print("결과" + response.body.toString() + response.statusCode.toString());
      return response;
    } catch (ex) {
      print(ex);
      debugPrint("http_image_put.exception: " +
          ex.toString() +
          ', statusCode:' +
          response.statusCode.toString() +
          ', url:' +
          url);
      return response;
    }
  } else {
    var path = Uri.parse(url);
    var response;
    var headers = {
      "Authorization": IMAGE_SECRET_KEY,
    };
    try {
      // var request = new http.MultipartRequest('POST', path)
      //   ..headers.addAll(headers)
      //   ..fields['params.basepath'] = '/' + role + '/' + id
      //   ..fields['params.overwrite'] = 'true';

      // for (var image_file in image_files) {
      //   request.files
      //       .add(await http.MultipartFile.fromPath('files', image_file));
      // }
      // var response = await request.send();

      final formData = dio.FormData.fromMap({
        'params': {
          'overwrite': 'true',
          'basepath': '/' + role + '/' + id,
        },
        'files':
        [ await dio.MultipartFile.fromFile(image_files[0]) ,  await dio.MultipartFile.fromFile(image_files[1])]
        // [
        //   dio.MultipartFile.fromFileSync(image_files[0],
        //       filename: "1.png"),
        //   dio.MultipartFile.fromFileSync(image_files[1],
        //       filename: "2.png"),
        // ]
      });

      final response = await dio.Dio().post(
        url,
        data: formData,
        options: dio.Options(headers: headers),
      );

      print("image post 전송 진행");
      print(Uri.parse(Uri.encodeFull(url)));
      print(response.headers);
      // print(response.toString() + response.statusCode.toString());
      // response.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      return response;
    } catch (ex) {
      print(ex);
      debugPrint("http_image_put.exception: " +
          ex.toString() +
          ', statusCode:' +
          response.statusMessage.toString() +
          ', url:' +
          url);
      return response;
    }
  }
}
