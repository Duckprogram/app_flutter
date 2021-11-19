import 'dart:convert';
import 'package:duckie_app/api/postitem.dart';
import 'package:duckie_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../styles/styles.dart';
import '../../data/classes/postitem.dart';
import '../../data/classes/channel.dart';
import 'postcomment.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:photo/photo.dart';
import 'package:photo_manager/photo_manager.dart';

class PostWrite extends StatefulWidget {
  PostWrite({Key? key, required this.channel}) : super(key: key);
  final Channel channel;

  @override
  State<PostWrite> createState() => _PostWriteState();
}

class _PostWriteState extends State<PostWrite> {
  late Channel _channel;
  bool isToolBarVisible = true;
  TextEditingController _titleController = TextEditingController();
  QuillController _controller = QuillController.basic();
  List<String>? imageList;
  final FocusNode editorFocusNode = FocusNode();

  @override
  void initState() {
    editorFocusNode.addListener(() {
      setState(() {
        isToolBarVisible = editorFocusNode.hasFocus;
      });
    });
    _channel = widget.channel;
    super.initState();
  }

  postWrite(String title, String content) async {
    var path = '/post/new';
    var body = {
      "category": "normal",
      "content": content,
      "title": title,
      "channel": {"id": _channel.id},
      "images": [
        imageList
      ]
    };
    try {
      var response = await api_postPost(header: null, path: path, body: body);
      print("정상 게시글 등록" + response.toString());
    } catch (e) {
      print(e);
    }
  }

  void pickAssets() async {
    List<AssetEntity> assetList = await PhotoPicker.pickAsset(context: context);
    /// Use assetList to do something.
    print(assetList.toString());
    imageList = assetList.cast<String>();
  }

  @override
  Widget build(BuildContext context) {
    Widget getEditor() {
      return QuillEditor(
        controller: _controller,
        scrollable: true,
        scrollController: ScrollController(),
        focusNode: editorFocusNode,
        padding: EdgeInsets.all(5),
        autoFocus: false,
        readOnly: false,
        expands: false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              if (_titleController.text.isNotEmpty) {
                var title = _titleController.text.toString();
                var content = _controller.document.toPlainText();
                // jsonEncode(_controller.document.toDelta().toJson());
                // var plainContent = _controller.document.toPlainText();
                print('title' + title);
                print('content' + content);
                // print('plaincontent' + plainContent);
                postWrite(title, content);
                showDialog(
                    context: context,
                    builder: (context) {
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
      body: Form(
        // color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 50,
                color: gray05,
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_channel.name!, style: body1Bold),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 20),
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
                    ],
                  )),
              Expanded(child: getEditor())
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickAssets();
        },
        child: const Icon(Icons.image),
        backgroundColor: primaryColor,
      ),
    );
  }
}
