import 'dart:developer';

import 'package:duckie_app/components/Icons.dart';
import 'package:duckie_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';
import '../../data/classes/channel.dart';
import '../../common/type.dart';

import '../../styles/styles.dart';
import 'package:collection/collection.dart';

import 'channelpostlist.dart';
import 'channelinfo.dart';

class ChannelHome extends StatefulWidget {
  ChannelHome({Key? key, required this.channel}) : super(key: key);
  final Channel channel;
  @override
  _ChannelHomeState createState() => _ChannelHomeState();
}

class _ChannelHomeState extends State<ChannelHome> {
  late Channel _channel;
  bool _isLoadedPost = false;
  bool _isLoadedChannel = false;

  List<String> channel_info = [
    '채널 게시글',
    '채널 정보',
  ];

  @override
  void initState() {
    _channel = widget.channel;
    super.initState();
  }

  Widget pageCaller(int index) {
    switch (index) {
      case 0:
        {
          return ChannelPostList(
            channel: _channel,
          );
        }
      default:
        {
          return ChannelInfo(
            channel: _channel,
          );
        }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthModel>(context, listen: false);

    Widget titleSection = Container(
      color: Colors.transparent,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            backpageArrow(context),
            Row(
              children: [
                Container(
                  width: 55.0,
                  height: 55.0,
                  margin: EdgeInsets.only(left: 20),
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: getImageOrBasic(_channel.icon).image)),
                ),
                Padding(padding: EdgeInsets.only(left: 20)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_channel.name.toString(), style: body1),
                    Row (
                        children : [ 
                            Text( " " + converInttoString(_channel.userCount) + "명 모임중",
                                style: smallDescStyle) ]
                      )
                  ],
                )
              ],
            ),
            Padding(padding: EdgeInsets.all(15.0)),
            Container(
                padding: EdgeInsets.only(right: 25, left: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    border: Border.all(
                      width: 10,
                      color: primaryColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Text("채널 가입하기",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: gray08,
                        fontSize: 11,
                        fontFamily: "Spoqa Han Sans Neo",
                      )),
                )),
            Padding(padding: EdgeInsets.all(5.0)),
          ],
        ),
      ),
    );

    return MaterialApp(
      home: DefaultTabController(
        length: channel_info.length,
        child: Scaffold(
          appBar: AppBar(
            title: titleSection,
            toolbarHeight: 185,
            backgroundColor: gray08,
            bottom: TabBar(
              labelColor: gray01,
              isScrollable: false,
              tabs: channel_info.map((String choice) {
                return Tab(text: choice);
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: channel_info.map((String choice) {
              var index = channel_info.indexOf(choice);
              return pageCaller(index);
            }).toList(),
          ),
        ),
      ),
    );
    //   );
  }
}
