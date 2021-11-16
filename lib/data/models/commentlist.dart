// 미사용 코드 혹시 몰라 나둠
import 'dart:convert';

import 'package:duckie_app/api/commentlist.dart';
import 'package:duckie_app/data/classes/comment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../classes/postitem.dart';
import '../../api/postitem.dart';
import '../../common/type.dart';

class CommentListModel extends ChangeNotifier {
  String errorMessage = "";

  int _post_id = 0;

  List<Commentitem>? _commentlist;

  int? get post_id => _post_id;

  set post_id(int? post_id) {
    _post_id = post_id!;
    notifyListeners();
  }

  List<Commentitem>? get commentlist => _commentlist;

  set commentlist(List<Commentitem>? commentlist) {
    _commentlist = commentlist;
    notifyListeners();
  }

  getCommentList() async {
    var path = '/post/' + _post_id.toString() + '/comment';
    try {
      var response = await api_CommentlList(header: null, path: path);
      response = response["data"]["content"];
      _commentlist = List<Commentitem>.from(
          response.map((json) => Commentitem.fromJson(json)));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  postCommentWrite(String comment, int id) async {
    var path = '/post/' + _post_id.toString() + '/comment';
    var body = {
      'comment': comment,
      'post': {'id': id}
    };
    try {
      var response =
          await api_postCommentWrite(header: null, path: path, body: body);
      print("댓글 정상여부" + response.toString());
      // _commentlist =
      //     List<Commentitem>.from(response.map((json) => Commentitem.fromJson(json)));
      // notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
