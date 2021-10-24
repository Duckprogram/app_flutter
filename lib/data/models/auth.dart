// 미사용 코드 혹시 몰라 나둠
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kakao_flutter_sdk/user.dart';

class AuthModel extends ChangeNotifier {
  String errorMessage = "";
  bool _isKakaoTalkInstalled = false;

  late User _user;

  User get user => _user;

  set user(User user) {
    _user = user;
    print(_user.toString());
    notifyListeners();
  }

  Future<void> logout() async {
    // _user = null;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("user_data", null);
    });
    return;
  }
}
