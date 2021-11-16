import 'package:duckie_app/components/postScrollView.dart';
import 'package:duckie_app/ui/post/post_write.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/type.dart';
import '../../styles/styles.dart';

import '../../data/classes/channel.dart';
import '../../data/models/postlist.dart';
import '../../data/classes/postitem.dart';
import '../channel/channelhome.dart';
import '../post/post_home.dart';

import 'package:collection/collection.dart';

class ChannelPostList extends StatefulWidget {
  ChannelPostList({Key? key, required this.channel}) : super(key: key);
  final Channel channel;

  @override
  _ChannelPostListState createState() => _ChannelPostListState();
}

class _ChannelPostListState extends State<ChannelPostList> {
  final PostListModel _postlist = PostListModel();
  late Channel _channel;

  final _droplist = ['전체', '일반', '마켓'];
  String _index = '전체';

  @override
  void initState() {
    _channel = widget.channel;
    _postlist.channel_id = _channel.id;
    // _postlist.getPostList().then((_) => setState(() {}));
    // _postlist.getPostNormalList().then((_) => setState(() {}));
    // _postlist.getPostMarketList().then((_) => setState(() {}));
    _postlist
        .getPostList()
        .then((_) => _postlist.getPostNormalList())
        .then((_) => _postlist.getPostMarketList())
        .then((_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _movePostwrite(Channel channel) {
    return Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) => PostWrite(channel: _channel)));
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

  @override
  Widget build(BuildContext context) {
    final postitemlist = selectpost(_index);

    Widget dropdownbutton = Container(
      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
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

    Widget listSection() {
      return postScrollView(
        context,
        _channel,
        _postlist.postlist,
      );
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          dropdownbutton,
          Row(children: [listSection()])
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _movePostwrite(_channel);
        },
        child: const Icon(Icons.edit),
        backgroundColor: primaryColor,
      ),
    );
  }
}
