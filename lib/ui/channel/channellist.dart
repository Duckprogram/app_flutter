import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/type.dart';
import '../../styles/styles.dart';
import '../../data/models/channellist.dart';
// import '../../data/classes/channel.dart';

class ChannelList extends StatefulWidget {
  ChannelList({Key? key, required this.choice}) : super(key: key);
  final Category choice;

  @override
  _ChannelListState createState() => _ChannelListState();
}

class Channel {
  String? imagePath;
  String? name;
  String? type;
  String? channelName;
  int numOfPeople;

  Channel(
      {required this.imagePath,
      required this.name,
      required this.type,
      required this.numOfPeople,
      required this.channelName});
}

class _ChannelListState extends State<ChannelList> {
  List<Channel> postList = new List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    postList.add(Channel(
        imagePath:
            "https://cdn.pixabay.com/photo/2020/12/18/05/56/flowers-5841251_1280.jpg",
        name: "귀청소하는 그날까지 가입",
        numOfPeople: 89,
        type: "normal",
        channelName: "귀덕귀덕"));
    postList.add(Channel(
        imagePath:
            "https://cdn.pixabay.com/photo/2014/04/10/11/24/rose-320868_1280.jpg",
        name: "프로출근러",
        numOfPeople: 19,
        type: "normal",
        channelName: "명탐정코난"));
    postList.add(Channel(
        imagePath:
            "https://cdn.pixabay.com/photo/2020/12/18/05/56/flowers-5841251_1280.jpg",
        name: "안읽어본 추리 소설 공유",
        numOfPeople: 33,
        type: "normal",
        channelName: "프로출근러"));
    postList.add(Channel(
        imagePath:
            "https://cdn.pixabay.com/photo/2020/12/18/05/56/flowers-5841251_1280.jpg",
        name: "내가 왕이 될 상인가",
        numOfPeople: 66,
        type: "normal",
        channelName: "청소왕이될상"));
  }

  @override
  Widget build(BuildContext context) {
    // final postList = Provider.of<ChannelListModel>(context, listen: false);

    // return ChannelListPage(list: postList.channellist );
    return ChannelListPage(list: postList );
  }
}

class ChannelListPage extends StatelessWidget {
  final List<Channel> list; // Animal List 선언
  ChannelListPage({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: EdgeInsets.only(top: 5, left: 36),
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
        padding: EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: list.length,
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
                          child: Image.network(
                              "https://cdn.pixabay.com/photo/2020/12/18/05/56/flowers-5841251_1280.jpg")),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Text(
                                "#" +
                                    list[position].name! +
                                    "\n" +
                                    list[position].name!,
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
                                    list[position].numOfPeople.toString() +
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
                  AlertDialog dialog = AlertDialog(content: Text("선택한 채널로 이동"));
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                });
          },
        ));

    return Scaffold(
        body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Flexible(child: titleSection),
      Expanded(child: listSection, flex: 10)
    ]));
  }
}
