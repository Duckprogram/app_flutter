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

List<Category> init_categories = [
  Category(name: '채널 리스트'),
  Category(name: '타임라인'),
];

late List<Category> categories = List.of(init_categories);

// Our MrTabs class.
//Will build and return our app structure.
class _HomePageState extends State<HomePage> {
  final ChannelListModel _channellist = ChannelListModel();
  // List of Category Data objects.

  @override
  void initState() {
    // TODO: implement initState
    _channellist.getChannelList();
    _channellist.getMyChannelList().then((_) => (_asyncMethod()));
    super.initState();
  }

  //해당 함수의 경우 Mychannellist를 받은 이후에 진행되는 함수
  _asyncMethod() {
    var newChannel = List<Category>.from(_channellist.mychannellist!.map(
        (mychannel) =>
            Category(name: mychannel.name.toString(), id: mychannel.id)));
    print("new mychannellist everything " + newChannel.toString());
    print("init_categories" + init_categories.toString());
    if (!ListEquality().equals(categories.sublist(2), newChannel)) {
      setState(() {
        categories = List.of(init_categories);
        categories.addAll(newChannel);
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
                    padding: const EdgeInsets.all(0),
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
      ),
    );
  }
}
