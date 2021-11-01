import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/type.dart';
import '../../styles/styles.dart';
import '../../data/models/postlist.dart';
import '../../data/classes/postitem.dart';
import '../../data/models/channellist.dart';
import '../../data/classes/channel.dart';

class MyChannel extends StatefulWidget {
  MyChannel({Key? key, required this.choice}) : super(key: key);
  final Category choice;

  @override
  _MyChannelState createState() => _MyChannelState();
}

class _MyChannelState extends State<MyChannel> {
  final PostListModel _postlist = PostListModel();

  @override
  void initState() {
    // _postlist.getPostList().then((_) => (_asyncMethod()));
    _postlist.no = widget.choice.id;
    _postlist.getPostList();
    super.initState();
  }

  //해당 함수의 경우 Mychannellist를 받은 이후에 진행되는 함수
  // _asyncMethod() {
  //   var newChannel = List<Category>.from(_postlist.mychannellist!.map(
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
    // channel의 상세정보를 가져온다.
    // 이름, 수, icon
    final channeldetail = context.select((ChannelListModel channellistmodel) {
      return channellistmodel.mychannellist!
          .singleWhere((list) => list.id == widget.choice.id);
    });
    final postitemlist = _postlist.postlist;

    Widget channelsection = Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 15, left: 26, right: 26),
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.only(top: 15, right: 15, left: 25),
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
                child: Text("#관심사",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 11,
                      fontFamily: "Spoqa Han Sans Neo",
                    )),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Container(
                padding: EdgeInsets.only(bottom: 6),
                child: Text(channeldetail.name.toString() + "\n채널 바로가기",
                    style: channelName),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        padding: EdgeInsets.only(right: 2),
                        child: Image.asset('assets/images/ic_person.png',
                            width: 12, height: 12)),
                    Text(channeldetail.numOfPeople.toString() + " 모임중",
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

    Widget listSection = Container(
        padding: EdgeInsets.all(20),
        // padding: flex,
        child: ListView.builder(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: postitemlist?.length ?? 0,
            padding: const EdgeInsets.all(6.0),
            itemBuilder: (context, index) => ListTile(
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
                  // title: Text( postitemlist![index].title.toString() + postitemlist![index].username.toString() + postitemlist![index].numOfView.toString() ),
                  minVerticalPadding: 50,
                )));
    return Scaffold(
        body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Flexible(child: channelsection),
      Expanded(child: listSection)
    ]));
  }
}
