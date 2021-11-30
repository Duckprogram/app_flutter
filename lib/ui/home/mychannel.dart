import 'package:duckie_app/components/postScrollView.dart';
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
  final ChannelListModel _channel = ChannelListModel();
  late Channel channel_info;

  @override
  void initState() {
    channel_info = widget.choice;
    _channel.getChannel(widget.choice.id!.toInt()).then((_) => {
          setState(() {
            channel_info = _channel.channel!;
          })
        });
    _postlist.channel_id = widget.choice.id;
    _postlist.getPostList().then((_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _moveMyChannelHome() {
    print(channel_info.id.toString());
    return Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => ChannelHome(channel: channel_info)));
    // return ChannelHome( channel : channel_info);
  }

  _movePostHome(Postitem postitem) {
    return Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => PostHome(
              postitem: postitem,
              channel: channel_info,
            )));
    // return PostHome( postitem : postitem, channel: channel_info,);
  }

  @override
  Widget build(BuildContext context) {
    Widget channelsection() {
      return GestureDetector(
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
                  child: Text("#관심사", style: hashTag),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Container(
                  height: 110,
                  // padding: EdgeInsets.only(bottom: 6, right : 25),
                  child: Row(
                    mainAxisSize : MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(channel_info.name.toString() + "\n채널 바로가기",
                        maxLines: 4,
                        softWrap: true,
                        // overflow: TextOverflow.fade,
                        style: channelName),
                    ]
                  )
                ),
                Container(
                  height: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 2, bottom : 10),
                          child: Row (
                            children : [ 
                                Image.asset('assets/images/ic_person.png',fit : BoxFit.fitHeight),
                                Text( " " + channel_info.userCount.toString() + " 모임중",
                                    style: smallDescStyle) ]
                          )
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Image.network(channel_info.icon.toString(),
                            fit: BoxFit.fitHeight),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          onTap: () => _moveMyChannelHome(),
        );
    }

    Widget listSection() {
      return postScrollView(
        channel : channel_info,
        postlistmodel : _postlist,
      );
    }

    return 
      Scaffold(
        appBar: AppBar(
            toolbarHeight: 280,
            backgroundColor: Colors.white,
            title: channelsection(),
            elevation: 0),
        body: listSection());

    // Scaffold(
    //     body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
    //   Flexible(child: channelsection()),
    //   Expanded(child: listSection())
    // ]));
  }
}
