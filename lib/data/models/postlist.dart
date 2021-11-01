// 미사용 코드 혹시 몰라 나둠
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../classes/Postitem.dart';
import '../../api/postitem.dart';
import '../../common/type.dart';

class PostListModel extends ChangeNotifier {
  String errorMessage = "";

  int _no = 0;

  List<Postitem>? _postlist;

  int? get no => _no;

  set no(int? no) {
    _no = no!;
    notifyListeners();
  }

  List<Postitem>? get postlist => _postlist;

  set postlist(List<Postitem>? postlist) {
    _postlist = postlist;
    notifyListeners();
  }

  getPostList() async {
    var home = '/channels/' + _no.toString() + '/posts?';
    final queryParameters = {
      'category': 'one',
    };
    var path = home + Uri(queryParameters: queryParameters).query;
    try {
      var response = await api_PostlList(header: null, path: path);
      _postlist =
          List<Postitem>.from(response.map((json) => Postitem.fromJson(json)));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
