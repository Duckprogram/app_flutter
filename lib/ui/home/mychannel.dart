import 'package:duckie_app/ui/channel/channelhome.dart';
import 'package:duckie_app/ui/post/posthome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/type.dart';
import '../../styles/styles.dart';
import '../../data/models/postlist.dart';
import '../../data/classes/postitem.dart';
import '../../data/models/channellist.dart';
import '../../data/classes/channel.dart';

//list 비교 함수
import 'package:collection/collection.dart';

class MyChannel extends StatefulWidget {
  MyChannel({Key? key, required this.choice}) : super(key: key);
  final Channel choice;

  @override
  _MyChannelState createState() => _MyChannelState();
}

class _MyChannelState extends State<MyChannel> {
  final PostListModel _postlist = PostListModel();
  var channel_info;

  @override
  void initState() {
    channel_info = widget.choice;
    _postlist.channel_id = channel_info.id;
    _postlist.getPostList().then((_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _moveMyChannelHome() {
    return Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => ChannelHome( channel : channel_info)));
    // return ChannelHome( channel : channel_info);
  }

  _movePostHome(Postitem postitem) {
    return Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => PostHome( postitem : postitem, channel: channel_info,)));
    // return PostHome( postitem : postitem, channel: channel_info,);
  }

  @override
  Widget build(BuildContext context) {
    final postitemlist = _postlist.postlist;

    Widget channelsection() {
      return Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(top: 15, left: 26, right: 26),
        child: GestureDetector(
          child: Container(
            padding: EdgeInsets.only(top: 15, right: 15, left: 25),
            decoration: BoxDecoration(
              color: primaryColor2,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 1),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: secondaryColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Text("#관심사",
                      style: hashTag),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Container(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text(channel_info.name.toString() + "\n채널 바로가기",
                      style: channelName),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 2),
                          child: Image.asset('assets/images/ic_person.png',
                              width: 12, height: 12)),
                      Text(channel_info.userCount.toString() + " 모임중",
                          style: smallDescStyle),
                      Container(
                        padding: EdgeInsets.only(left: 80),
                        child: Image.asset('assets/images/tree.png',
                            width: 150, height: 145),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        onTap: () => _moveMyChannelHome(),
        ),
      );
    }

    Widget listSection() {
      return Container(
          padding: EdgeInsets.all(20),
          // padding: flex,
          child: ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: postitemlist?.length ?? 0,
              padding: const EdgeInsets.all(6.0),
              itemBuilder: (context, index) => ListTile(
                    // leading: Container(
                    //   height: 40,
                    //   width: 40,
                    //   decoration:
                    //       BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                    //   alignment: Alignment.center,
                    //   child: Text(index.toString()),
                    // ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(5)),
                    title: Text(postitemlist![index].title.toString() +
                        postitemlist[index].createdBy.toString() +
                        postitemlist[index].views.toString()),
                    minVerticalPadding: 50,
                    onTap: () => _movePostHome(postitemlist[index]),
                  )));
    }

    return Scaffold(
        body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Flexible(child: channelsection()),
      Expanded(child: listSection())
    ]));
  }
}
