import 'package:duckie_app/data/classes/channel.dart';
import 'package:duckie_app/data/classes/postitem.dart';
import 'package:duckie_app/data/models/postlist.dart';
import 'package:duckie_app/styles/styles.dart';
import 'package:duckie_app/ui/post/posthome.dart';
import 'package:duckie_app/utils/utils.dart';
import 'package:flutter/material.dart';

class postScrollView extends StatefulWidget {
  postScrollView({Key? key, required this.channel, required this.postlistmodel})
      : super(key: key);
  final Channel channel;
  final PostListModel postlistmodel;

  @override
  _postScrollViewState createState() => _postScrollViewState();
}

class _postScrollViewState extends State<postScrollView> {
  late final Channel _channel;
  late final PostListModel postlistmodel;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _channel = widget.channel;
    postlistmodel = widget.postlistmodel;
    postlistmodel.getPostList().then((_) => setState(() {}));

    _scrollController.addListener(() {
      print("listener");
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        postlistmodel.setLoadingState(LoadMoreStatus.LOADING);
        postlistmodel.getPostList().then((_) => setState(() {}));
      }
    });
    super.initState();
  }

  _movePostdetail(Postitem postitem) {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostHome(postitem: postitem, channel: _channel)));
  }

  @override
  Widget build(BuildContext context) {
    var list = postlistmodel.postlist;
    print(list.toString());

    if (list == null || list.length == 0) {
      return Scaffold(body: Text("아직 게시글이 없습니다"));
    }

    return Container(
        //height가 너무 크면 더 scroll이 먹지 않으므로 height를 줄였다 크기가 커지면 크기를 늘린다. 
        height: list.length < 6 ? 500 : 550,
        padding: EdgeInsets.only(left: 12, top: 12, right: 12),
        child: ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, position) {
            // print( "_scrollController.position.pixels" + _scrollController.position.pixels.toString());
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
                      Flexible(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 12),
                              child: Text(list[position].title!,
                                  style: channelName)),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(list[position].user_name!,
                                    style: captionGray03),
                                Padding(
                                  padding: EdgeInsets.only(left: 6),
                                  child: Text(
                                      getCreatedDateStr(
                                          list[position].create_date!),
                                      style: captionGray03),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 6),
                                    child: Text(
                                        "조회 " + list[position].views.toString(),
                                        style: captionGray03))
                              ],
                            ),
                          )
                        ],
                      )),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: list[position].images != null &&
                                  list[position].images!.length > 0
                              ? Image.network(list[position].images![0],
                                  width: 56, height: 56, fit: BoxFit.cover)
                              : Container()),
                    ],
                  ),
                ),
                onTap: () => {_movePostdetail(list[position])}
            );
          },
        ));
  }
}
