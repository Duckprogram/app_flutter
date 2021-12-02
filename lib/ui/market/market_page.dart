import 'package:duckie_app/components/postScrollView.dart';
import 'package:duckie_app/data/classes/channel.dart';
import 'package:duckie_app/data/models/postlist.dart';
import 'package:duckie_app/styles/styles.dart';
import 'package:duckie_app/ui/post/postwrite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';

class MarketPage extends StatefulWidget {
  @override
  _MarketPageeState createState() => _MarketPageeState();
}

class _MarketPageeState extends State<MarketPage> {
  final PostListModel _postlist = PostListModel();

  @override
  void initState() {
    _postlist.channel_id = 2;
    super.initState();
  }

  _movePostwrite(Channel channel) {
    return Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) => PostWrite(channel: channel))).then( (_) => { _postlist.getPostList().then((_) => setState(() {})) });
  }

  AppBar appBarSection = AppBar(
      shape: Border(bottom: BorderSide(color: gray07, width: 1)),
      automaticallyImplyLeading : false,
      backgroundColor: white,
      foregroundColor: gray01,
      elevation: 0.1,
      title: Text(
        "마켓",
        style: h4,
      ),
      centerTitle: true,
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSection,
      body: postScrollView(
        channel: Channel(id: 2, name: '마켓'),
        // _channel.channel!,
        postlistmodel: _postlist,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "new_marketwrite",
        onPressed: () {
          // _movePostwrite(_channel.channel!);
          _movePostwrite(Channel(id: 2, name: '마켓'));
        },
        child: const Icon(Icons.edit),
        backgroundColor: primaryColor,
      ),
    );
  }
}
