// 미사용 코드 혹시 몰라 나둠
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../classes/channel.dart';
import '../../api/channel.dart';
import '../../common/type.dart';

enum LoadMoreStatus { LOADING, STABLE }

class ChannelListModel extends ChangeNotifier {
  String errorMessage = "";

  //infinite scroll 구현을 위해 추가 코드
  int ChannelTotalPage = 1;
  bool ChannelPageLast = false;

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

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

  getChannel(int id) async {
    var path = '/channels/$id/info/detail';
    try {
      var response = await api_getChannel(header: null, path: path);
      print("getchannel 가져오기" + response);
      response = response['data'];
      _channel = Channel.fromJson(response);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getChannelList() async {
    var path = '/channels?';
    final queryParameters = {
      'page': ChannelTotalPage.toString(),
    };
    path = path + Uri(queryParameters: queryParameters).query;
    try {
      var response = await api_getChannelList(header: null, path: path);
      var res_data = response['data']["content"];
      // ChannelPageLast = response["data"]["totalPages"];
      print(ChannelTotalPage.toString() +
          " 비교 " +
          response["data"]["totalPages"].toString());
      if (res_data != null &&
          ChannelTotalPage != response["data"]["totalPages"]) {
        var newChannellist =
            List<Channel>.from(res_data.map((json) => Channel.fromJson(json)));
        if (_channellist == null) {
          _channellist = newChannellist;
        } else {
          _channellist!.addAll(newChannellist);
          setLoadingState(LoadMoreStatus.STABLE);
        }
        ++ChannelTotalPage;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  getMyChannelList() async {
    // final queryParameters = {
    //   'param1': 'one',
    //   'param2': 'two',
    // };
    // var path = '/channels/my?' + Uri(queryParameters: queryParameters).query;
    try {
      var path = '/auth/registered';
      var response = await api_getMyChannelList(header: null, path: path);
      var res_data = response['data'];
      path = '/auth/created';
      response = await api_getMyChannelList(header: null, path: path);
      res_data.addAll(response['data']);
      _mychannellist =
          List<Channel>.from(response.map((json) => Channel.fromJson(json)));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
