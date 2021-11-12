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
  }

  @override
  void dispose() {
    super.dispose();
  }

  _movePostComment() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PostComment(postitem: _postitem)));
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBarSection = AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        _channel.name.toString(),
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
    Widget writerSection = Container(
      padding: EdgeInsets.only(left: 25, top: 15),
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.only(right: 2),
              child: Image.asset('assets/images/ic_person.png',
                  width: 30, height: 20)),
          Padding(padding: const EdgeInsets.all(5)),
          Column(
            crossAxisAlignment : CrossAxisAlignment.start,
            children: [
              Text( _postitem.created_by.toString(),
              style: body1Bold),
              Row(children: [
                Text( _postitem.create_date.toString() ),
                Padding(padding: const EdgeInsets.all(5)),
                Text( " 조회 " + _postitem.views.toString() )
              ],)
            ],
          )
        ],
      ),
    );

    Widget postSection = Container(
      padding: EdgeInsets.only(left: 25),
      child: Text( _postitem.content.toString())
    );

    Widget CommentNavigation = Container(
      padding: EdgeInsets.only(left: 25, right : 25 ),
      child : Row( 
        mainAxisAlignment : MainAxisAlignment.spaceBetween,
        crossAxisAlignment : CrossAxisAlignment.start,
        children: [
          Text("댓글 " + _postitem.views.toString(), style : body1Bold),
          GestureDetector(
              child: Text("더보기 >", style : body2Gray03),
              onTap: _movePostComment ) 
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
            titleSection, 
            writerSection, 
            divider_line,
            postSection, 
            divider_line,
            CommentNavigation,
            commentlist
          ],
        ));
  }
}
