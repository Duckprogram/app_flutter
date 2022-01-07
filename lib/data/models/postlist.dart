// 미사용 코드 혹시 몰라 나둠
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../classes/postitem.dart';
import '../../api/postitem.dart';
import '../../common/type.dart';
import 'package:collection/collection.dart';

enum LoadMoreStatus { LOADING, STABLE }

class PostListModel extends ChangeNotifier {
  String errorMessage = "";

  int _channel_id = 1;

  int postTotalPage = 0;
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
    try {
      var path = '/channels/' + _channel_id.toString() + '/posts?';
      print("path  " + path + " " + postTotalPage.toString());
      var queryParameters = {
        'category': 'all',
        'page': postTotalPage.toString(),
      };
      path = path + Uri(queryParameters: queryParameters).query;

      var response = await api_getPostlList(header: null, path: path);
      var res_data = response['data']["content"];
      print("response");
      print(response);
      print(postTotalPage.toString() +
          " 비교 " +
          response["data"]["totalPages"].toString());

      if (res_data != null && postTotalPage != response["data"]["totalPages"]) {
        var newPostlist = List<Postitem>.from(
            res_data.map((json) => Postitem.fromJson(json)));
        if (_postlist == null) {
          _postlist = newPostlist;
          if (newPostlist.length == 5) {
            ++postTotalPage;
          }
          notifyListeners();
        } else {
          if (ListEquality().equals([
                _postlist!
                    .sublist( _postlist!.length - newPostlist.length < 0 ? 0 : _postlist!.length - newPostlist.length )
                    .toString()
              ], [
                newPostlist.toString()
              ]) ==
              false) {
            // postlist 신규 생성시 기존 5페이지 이하 list 제거 후 추가 list 적재
            _postlist!.removeRange(
                _postlist!.length - _postlist!.length % 5, _postlist!.length);
            _postlist!.addAll(newPostlist);
            setLoadingState(LoadMoreStatus.STABLE);
            if (newPostlist.length == 5) {
              ++postTotalPage;
            }
            notifyListeners();
          }
        }
      }
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
