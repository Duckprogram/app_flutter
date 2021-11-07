import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/type.dart';
import '../../styles/styles.dart';

import '../../data/classes/channel.dart';
import '../../data/models/postlist.dart';
import '../../data/classes/postitem.dart';
import '../channel/channelhome.dart';

import 'package:collection/collection.dart';

List<Channel>? list;

class ChannelPostList extends StatefulWidget {
  ChannelPostList({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _ChannelPostListState createState() => _ChannelPostListState();
}

class _ChannelPostListState extends State<ChannelPostList> {
  final PostListModel _postlist = PostListModel();

  final _droplist = ['전체', '일반', '마켓'];
  String _index = '전체';

  @override
  void initState() {
    _postlist.no = widget.id;
    // _postlist.getPostList().then((_) => setState(() {}));
    // _postlist.getPostNormalList().then((_) => setState(() {}));
    // _postlist.getPostMarketList().then((_) => setState(() {}));
    _postlist.getPostList().then( (_) => _postlist.getPostNormalList() ).then( (_) => _postlist.getPostMarketList() ).then((_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Postitem>? selectpost(String index) {
    switch (index) {
      case '전체':
        {
          return _postlist.postlist;
        }
      case '일반':
        {
          return _postlist.postnormallist;
        }
      default:
        {
          return _postlist.postmarketlist;
        }
    }
  }
  // _movePostdetail() {
  //   //id를 추가한 이유는 채널의 id를 받기 위해서 추가진행
  //   //rootNavigator를 추가하면 bottombar 제거 가능
  //   return Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
  //       builder: (context) => ChannelHome(id: widget.id!)));
  // }

  @override
  Widget build(BuildContext context) {

    final postitemlist = selectpost(_index);

    Widget dropdownbutton = Container(
      child: DropdownButton(
        value: _index,
        items: _droplist.map((value) {
          return DropdownMenuItem(
              value: value.toString(), child: Text(value.toString()));
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            _index = value!;
          });
        },
        hint: Text("Select item"),
        elevation: 8,
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
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(5)),
                  title: Text(postitemlist![index].title.toString() +
                      postitemlist[index].username.toString() +
                      postitemlist[index].views.toString()),
                  minVerticalPadding: 50,
                )));

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [dropdownbutton, listSection],
    ));
    // return listSection;
  }
}
