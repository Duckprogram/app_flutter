import 'dart:convert';
import 'package:duckie_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../styles/styles.dart';
import '../../data/classes/postitem.dart';
import '../../data/classes/channel.dart';
import 'post_comment.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class PostWrite extends StatefulWidget {
  PostWrite({Key? key, required this.channel}) : super(key: key);
  final Channel channel;

  @override
  State<PostWrite> createState() => _PostWriteState();
}

class _PostWriteState extends State<PostWrite> {

  TextEditingController _titleController = TextEditingController();
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                if(_titleController.text.isNotEmpty){
                  var title = _titleController.text.toString();
                  var content = jsonEncode(_controller.document.toDelta().toJson());
                  var plainContent = _controller.document.toPlainText();

                  // _postCubit.addPost(title, content, plainContent);


                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text("글이 등록되었습니다.", style: body1Bold),
                      actions: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text("확인"),
                        ),
                      ],
                    );
                  });
                }
              },
              child: Container(
                  padding: EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  child: Text("등록", style: body1BoldPrimary)),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  style: h1,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    hintText: "제목",
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 15),
                QuillToolbar.basic(controller: _controller),
                Expanded(
                  child: Container(
                    child: QuillEditor.basic(
                      controller: _controller,
                      readOnly: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}