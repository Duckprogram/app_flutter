import 'package:duckie_app/components/commentScrollView.dart';
import 'package:duckie_app/data/classes/comment.dart';
import 'package:duckie_app/data/models/auth.dart';
import 'package:duckie_app/data/models/commentlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/type.dart';
import '../../styles/styles.dart';
import '../../data/models/postlist.dart';
import '../../data/classes/postitem.dart';
import '../../data/models/channellist.dart';
import '../../data/classes/channel.dart';

//list 비교 함수
import 'package:collection/collection.dart';

class PostComment extends StatefulWidget {
  PostComment({Key? key, required this.postitem}) : super(key: key);
  final Postitem postitem;
  @override
  _PostCommentState createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> with WidgetsBindingObserver {
  late final Postitem _postitem;
  late FocusNode myFocusNode;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    _postitem = widget.postitem;
    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      print(myFocusNode.hasFocus);
    });
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() { 
    WidgetsBinding.instance!.removeObserver(this);
    myFocusNode.dispose();
    super.dispose();
  }

  //댓글 작성 창 활성화시 뒤로가기 버튼을 누르면 자동적으로 창이 없어지게끔 개발완료 
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding.instance!.window.viewInsets.bottom;
    if (value == 0) {
      myFocusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthModel>(context, listen: false);
    final _commentlist = Provider.of<CommentListModel>(context, listen: false);
    final commentlist = _commentlist.commentlist;
    AppBar appBarSection = AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        "댓글",
        style: h4,
      ),
      backgroundColor: gray08,
    );
    Widget titleSection = Container(
        padding: EdgeInsets.only(left: 25, top: 15),
        child: Text(
          _postitem.title.toString(),
          style: h2,
        ));

    Widget CommentNavigation = Container(
        padding: EdgeInsets.only(left: 25, top: 20, right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Text("최신순", style: body2Gray03),
              onTap: () => {
                commentlist != null
                    ? commentlist.sort((b, a) => a.create_date
                        .toString()
                        .compareTo(b.create_date.toString()))
                    : {}
              },
            ),
            Text(" | ", style: body1Bold),
            GestureDetector(
              child: Text("오래된 순", style: body2Gray03),
              onTap: () => {
                commentlist != null
                    ? commentlist.sort((a, b) => a.create_date
                        .toString()
                        .compareTo(b.create_date.toString()))
                    : {}
              },
            )
          ],
        ));

    Widget Commentlist() {
      return CommentScrollListView(commentlist!, true);
    }

    Widget newComment = Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Focus(
        focusNode: myFocusNode,
        child: TextFormField(
          controller: _messageController,
          scrollPadding: EdgeInsets.only(bottom: 40),
          onFieldSubmitted: (value) {
            // postCubit.addPostComment(postCubit.state.posts![index],
            //     _messageController.text);
            _commentlist.postCommentWrite( _messageController.text , _auth.user!.userId! );
            setState(() {
              _messageController.text = "";
            });
          },
          decoration: InputDecoration(
              hintText: " 댓글을 남겨보세요",
              suffixIcon: MaterialButton(
                  shape: CircleBorder(),
                  onPressed: () {
                    // postCubit.addPostComment(
                    //     postCubit.state.posts![index],
                    // _messageController.text);
                    _commentlist.postCommentWrite( _messageController.text , _auth.user!.userId! );
                    myFocusNode.unfocus();
                    setState(() {
                      _messageController.text = "";
                    });
                  },
                  color: myFocusNode.hasFocus ? primaryColor : gray04,
                  textColor: gray08,
                  child: Icon(Icons.arrow_upward))),
        ),
      ),
    );

    return Scaffold(
      appBar: appBarSection,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [CommentNavigation, Commentlist()],
      ),
      bottomNavigationBar: newComment,
    );
  }
}