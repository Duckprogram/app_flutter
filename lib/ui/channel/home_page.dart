import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';
import '../../common/type.dart';
import 'channellist.dart';
import 'mychannel.dart';
import 'timeline.dart';
import '../../styles/styles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// List of Category Data objects.
const List<Category> categories = <Category>[
  Category(name: '채널 리스트'),
  Category(name: '타임라인'),
  Category(name: '내 채널 1'),
  Category(name: '내 채널 2'),
];

// Our MrTabs class.
//Will build and return our app structure.
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthModel>(context, listen: false);

    return new MaterialApp(
      home: new DefaultTabController(
        length: categories.length,
        child: new Scaffold(
          appBar: new AppBar(
            toolbarHeight: 0,
            backgroundColor: primaryColor,
            bottom: new TabBar(
              isScrollable: true,
              tabs: categories.map((Category choice) {
                return new Tab(
                  text: choice.name,
                );
              }).toList(),
            ),
          ),
          body: new TabBarView(
            children: categories.map((Category choice) {
              return new Padding(
                  padding: const EdgeInsets.all(16.0),
                  // child: new CategoryCard(choice: choice),
                  child: Builder(builder: (context) {
                    /// some operation here ...
                    if (choice.name == "채널 리스트") {
                      return new ChannelList(choice: choice);
                    } else if (choice.name == "타임라인") {
                      return new TimeLine(choice: choice);
                    } else {
                      return new MyChannel(choice: choice);
                    }
                  }));
            }).toList(),
          ),
        ),
      ),
      theme: new ThemeData(primaryColor: Colors.deepOrange),
    );
  }
}
