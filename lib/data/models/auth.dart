// 미사용 코드 혹시 몰라 나둠
import 'dart:convert';

import 'package:duckie_app/api/auth.dart';
import 'package:duckie_app/data/classes/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthModel extends ChangeNotifier {
  String errorMessage = "";
  bool _isKakaoTalkInstalled = false;

  User? _user;

  User? get user => _user;

  set user(User? user) {
    _user = user;
    print(_user.toString());
    notifyListeners();
  }

  getLoginedUser() async {
    final storage = FlutterSecureStorage();
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken != null) {
      String? refreshToken = await storage.read(key: 'refresh_token');
      String? username = await storage.read(key: 'username');
      String? picture = await storage.read(key: 'picture');

      return {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "username": username,
        "picture": picture,
      };
    } else {
      return null;
    }
  }

  getUserProfile() async {
    var path = '/auth/profile';

    try {
      var response = await apiGetUserProfile(header: null, path: path);
      print("get user profile data");
      print(response);
      response = response["data"];
      _user = User.fromJson(response);
      // notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}

  // Future<void> logout() async {
  //   // _user = null;
  //   notifyListeners();
  //   SharedPreferences.getInstance().then((prefs) {
  //     prefs.setString("user_data", null);
  //   });
  //   return;
  // }
