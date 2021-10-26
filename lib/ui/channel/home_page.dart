import 'dart:developer';

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

// Our MrTabs class.
//Will build and return our app structure.
class _HomePageState extends State<HomePage> {
  final ChannelListModel _channellist = ChannelListModel();
  // List of Category Data objects.

  List<String> init_categories = [
    '채널 리스트',
    '타임라인',
  ];

  late List<String> categories = init_categories;

  @override
  void initState() {
    // TODO: implement initState
    _channellist.getChannelList();
    _channellist.getMyChannelList().then((_) => (_asyncMethod()));
    super.initState();
  }

  //해당 함수의 경우 Mychannellist를 받은 이후에 진행되는 함수
  _asyncMethod() {
    var newChannel = List<String>.from(
        _channellist.mychannellist!.map((mychannel) => mychannel.name));
    if (_channellist.mychannellist != null &&
        !ListEquality()
            .equals(categories.sublist(2), _channellist.mychannellist)) {
      setState(() {
        categories = init_categories;
        categories.addAll(newChannel);
        print("homepage mychannellist everything " + categories.toString());
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthModel>(context, listen: false);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChannelListModel>.value(value: _channellist),
      ],
      child: new MaterialApp(
        home: new DefaultTabController(
          length: categories.length,
          child: new Scaffold(
            appBar: new AppBar(
              toolbarHeight: 0,
              backgroundColor: primaryColor,
              bottom: new TabBar(
                isScrollable: true,
                tabs: categories.map((String choice) {
                  return new Tab(
                    text: choice,
                  );
                }).toList(),
              ),
            ),
            body: new TabBarView(
              children: categories.map((String choice) {
                return new Padding(
                    padding: const EdgeInsets.all(0),
                    // child: new CategoryCard(choice: choice),
                    child: Builder(builder: (context) {
                      /// some operation here ...
                      if (choice == "채널 리스트") {
                        return new ChannelList(choice: choice);
                      } else if (choice == "타임라인") {
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
      ),
    );
  }
}
