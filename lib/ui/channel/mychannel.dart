import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/type.dart';
import '../../styles/styles.dart';

class MyChannel extends StatefulWidget {
  MyChannel({Key? key, required this.choice}) : super(key: key);
  final Category choice;

  @override
  _MyChannelState createState() => _MyChannelState();
}

class _MyChannelState extends State<MyChannel> {
  @override
  Widget build(BuildContext context) {
    Widget channelsection = Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 15, left: 26, right : 26),
      child: GestureDetector(
        child: Container(
            padding: EdgeInsets.only(top: 15, right : 15, left: 25),
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
                  child: Text(
                    "#관심사",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 11,
                      fontFamily: "Spoqa Han Sans Neo",
                    )
                  ),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Container(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text(
                      "모동숲 \n채널 바로가기",
                      style: channelName),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 2),
                          child: Image.asset(
                              'assets/images/ic_person.png',
                              width: 12,
                              height: 12)),
                      Text(
                         '48명' +
                              " 모임중",
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
      ),
    );

    Widget listSection = 
      Container(
      padding: EdgeInsets.all(20),
      // padding: flex,
      child : ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: 20,
        padding: const EdgeInsets.all(6.0),
        itemBuilder: (_, index) => ListTile(
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
          title: Text('List element $index'),
          minVerticalPadding: 50,
        )
      )
      );
    return Scaffold(
      body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Flexible(child: channelsection),
      Expanded(child: listSection)
      ])
    );
  }
}
