import '../../components/appBarWithBack.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/link.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';
import '../../styles/styles.dart';

class ModifyProfile extends StatefulWidget {
  @override
  _ModifyProfileState createState() => _ModifyProfileState();
}

class _ModifyProfileState extends State<ModifyProfile> {
  String? nickname;
  bool isEnabled = false;

  final ButtonStyle style = ElevatedButton.styleFrom(
    elevation: 0.0,
    textStyle: const TextStyle(fontSize: 20),
    shadowColor: Colors.transparent,
    primary: Colors.transparent,
  );

  final userIamge =
      "https://cdn.pixabay.com/photo/2021/09/09/12/27/child-6610447_1280.jpg";

  _loadPhotos() async {
    print("사진 리스트 불러오기");
  }

  _onSubmit() {
    if (isEnabled) {
      final snackBar = SnackBar(content: Text('프로필이 변경되었습니다.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    Navigator.of(context).pop();
  }

  onChangeNickname(String? value) {
    if (value != null && value.length > 1 && value.length <= 20) {
      setState(() {
        nickname = value;
        isEnabled = true;
      });
    } else {
      setState(() {
        isEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWithBack("프로필 설정"),
        body: _buildbody(),
        bottomNavigationBar: _bottomNavigationBar(isEnabled));
  }

  Widget _buildbody() {
    return Scaffold(
      body: Container(
          color: white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 36),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        SizedBox(
                          width: 120.0,
                          height: 120.0,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(userIamge),
                          ),
                        ),
                        Container(
                          width: 80.0,
                          height: 80.0,
                          alignment: Alignment.bottomRight,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 28.0,
                                height: 28.0,
                                child: FloatingActionButton(
                                  onPressed: _loadPhotos,
                                  backgroundColor: gray03,
                                ),
                              ),
                              SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: FloatingActionButton(
                                  onPressed: null,
                                  backgroundColor: white,
                                  child: Image.asset(
                                    'assets/images/ic_right_arrow.png',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                  ],
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 52),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          "프로필 명",
                          style: caption,
                        ),
                      ),
                      TextFormField(
                        onChanged: onChangeNickname,
                      ),
                    ],
                  ))
            ],
          )),
    );
  }

  BottomAppBar _bottomNavigationBar(enabled) {
    return BottomAppBar(
        elevation: 0.0,
        child: ElevatedButton(
            onPressed: _onSubmit,
            style: style,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: enabled ? primaryColor : Colors.black45,
                ),
                width: 320,
                margin:
                    const EdgeInsets.symmetric(vertical: 56, horizontal: 24),
                padding: const EdgeInsets.all(20),
                child: Text('수정 완료',
                    textAlign: TextAlign.center, style: body1BoldWhite))));
  }
}
