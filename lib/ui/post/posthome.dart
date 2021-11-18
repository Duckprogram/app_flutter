import 'package:duckie_app/components/Icons.dart';
import 'package:duckie_app/ui/post/commentList.dart';
import 'package:duckie_app/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../styles/styles.dart';
import '../../data/classes/postitem.dart';
import '../../data/classes/channel.dart';
import 'postcomment.dart';
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

  @override
  void initState() {
    _postitem = widget.postitem;
    _channel = widget.channel;
    super.initState();
    print(_postitem.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _movePostComment() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostComment(postitem: _postitem)));
  }

  _getProfileImage(String? image) {
    if (image == null) {
      return Image.asset('assets/images/ic_person.png');
    } else {
      return Image.network(image, width: 30, height: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBarSection = AppBar(
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
                    image: _getProfileImage(_postitem.userImage).image)),
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
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("댓글 ", style: body1Bold),
                Text(_postitem.views.toString(), style: body1BoldPrimary),
              ],
            ),
            GestureDetector(
                child: Text("더보기 >", style: body2BoldGray3),
                onTap: _movePostComment)
          ],
        ));

    return Scaffold(
        appBar: appBarSection,
        backgroundColor: white,
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleSection,
                writerSection,
                dividerLine,
                postSection,
                dividerLine,
                commentNavigation,
                commentlist
              ],
            )));
  }
}
