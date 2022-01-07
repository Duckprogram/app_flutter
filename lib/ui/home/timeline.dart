import 'package:duckie_app/data/classes/channel.dart';
import 'package:duckie_app/data/models/postlist.dart';
import 'package:duckie_app/styles/styles.dart';
import 'package:duckie_app/ui/post/postwrite.dart';
import 'package:flutter/material.dart';
import 'package:duckie_app/components/postScrollView.dart';
import 'package:duckie_app/data/models/channellist.dart';
import 'package:duckie_app/data/models/community.dart';
import '../../../common/type.dart';
import 'dart:io';

class TimeLine extends StatefulWidget {
  TimeLine({Key? key, required this.choice}) : super(key: key);
  final Channel choice;
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  final PostListModel _postlist = PostListModel();

  @override
  void initState() {
    _postlist.channel_id = 1;
    super.initState();
  }

  _movePostwrite(Channel channel) {
    return Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(
            builder: (context) => PostWrite(channel: channel)))
        .then((_) => {
              _postlist.getPostList().then((_) => setState(() {
                    print("아마 제대로 안들어 갔을듯");
                    print(_postlist.postlist.toString());
                  }))
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: postScrollView(
        channel: Channel(id: 1, name: '꽥꽥'),
        // _channel.channel!,
        postlistmodel: _postlist,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "new_write",
        onPressed: () {
          // _movePostwrite(_channel.channel!);
          _movePostwrite(Channel(id: 1, name: '꽥꽥'));
        },
        child: const Icon(Icons.edit),
        backgroundColor: primaryColor,
      ),
    );
  }
}
