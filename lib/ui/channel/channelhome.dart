import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';
import '../../data/models/channellist.dart';
import '../../common/type.dart';
// import 'channellist.dart';
// import 'mychannel.dart';
// import 'timeline.dart';
import '../../styles/styles.dart';
import 'package:collection/collection.dart';

class ChannelHome extends StatefulWidget {
  @override
  _ChannelHomeState createState() => _ChannelHomeState();
}

// Our MrTabs class.
//Will build and return our app structure.
class _ChannelHomeState extends State<ChannelHome> {
  // List of Category Data objects.
  List<String> channel_info = [
    '채널 게시글',
    '채널 정보',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //해당 함수의 경우 Mychannellist를 받은 이후에 진행되는 함수
  // _asyncMethod() {
  //   var newChannel = List<Category>.from(_channellist.mychannellist!.map(
  //       (mychannel) =>
  //           Category(name: mychannel.name.toString(), id: mychannel.id)));
  //   print("new mychannellist everything " + newChannel.toString());
  //   print("init_categories" + init_categories.toString());
  //   if (!ListEquality().equals(categories.sublist(2), newChannel)) {
  //     setState(() {
  //       categories = List.of(init_categories);
  //       categories.addAll(newChannel);
  //     });
  //   }
  // }

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
              child : IconButton(
                alignment: Alignment.bottomLeft,
                onPressed: (){
                  Navigator.pop(context);
                },
                color: gray01,
                icon : Icon(Icons.arrow_back)
              ),
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
              child: Container (  
                decoration: BoxDecoration(
                  color: primaryColor,
                  border: Border.all(
                    width: 10,
                    color: primaryColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child:
                Text("채널 가입하기",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: gray08,
                      fontSize: 11,
                      fontFamily: "Spoqa Han Sans Neo",
                    )),
                )
            ),
            Padding(padding: EdgeInsets.all(5.0)),
          ],
        ),
      ),
    );


    return 
      // MultiProvider(
      // providers: [
      // ],
      // child: new 
      MaterialApp(
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
                  return new Tab(
                    text: choice,
                  );
                }).toList(),
              ),
            ),
            body: new TabBarView(
              children: channel_info.map((String choice) {
                return new Padding(
                //     padding: const EdgeInsets.all(0),
                    // child: new CategoryCard(choice: choice),
                    // child: Builder(builder: (context) {
                      /// some operation here ...
                      // if (choice == "채널 리스트") {
                      //   return new ChannelList(choice: choice);
                      // } else if (choice == "타임라인") {
                      //   return new TimeLine(choice: choice);
                      // } else {
                      //   return new MyChannel(choice: choice);
                      // }
                    // }
                    // )
                  padding: const EdgeInsets.all(0),
                  child : Text("really good")
                );
              }).toList(),
            ),
          ),
        ),
        theme: new ThemeData(primaryColor: Colors.deepOrange),
      );
  //   );
  }
}