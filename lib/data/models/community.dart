import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../classes/postitem.dart';
import '../../api/postitem.dart';

class CommunityListModel extends ChangeNotifier {
  String errorMessage = "";

  List<Postitem>? _postlist;
  List<Postitem>? get postlist => _postlist;

  set postList(List<Postitem>? postlist) {
    _postlist = postlist;
    notifyListeners();
  }

  getPostListByTitle(text) async {
    var path = '/community/search?title=$text';
    try {
      var response = await api_PostlList(header: null, path: path);
      _postlist =
          List<Postitem>.from(response.map((json) => Postitem.fromJson(json)));
      notifyListeners();
      return _postlist;
    } catch (e) {
      print(e);
    }
  }

  getCommunityPosts() async {
    var path = '/community';
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
