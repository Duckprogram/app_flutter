import 'package:duckie_app/components/Icons.dart';
import 'package:duckie_app/components/commentScrollView.dart';
import 'package:duckie_app/data/models/auth.dart';
import 'package:duckie_app/data/models/commentlist.dart';
import 'package:duckie_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../styles/styles.dart';
import '../../data/classes/postitem.dart';
import '../../data/classes/channel.dart';
import 'post_comment.dart';
//list 비교 함수

class PostHome extends StatefulWidget {
  PostHome({Key? key, required this.postitem, required this.channel})
      : super(key: key);
  final Postitem postitem;
  final Channel channel;
  @override
  _PostHomeState createState() => _PostHomeState();
}

class _PostHomeState extends State<PostHome> {
  late final Postitem _postitem;
  late Channel _channel;
  final CommentListModel _commentlist = CommentListModel();
  bool _isLoadedComment = false;

  @override
  void initState() {
    _postitem = widget.postitem;
    _channel = widget.channel;
    _commentlist.post_id = _postitem.id;
    _commentlist.getCommentList().then((_) => {
          setState(() {
            _isLoadedComment = true;
          })
        });

    super.initState();
    print(_postitem.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _movePostComment() {
    return Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<CommentListModel>.value(
            value: _commentlist, child: PostComment(postitem: _postitem))));
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBarSection = AppBar(
      shape: Border(bottom: BorderSide(color: gray07, width: 1)),
      backgroundColor: white,
      foregroundColor: gray01,
      elevation: 0.1,
      leading: IconButton(
        icon: iconImageSmall("back", 24.0),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        _channel.name.toString(),
        style: body2Bold,
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: iconImageSmall("more", 24.0),
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('옵션 팝업')));
          },
        ),
      ],
    );
    Widget titleSection = Container(
        padding: EdgeInsets.only(top: 24, bottom: 16),
        child: Text(
          _postitem.title.toString(),
          style: h2,
        ));
    Widget writerSection = Container(
      decoration: BorderBottom,
      padding: EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            margin: EdgeInsets.only(right: 8),
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: getImageOrBasic(_postitem.userImage).image)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_postitem.user_name.toString(), style: body1),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 6, bottom: 2),
                    child: Text(
                      getCreatedDateStr(_postitem.create_date!),
                      style: captionGray03,
                    ),
                  ),
                  Text(" 조회 " + _postitem.views.toString(),
                      style: captionGray03)
                ],
              )
            ],
          )
        ],
      ),
    );

    Widget postSection = Container(
        padding: EdgeInsets.symmetric(vertical: 36),
        child: Text(
          _postitem.content.toString(),
          style: body1,
        ));

    Widget commentNavigation = Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("댓글 ", style: body1Bold),
            Text(
                _isLoadedComment
                    ? _commentlist.commentlist!.length.toString()
                    : '0',
                style: body1Bold),
          ],
        ),
        GestureDetector(
            child: Text("더보기 >", style: body2Gray03),
            onTap: () => {_movePostComment()})
      ],
    ));

    Widget Commentlist() {
      if (_isLoadedComment) {
        return CommentScrollListView(_commentlist.commentlist!, null);
      } else {
        return Scaffold(body: Container(child: Text("로딩중...")));
      }
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CommentListModel>.value(value: _commentlist),
      ],
      child: Scaffold(
          appBar: appBarSection,
          backgroundColor: white,
          body: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleSection,
                  writerSection,
                  postSection,
                  dividerLine,
                  commentNavigation,
                  Expanded(
                    child: Commentlist(),
                  )
                ],
              ))),
    );
  }
}
