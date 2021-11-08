import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';
import '../../data/models/channellist.dart';
import '../../common/type.dart';

import '../../styles/styles.dart';
import 'package:collection/collection.dart';

import 'channelpostlist.dart';
import 'channelinfo.dart';

class ChannelHome extends StatefulWidget {
  ChannelHome({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  _ChannelHomeState createState() => _ChannelHomeState();
}

class _ChannelHomeState extends State<ChannelHome> {
  List<String> channel_info = [
    '채널 게시글',
    '채널 정보',
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget pageCaller(int index) {
    switch (index) {
      case 0:
        {
          return ChannelPostList(
            id: widget.id,
          );
        }
      default :
        {
          return ChannelInfo(
            id: widget.id,
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
            Container(
              child: IconButton(
                  alignment: Alignment.bottomLeft,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: gray01,
                  icon: Icon(Icons.arrow_back)),
            ),
            Container(
              padding: EdgeInsets.only(right: 15, left: 25),
              child: Text("모동숲",
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 20,
                    fontFamily: "Spoqa Han Sans Neo",
                  )),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
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
      home: new DefaultTabController(
        length: channel_info.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: titleSection,
            toolbarHeight: 120,
            backgroundColor: gray08,
            bottom: new TabBar(
              labelColor: gray01,
              isScrollable: false,
              tabs: channel_info.map((String choice) {
                return new Tab(text: choice);
              }).toList(),
            ),
          ),
          body: new TabBarView(
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
