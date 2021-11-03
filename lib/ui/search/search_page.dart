import 'package:duckie_app/components/Icons.dart';
import 'package:duckie_app/data/classes/postitem.dart';
import 'package:duckie_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Post> postList = new List.empty(growable: true);
  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  FocusNode focusNode = FocusNode();

  _SearchPageState() {
    _filter.addListener(() {
      if (_filter.text.length > 20) {
        _filter.text = _searchText;
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(content: Text("20자 이하로 검색해주세요")));
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  _onSubmit() {
    setState(() {
      _filter.clear();
    });

    postList.add(Post(
        channelImage:
            "https://cdn.pixabay.com/photo/2014/04/10/11/24/rose-320868_1280.jpg",
        username: "수양대군",
        imagePath:
            "https://cdn.pixabay.com/photo/2014/02/17/14/28/vacuum-cleaner-268179_1280.jpg",
        title: "소설 꿀팁 정리 모음집 #23 - 주방편",
        numOfView: 89,
        type: "normal",
        channelName: "청소광"));
    postList.add(Post(
        imagePath:
            "https://cdn.pixabay.com/photo/2014/04/10/11/24/rose-320868_1280.jpg",
        title: "한가위 소설 이벤트 보셨나요? ",
        numOfView: 19,
        type: "normal",
        username: "할로",
        channelName: "빵빠라방",
        channelImage:
            "https://cdn.pixabay.com/photo/2016/03/27/21/41/summer-1284386_1280.jpg"));

    postList.add(Post(
        channelImage:
            "https://cdn.pixabay.com/photo/2014/04/10/11/24/rose-320868_1280.jpg",
        username: "할로21",
        imagePath:
            "https://cdn.pixabay.com/photo/2016/03/27/21/41/summer-1284386_1280.jpg",
        title: "스콘 겁나 맛있는 집 공유",
        numOfView: 33,
        type: "normal",
        channelName: "빵빠라방"));
    postList.add(Post(
        channelImage:
            "https://cdn.pixabay.com/photo/2014/04/10/11/24/rose-320868_1280.jpg",
        username: "할로11",
        imagePath: null,
        title: "내가 왕이 될 상인가",
        numOfView: 66,
        type: "normal",
        channelName: "청소왕이될상"));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          foregroundColor: gray01,
          title: Text(
            "검색",
            style: body2Bold,
          )),
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 32,
          ),
          child: _textField(),
        ),
        _listSection(postList),
      ],
    )));
  }

  Container _textField() {
    return Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xffeeeeee),
            width: 1,
          ),
        ),
        child: TextField(
          focusNode: focusNode,
          style: TextStyle(
            fontSize: 15,
          ),
          autofocus: true,
          controller: _filter,
          onSubmitted: (String str) {
            _onSubmit();
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 24, right: 12),
            focusColor: primaryColor,
            filled: true,
            fillColor: Colors.white12,
            suffixIcon: IconButton(
                icon: iconImageSmall("search_2", 24), onPressed: _onSubmit),
            hintText: '검색어를 입력하세요.',
            labelStyle: TextStyle(color: Colors.white),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ));
  }

  Widget _listSection(list) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(children: <Widget>[
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, position) {
              return GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: gray08,
                          width: 0.8,
                        ),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 12),
                              child: Text(list[position].title!,
                                  style: channelName),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(2),
                                      margin: const EdgeInsets.only(right: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Color(0x1e000000),
                                      ),
                                      child: Image.network(
                                        list[position].channelImage!,
                                        width: 12,
                                        height: 12,
                                      )),
                                  Text(list[position].channelName.toString(),
                                      style: smallDescStyle),
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                        '|   ${list[position].username!} 방금 ${list[position].numOfView.toString()}',
                                        style: captionGray03),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: list[position].imagePath != null
                                ? Image.network(list[position].imagePath,
                                    width: 56, height: 56, fit: BoxFit.cover)
                                : Container()),
                      ],
                    ),
                  ),
                  onTap: () {});
            },
          )
        ]));
  }
}
