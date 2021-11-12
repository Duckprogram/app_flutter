import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/type.dart';
import '../../styles/styles.dart';
import '../../data/models/postlist.dart';
import '../../data/classes/postitem.dart';
import '../../data/models/channellist.dart';
import '../../data/classes/channel.dart';
import 'postcomment.dart';
//list 비교 함수
import 'package:collection/collection.dart';

class PostComment extends StatefulWidget {
  PostComment({Key? key, required this.postitem}) : super(key: key);
  final Postitem postitem;
  @override
  _PostCommentState createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  late final Postitem _postitem;
  // late Channel _channel;

  @override
  void initState() {
    _postitem = widget.postitem;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBarSection = AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        "댓글",
        style: h4,
      ),
      backgroundColor: gray08,
    );
    Widget titleSection = Container(
        padding: EdgeInsets.only(left: 25, top: 15),
        child: Text(
          _postitem.title.toString(),
          style: h2,
        ));


    Widget CommentNavigation = Container(
      padding: EdgeInsets.only(left: 25, top : 20, right : 25 ),
      child : Row( 
        mainAxisAlignment : MainAxisAlignment.start,
        crossAxisAlignment : CrossAxisAlignment.start,
        children: [
           GestureDetector(
              child: Text("최신순", style : body2Gray03),
           ),
          Text(" | ", style : body1Bold),
          GestureDetector(
              child: Text("오래된 순", style : body2Gray03),
          ) 
        ],
      )
    );

    Widget commentlist = Container(
      padding: EdgeInsets.only(left: 25, top: 15),
      // padding: flex,
      // child: ListView.builder(
      //     shrinkWrap: true,
      //     physics: AlwaysScrollableScrollPhysics(),
      //     itemCount: postitemlist?.length ?? 0,
      //     padding: const EdgeInsets.all(6.0),
      //     itemBuilder: (context, index) => ListTile(
      //           shape: RoundedRectangleBorder(
      //               side: BorderSide(color: Colors.grey, width: 0.5),
      //               borderRadius: BorderRadius.circular(5)),
      //           title: Text(postitemlist![index].title.toString() +
      //               postitemlist[index].username.toString() +
      //               postitemlist[index].views.toString()),
      //           minVerticalPadding: 50,
      //         ))
      //   );
    );

    return Scaffold(
        appBar: appBarSection,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommentNavigation,
            commentlist
          ],
        ));
  }
}
