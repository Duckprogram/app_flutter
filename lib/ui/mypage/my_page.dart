import 'package:duckie_app/components/Icons.dart';
import 'package:duckie_app/ui/mypage/my_channel.dart';
import 'package:duckie_app/ui/mypage/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:duckie_app/data/models/auth.dart';
import 'package:duckie_app/styles/styles.dart';
import 'modify_profile.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {


  _logout() {
    AlertDialog dialog = AlertDialog(content: Text("로그아웃 되었습니다"));
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  withdrawal() {
    AlertDialog dialog = AlertDialog(content: Text("회원탈퇴 되었습니다"));
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  _moveProfileModify() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ModifyProfile()));
  }

  _moveMyChannel() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyChannel()));
  }

  _moveSetting() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Setting()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: white,
          foregroundColor: gray01,
          title: Text(
            "마이페이지",
            style: body2Bold,
          )),
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: <Widget>[_profileWidget(), _profileMenu()],
    )));
  }

  Widget _profileWidget() {
    // const profileImage<> =  NetworkImage(widget.user.photoUrl);
    const profileImage = ExactAssetImage('images/profile_default.png');
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(children: <Widget>[
          Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: 80.0,
                height: 80.0,
                child: CircleAvatar(backgroundImage: profileImage),
              )),
          GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "닉네임",
                    style: h4,
                  ),
                  modifyIcon(),
                ],
              ),
              onTap: _moveProfileModify)
        ]));
  }

  Widget _profileMenu() {
    return Container(
        margin: const EdgeInsetsDirectional.only(top: 10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    decoration: BorderBottom,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "마이채널",
                            style: body1Bold,
                          ),
                          arrowIcon()
                        ])),
                onTap: _moveMyChannel),
            GestureDetector(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                decoration: BorderBottom,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "설정",
                        style: body1Bold,
                      ),
                      arrowIcon(),
                    ]),
              ),
              onTap: _moveSetting,
            ),
            GestureDetector(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                decoration: BorderBottom,
                child: Text(
                  "로그아웃",
                  style: body1Bold,
                ),
              ),
              onTap: _logout,
            ),
            GestureDetector(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                decoration: BorderBottom,
                child: Text(
                  "회원탈퇴",
                  style: body1Bold,
                ),
              ),
              onTap: withdrawal,
            )
          ],
        ));
  }

}
