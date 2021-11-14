import 'dart:developer';

import 'package:duckie_app/data/classes/channel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';
import '../../data/models/channellist.dart';
import '../../common/type.dart';
import 'channellist.dart';
import 'mychannel.dart';
import 'timeline.dart';
import '../../styles/styles.dart';
import 'package:collection/collection.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List<Channel> init_categories = [
  Channel(name: '채널 리스트'),
  Channel(name: '타임라인'),
];

late List<Channel> categories = List.of(init_categories);

// Our MrTabs class.
//Will build and return our app structure.
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final _channellist = Provider.of<ChannelListModel>(context, listen: false);

    _channellist
        .getChannelList()
        .then((_) => _channellist.getMyChannelList())
        .then((_) => _asyncMethod(_channellist.mychannellist));

    super.initState();
  }

  //해당 함수의 경우 Mychannellist를 받은 이후에 진행되는 함수
  _asyncMethod(List<Channel>? newChannel) {
    print("new mychannellist everything " + newChannel.toString());
    print("init_categories" + init_categories.toString());
    if (!ListEquality().equals(categories.sublist(2), newChannel) &&
        newChannel != null) {
      categories = List.of(init_categories);
      setState(() {
        categories.addAll(newChannel);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget pageCaller(int index, Channel choice) {
    switch (index) {
      case 0:
        {
          return ChannelList(
            choice: choice,
          );
        }
      case 1:
        {
          return TimeLine(
            choice: choice,
          );
        }
      default:
        {
          return MyChannel(
            choice: choice,
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthModel>(context, listen: false);


    return MaterialApp(
      home: DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: primaryColor,
            bottom: TabBar(
              isScrollable: true,
              tabs: categories.map((Channel choice) {
                return Tab(
                  text: choice.name,
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: categories.map((Channel choice) {
              var index = categories.indexOf(choice);
              return pageCaller(index, choice);
            }).toList(),
          ),
        ),
      ),
      theme: ThemeData(primaryColor: Colors.deepOrange),
    );
  }
}
