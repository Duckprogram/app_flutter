import 'package:duckie_app/data/classes/channel.dart';
import 'package:duckie_app/styles/styles.dart';
import 'package:duckie_app/ui/post/postwrite.dart';
import 'package:flutter/material.dart';
import 'package:duckie_app/components/postScrollView.dart';
import 'package:duckie_app/data/models/channellist.dart';
import 'package:duckie_app/data/models/community.dart';
import '../../../common/type.dart';

class TimeLine extends StatefulWidget {
  TimeLine({Key? key, required this.choice}) : super(key: key);
  final Channel choice;
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  final CommunityListModel _postlist = CommunityListModel();
  final ChannelListModel _channel = ChannelListModel();
  bool _isLoadedPost = false;
  bool _isLoadedChannel = false;

  @override
  void initState() {
    super.initState();
    _channel.getChannel(1).then((_) => {
          setState(() {
            if( _channel.channel != null) _isLoadedChannel = true;
          })
        });
    _postlist.getCommunityPosts().then((_) => {
          setState(() {
           if (_postlist.postlist != null ) _isLoadedPost = true;
          })
        });
  }

  _movePostwrite(Channel channel) {
    return Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) => PostWrite(channel: channel)));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadedPost && _isLoadedChannel) {
      return Scaffold(
          body: postScrollView(
        context,
        _channel.channel!,
        _postlist.postlist,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _movePostwrite(_channel.channel!);
        },
        child: const Icon(Icons.edit),
        backgroundColor: primaryColor,
      ),
      );
    } else {
      return Scaffold(body: Container(child: Text("로딩중...")));
    }
  }
}
