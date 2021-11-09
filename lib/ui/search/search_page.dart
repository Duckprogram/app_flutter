import 'package:duckie_app/components/Icons.dart';
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

  FocusNode focusNode = FocusNode();
  String _inputText = "";
  String _searchText = "";
  bool _isSubmited = false;

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
          title: Text(
            "검색",
            style: body2Bold,
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
      return SingleChildScrollView(
          padding: EdgeInsets.only(left: 12, top: 12, right: 12),
          child: Column(children: <Widget>[
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list?.length ?? 0,
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Color(0x1e000000),
                                        ),
                                        child: Image.network(
                                          list[position].channelImage != null
                                              ? list[position].channelImage!
                                              : "https://cdn.pixabay.com/photo/2014/04/10/11/24/rose-320868_1280.jpg",
                                          width: 12,
                                          height: 12,
                                        )),
                                    Text("자유게시판", style: smallDescStyle),
                                    Container(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                          '|   ${list[position].username!} 방금 ${list[position].views.toString()}',
                                          style: captionGray03),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: list[position].images != null
                                  ? Image.network(list[position].images[0],
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
}
