// 미사용 코드 혹시 몰라 나둠
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../classes/channel.dart';
import '../../api/channel.dart';
import '../../common/type.dart';
import 'package:collection/collection.dart';

enum LoadMoreStatus { LOADING, STABLE }

class ChannelListModel extends ChangeNotifier {
  String errorMessage = "";

  //infinite scroll 구현을 위해 추가 코드
  int ChannelTotalPage = 0;
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
    try {
      var path = '/channels?';
      final queryParameters = {
        'page': ChannelTotalPage.toString(),
      };
      path = path + Uri(queryParameters: queryParameters).query;
      var response = await api_getChannelList(header: null, path: path);
      var res_data = response['data']["content"];

      print("path" + path);
      // ChannelPageLast = response["data"]["totalPages"];
      print(ChannelTotalPage.toString() +
          " 비교 " +
          response["data"]["totalPages"].toString());
      if (res_data != null &&
          ChannelTotalPage != response["data"]["totalPages"]) {
        var newChannellist =
            List<Channel>.from(res_data.map((json) => Channel.fromJson(json)));
        print("newlist" + newChannellist.toString());
        if (_channellist == null) {
          _channellist = newChannellist;
          if (newChannellist!.length == 5) {
            ++ChannelTotalPage;
          }
        } else {
          print("sublist");
          print(_channellist!
              .sublist(_channellist!.length - newChannellist.length));
          if (ListEquality().equals([
                _channellist!
                    .sublist(_channellist!.length - newChannellist.length)
                    .toString()
              ], [
                newChannellist.toString()
              ]) ==
              false) {
            // _channellist 신규 생성시 기존 5페이지 이하 list 제거 후 추가 list 적재 
            _channellist!.removeRange(
                _channellist!.length - _channellist!.length % 5, _channellist!.length);
            _channellist!.addAll(newChannellist);
            if (newChannellist!.length == 5) {
              ++ChannelTotalPage;
            }
            setLoadingState(LoadMoreStatus.STABLE);
          }
        }
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  getMyChannelList() async {
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
