import 'package:duckie_app/components/Icons.dart';
import 'package:duckie_app/ui/post/commentList.dart';
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
      shape: Border(bottom: BorderSide(color: gray07, width: 1)),
      backgroundColor: white,
      foregroundColor: gray01,
      elevation: 0.1,
      title: Text(
        "댓글",
        style: body2Bold,
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
            icon: iconImageSmall("close", 24.0),
            onPressed: () => Navigator.of(context).pop()),
      ],
    );
    Widget commentNavigation = Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BorderBottom,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Text("최신순", style: body2Bold),
            ),
            Text(" | ", style: body1Bold),
            GestureDetector(
              child: Text("오래된 순", style: body2BoldGray3),
            )
          ],
        ));

    return Scaffold(
        appBar: appBarSection,
        backgroundColor: white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commentNavigation,
            SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: commentlist)
          ],
        ));
  }
}
