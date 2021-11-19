// 미사용 코드 혹시 몰라 나둠
import 'dart:convert';

import 'package:duckie_app/api/commentlist.dart';
import 'package:duckie_app/data/classes/comment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../classes/postitem.dart';
import '../../api/postitem.dart';
import '../../common/type.dart';

enum LoadMoreStatus { LOADING, STABLE }

class CommentListModel extends ChangeNotifier {
  String errorMessage = "";

  int _post_id = 0;

  int  CommentTotalPage = 1;
  bool CommentPageLast = false;

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

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
    var path = '/post/' + _post_id.toString() + '/comment?';
    final queryParameters = {
      'page': CommentTotalPage.toString(),
    };
    path = path + Uri(queryParameters: queryParameters).query;
    try {
      var response = await api_CommentlList(header: null, path: path);
      var res_data = response['data']["content"];
      print(CommentTotalPage.toString() +
          " 비교 " +
          response["data"]["totalPages"].toString());
      if (res_data != null &&
          CommentTotalPage != response["data"]["totalPages"]) {
        var newCommentlist =
            List<Commentitem>.from(res_data.map((json) => Commentitem.fromJson(json)));
        if (_commentlist == null) {
          _commentlist = newCommentlist;
        } else {
          _commentlist!.addAll(newCommentlist);
          setLoadingState(LoadMoreStatus.STABLE);
        }
        ++CommentTotalPage;
        notifyListeners();
      }
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
    } catch (e) {
      print(e);
    }
  }
}
