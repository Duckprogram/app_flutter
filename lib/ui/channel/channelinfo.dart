import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/type.dart';
import '../../styles/styles.dart';

import '../../data/classes/channel.dart';
import '../../data/classes/channel.dart';
import '../channel/channelhome.dart';
import '../../api/channel.dart';
import 'package:collection/collection.dart';

class ChannelInfo extends StatefulWidget {
  ChannelInfo({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _ChannelInfoState createState() => _ChannelInfoState();
}

class _ChannelInfoState extends State<ChannelInfo> {
  Channel? channelinfo;

  @override
  void initState() {
    setState(() {
      api_ChannelDetail(id: widget.id)
          .then((json) => Channel.fromJson(json))
          .then((data) => _asyncMethod(data));
    });
    super.initState();
  }

  _asyncMethod(var data) {
    setState(() {
      channelinfo = data;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _MoveChannelhome() {
    //id를 추가한 이유는 채널의 id를 받기 위해서 추가진행
    //rootNavigator를 추가하면 bottombar 제거 가능
    return Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) => ChannelHome(id: widget.id)));
  }

  @override
  Widget build(BuildContext context) {
    Widget channelintroduce = Container(
        padding: EdgeInsets.only(right: 15, left: 25, top : 20),
        // padding: flex,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("채널 소개",
                    style: channelName),
            Padding(padding: const EdgeInsets.all(10)),
            Text(channelinfo?.introduction.toString() ?? "데이터를 불러오는 중 입니다.", 
                  style: body2),
            Padding(padding: const EdgeInsets.all(10)),
            Container(
              padding: EdgeInsets.only(bottom: 1),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: secondaryColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Text(" #관심사 ",
                  style: hashTag),
            ),
            Padding(padding: const EdgeInsets.all(10)),
          ],
        ));

    Widget channelrule = Container(
        padding: EdgeInsets.only(right: 15, left: 25, top : 20),
        // padding: flex,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("채널 규칙",
                    style: channelName),
            Padding(padding: const EdgeInsets.all(10)),
            Text(channelinfo?.rule.toString() ?? "데이터를 불러오는 중 입니다.", 
                  style: body2),
            Padding(padding: const EdgeInsets.all(10)),
          ],
        ));

    return Scaffold(
        body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [channelintroduce, 
                  Divider(thickness: 2.0,),
                  channelrule],
      ));
  }
}
