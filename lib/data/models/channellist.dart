// 미사용 코드 혹시 몰라 나둠
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../classes/channel.dart';
import '../../api/channel.dart';
import '../../common/type.dart';

class ChannelListModel extends ChangeNotifier {
  String errorMessage = "";

  List<Channel>? _channellist;
  List<Channel>? _mychannellist;
  Channel? _channel;

  List<Channel>? get channellist => _channellist;
  Channel? get channel => _channel;

  set channellist(List<Channel>? channellist) {
    _channellist = channellist;
    notifyListeners();
  }

  List<Channel>? get mychannellist => _mychannellist;

  set mychannellist(List<Channel>? mychannellist) {
    _mychannellist = _mychannellist;
    print(_mychannellist.toString());
    notifyListeners();
  }

  getChannelList() async {
    var path = '/channels';
    try {
      var response = await api_ChannelList(header: null, path: path);
      _channellist =
          List<Channel>.from(response.map((json) => Channel.fromJson(json)));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getChannel(int id) async {
    var path = '/channels/$id/info/detail';
    try {
      var response = await apiGetChannel(header: null, path: path);
      _channel = Channel.fromJson(response);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getMyChannelList() async {
    // final queryParameters = {
    //   'param1': 'one',
    //   'param2': 'two',
    // };
    var path = '/user/channels';
    // var path = '/channels/my?' + Uri(queryParameters: queryParameters).query;

    print(path);
    try {
      var response = await api_MyChannelList(header: null, path: path);
      _mychannellist =
          List<Channel>.from(response.map((json) => Channel.fromJson(json)));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
