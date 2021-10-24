// 미사용 코드 혹시 몰라 나둠
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../classes/channel.dart';

class ChannelListModel extends ChangeNotifier {
  String errorMessage = "";

  late List<Channel> _channellist;
  late List<Channel> _mychannellist;

  List<Channel> get channellist => _channellist;

  set channellist(List<Channel> channellist) {
    _channellist = channellist;
    print(_channellist.toString());
    notifyListeners();
  }

  List<Channel> get mychannellist => _mychannellist;

  set mychannellist(List<Channel> mychannellist) {
    _mychannellist = _mychannellist;
    print(_mychannellist.toString());
    notifyListeners();
  }

}
