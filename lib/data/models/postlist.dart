// 미사용 코드 혹시 몰라 나둠
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../classes/postitem.dart';
import '../../api/postitem.dart';
import '../../common/type.dart';

enum LoadMoreStatus { LOADING, STABLE }

class PostListModel extends ChangeNotifier {
  String errorMessage = "";

  int _channel_id = 0;

  int postTotalPage = 1;
  bool postPageLast = false;

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

  List<Postitem>? _postlist;
  List<Postitem>? _postnormallist;
  List<Postitem>? _postmarketlist;

  int? get channel_id => _channel_id;

  set channel_id(int? channel_id) {
    _channel_id = channel_id!;
    notifyListeners();
  }

  List<Postitem>? get postlist => _postlist;

  set postlist(List<Postitem>? postlist) {
    _postlist = postlist;
    notifyListeners();
  }

  List<Postitem>? get postnormallist => _postnormallist;

  set postnormallist(List<Postitem>? postnormallist) {
    _postnormallist = postnormallist;
    notifyListeners();
  }

  List<Postitem>? get postmarketlist => _postmarketlist;

  set postmarketlist(List<Postitem>? postmarketlist) {
    _postmarketlist = postmarketlist;
    notifyListeners();
  }

  getPostList() async {
    var path = '/channels/' + _channel_id.toString() + '/posts?';
    final queryParameters = {
      'category': 'all',
      'page': postTotalPage.toString(),
    };
    path = path + Uri(queryParameters: queryParameters).query;
    try {
      var response = await api_getPostlList(header: null, path: path);
      var res_data = response['data']["content"];
      print(postTotalPage.toString() +
          " 비교 " +
          response["data"]["totalPages"].toString());
      if (res_data != null &&
          postTotalPage != response["data"]["totalPages"]) {
        var newpostlist =
            List<Postitem>.from(res_data.map((json) => Postitem.fromJson(json)));
        if (_postlist == null) {
          _postlist = newpostlist;
        } else {
          _postlist!.addAll(newpostlist);
          setLoadingState(LoadMoreStatus.STABLE);
        }
        ++postTotalPage;
        notifyListeners();
      }
      // var response = await api_getPostlList(header: null, path: path);
      // _postlist =
      //     List<Postitem>.from(response.map((json) => Postitem.fromJson(json)));
      // notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getPostNormalList() async {
    var home = '/channels/' + _channel_id.toString() + '/posts?';
    final queryParameters = {
      'category': 'normal',
    };
    var path = home + Uri(queryParameters: queryParameters).query;
    try {
      var response = await api_getPostlList(header: null, path: path);
      _postnormallist =
          List<Postitem>.from(response.map((json) => Postitem.fromJson(json)));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getPostMarketList() async {
    var home = '/channels/' + _channel_id.toString() + '/posts?';
    final queryParameters = {
      'category': 'market',
    };
    var path = home + Uri(queryParameters: queryParameters).query;
    try {
      var response = await api_getPostlList(header: null, path: path);
      _postmarketlist =
          List<Postitem>.from(response.map((json) => Postitem.fromJson(json)));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
