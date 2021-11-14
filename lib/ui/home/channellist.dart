import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/type.dart';
import '../../styles/styles.dart';

import '../../data/models/channellist.dart';
import '../../data/classes/channel.dart';

import '../channel/channelhome.dart';
import 'package:collection/collection.dart';

class ChannelList extends StatefulWidget {
  ChannelList({Key? key, required this.choice}) : super(key: key);
  final Category choice;

  @override
  _ChannelListState createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {

  List<Channel>? list;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _moveChannelHome(Channel channel) {
    //id를 추가한 이유는 채널의 id를 받기 위해서 추가진행
    //rootNavigator를 추가하면 bottombar 제거 가능
    return Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => ChannelHome( channel : channel)));
  }

  @override
  Widget build(BuildContext context) {
    final channellist = context.select((ChannelListModel channellistmodel) {
      return channellistmodel.channellist;
    });

    if (channellist != null && !ListEquality().equals(list, channellist)) {
      list = channellist;
    }

    Widget titleSection = Container(
        padding: EdgeInsets.only(left: 36),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            "덕님! 취향저격 \n채널을 찾아보세요",
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontFamily: "Spoqa Han Sans Neo",
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 4, bottom: 6),
            child: Image.asset('assets/images/reading_glasses.png',
                width: 28, height: 28),
          )
        ]));

    Widget listSection = Container(
        padding: EdgeInsets.all(15),
        color: Colors.white,
        child: ListView.builder(
          itemCount: list?.length ?? 0,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, position) {
            return GestureDetector(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1e000000),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 12),
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: gray08,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // child: Image.network(
                        //     "https://cdn.pixabay.com/photo/2020/12/18/05/56/flowers-5841251_1280.jpg")
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Text(
                                "#" +
                                    list![position].name.toString() +
                                    "\n" +
                                    list![position].name.toString(),
                                style: channelName),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(right: 2),
                                    child: Image.asset(
                                        'assets/images/ic_person.png',
                                        width: 12,
                                        height: 12)),
                                Text(
                                    list![position].userCount.toString() +
                                        " 모임중",
                                    style: smallDescStyle),
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text("방문하기", style: smallLinkStyle),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  // ignore: unnecessary_statements
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        // color: Colors.amber,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('채널 덕후만 읽을 수 있습니다. \n지금 바로 가입하고 덕후가 되어 보세요', style: h3,),
                              Padding(padding: const EdgeInsets.all(10)),
                              ElevatedButton(
                                child: const Text('해당 채널 바로가기'),
                                style : ButtonStyle ( 
                                  backgroundColor: 
                                  MaterialStateProperty.resolveWith((states) { if (states.contains(MaterialState.pressed)) { return primaryColor2; } else { return primaryColor; } }),
                                  shape: 
                                  MaterialStateProperty.resolveWith((states) { if (states.contains(MaterialState.pressed)) { return RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)); } else { return RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)); } }),
                                  fixedSize: 
                                  MaterialStateProperty.resolveWith((states) { if (states.contains(MaterialState.pressed)) { return Size( 330, 50); } else { return Size( 330, 50); } })
                                ),
                                onPressed: () => _moveChannelHome(list![position]),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                });
          },
        ));

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 120,
            backgroundColor: Colors.white,
            title: titleSection,
            elevation: 0),
        body: listSection);
  }
}
