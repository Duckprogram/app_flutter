// 미사용 코드 혹시 몰라 나둠
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/channel.dart';

class AuthModel extends ChangeNotifier {
  String errorMessage = "";

  Channel _channel;

  Channel get channel => _channel;

  set channel(Channel channel) {
    _channel = channel;
    print(_channel.toString());
    notifyListeners();
  }
}
