// 미사용 코드 혹시 몰라 나둠
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../classes/postitem.dart';
import '../../api/postitem.dart';
import '../../common/type.dart';

class PostCafeListModel extends ChangeNotifier {
  String errorMessage = "";

  int _no = 0;

  List<Postitem>? _postnormallist;
  List<Postitem>? _postmarketlist;

  int? get no => _no;

  set no(int? no) {
    _no = no!;
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

  getPostNormalList() async {
    var home = '/channels/' + _no.toString() + '/posts';
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
    var home = '/channels/' + _no.toString() + '/posts';
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
