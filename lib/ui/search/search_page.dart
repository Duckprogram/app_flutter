import 'package:duckie_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
}

Widget _buildbody() {
  return Scaffold(
      body: SingleChildScrollView(
          child: Column(
    children: <Widget>[
      _postItem(
          "oprNotice",
          "방금",
          "더키 대규모 업데이트 안내",
          "디자인 요소를 최소화한 표현 방식, 정보 전달에 담긴 디자인적 의도, 유용성을 높인 규칙 등을 설명했다. 실제 진행했던 프로젝트를 예로 들어 이 방식이 디지털 프로덕트의 커뮤니케이션에서 어떤 효과를 주는지도 보여주었다.",
          false),
    ],
  )));
}

Container _postItem(type, time, title, content, isOpen) {
  return Container(child: Text("hi"));
}

Container _searchBox() {
  return Container(child: Text("hi"));
}


