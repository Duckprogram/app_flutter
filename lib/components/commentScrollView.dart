import 'package:duckie_app/components/Icons.dart';
import 'package:duckie_app/data/classes/channel.dart';
import 'package:duckie_app/data/classes/comment.dart';
import 'package:duckie_app/data/classes/postitem.dart';
import 'package:duckie_app/data/models/commentlist.dart';
import 'package:duckie_app/styles/styles.dart';
import 'package:duckie_app/ui/post/posthome.dart';
import 'package:duckie_app/utils/utils.dart';
import 'package:flutter/material.dart';

Widget CommentScrollListView(CommentListModel? commentlistmodel, bool? iscommentlist) {

  final list = commentlistmodel!.commentlist;

  ScrollController _scrollController = new ScrollController();

  commentlistmodel.getCommentList();
  _scrollController.addListener(() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      commentlistmodel.setLoadingState(LoadMoreStatus.LOADING);
      commentlistmodel.getCommentList();
    }
  });

  if (list == null || list.length == 0) {
    return Container(
        padding: EdgeInsets.only(top: 15), child: Text("댓글을 달아보세요"));
  }

  CommentDelete() {
    final snackBar = SnackBar(content: Text('해당 댓글을 삭제 하시겠습니까?'));
  }

  return SingleChildScrollView(
      padding: EdgeInsets.only(left: 12, top: 12, right: 12),
      child: Column(children: <Widget>[
        ListView.builder(
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true, 
          itemCount: iscommentlist == true ? list.length : list.length > 4 ? 4 : list.length ,
          itemBuilder: (context, position) {
            return GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: gray08,
                        width: 0.8,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 25.0,
                        height: 25.0,
                        // margin: EdgeInsets.only(right: 8),
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: getImageOrBasic(
                                        list[position].user_picture)
                                    .image)),
                      ),
                      Padding(padding: EdgeInsets.all( 8)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 6, bottom: 2),
                                child: Text(
                                    list[position].user_name.toString(),
                                    style: body1),
                              ),
                              list[position].writtenBy_yn == true
                                  ? Text(
                                      "작성자",
                                      style: body1BoldPrimary,
                                    )
                                  : Container(),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 6, bottom: 2),
                            child: Text(
                              list[position].comment!.toString(),
                              style: body2Gray04,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 6, bottom: 2),
                            child: Text(
                              list[position].create_date!.toString(),
                              style: captionGray03,
                            ),
                          ),
                        ],
                      ),
                      // ClipRRect(
                      //     borderRadius: BorderRadius.circular(5),
                      //     child: getImageOrBasic(commentList[position].user_picture)),
                    ],
                  ),
                ),
                onTap: () => {iscommentlist == true ? CommentDelete() : {}});
          },
        )
      ]));
}
