import 'package:duckie_app/components/Icons.dart';
import 'package:duckie_app/components/postScrollView.dart';
import 'package:duckie_app/data/models/channellist.dart';
import 'package:duckie_app/data/models/community.dart';
import 'package:duckie_app/styles/styles.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _filter = TextEditingController();
  final CommunityListModel _postlist = CommunityListModel();
  final ChannelListModel _channel = ChannelListModel();

  FocusNode focusNode = FocusNode();
  String _inputText = "";
  String _searchText = "";
  bool _isSubmited = false;

  @override
  void initState() {
    super.initState();
    _channel.getChannel(1);
  }

  _SearchPageState() {
    _filter.addListener(() {
      if (_filter.text.length > 20) {
        _filter.text = _inputText;
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(content: Text("20자 이하로 검색해주세요")));
      } else {
        setState(() {
          _inputText = _filter.text;
        });
      }
    });
  }

  _onSubmit() {
    setState(() {
      _searchText = _inputText;
      _postlist.getPostListByTitle(_searchText).then((_) => setState(() {
            _isSubmited = true;
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          foregroundColor: gray01,
          elevation: 0.1,
          shape: Border(bottom: BorderSide(color: gray07, width: 1)),
          centerTitle: true,
          title: Text(
            "검색",
            style: body2Bold,
            textAlign: TextAlign.center,
          )),
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    return Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
                top: 32,
              ),
              child: _textField(),
            ),
            _isSubmited ? _listSection(_postlist.postlist) : Container(),
          ],
        )));
  }

  Container _textField() {
    return Container(
        decoration: BoxDecoration(
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
                icon: iconImageSmall("search_2", 24.0), onPressed: _onSubmit),
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
    if (list == null || list.length == 0) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: iconImageSmall("warning", 64.0)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "'$_searchText'",
                    style: body1MediumPrimary,
                  ),
                  Text(
                    "에 대한",
                    style: body1MediumGray3,
                  )
                ],
              ),
              Text(
                "게시글이 없습니다.",
                style: body1MediumGray3,
              ),
            ],
          ),
        ),
      );
    } else {
      return postScrollView( channel : _channel.channel!, postlistmodel : list);
    }
  }
}
