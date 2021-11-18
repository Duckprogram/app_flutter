import 'package:duckie_app/data/classes/channel.dart';
import 'package:duckie_app/data/classes/postitem.dart';
import 'package:duckie_app/styles/styles.dart';
import 'package:duckie_app/ui/post/posthome.dart';
import 'package:duckie_app/utils/utils.dart';
import 'package:flutter/material.dart';

Widget postScrollView(context, Channel _channel, List<Postitem>? list) {
  if (list == null || list.length == 0) {
    return Scaffold( body : Text("아직 게시글이 없습니다") );
  }

  _movePostdetail(Postitem postitem) {
    return Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => PostHome(postitem: postitem, channel: _channel)));
  }

  return SingleChildScrollView(
      padding: EdgeInsets.only(left: 12, top: 12, right: 12),
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
                              child: // 텍스트가 영역을 넘어갈 경우 줄바꿈 여부
                                  Text(list[position].title!,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      maxLines: 2,
                                      style: channelName)),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text( list[position].user_name == null ? "익명" : list[position].user_name! ,
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
                      ),
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
                onTap: () => {_movePostdetail(list[position])});
          },
        )
      ]));
}
