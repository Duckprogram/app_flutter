import 'package:duckie_app/components/Icons.dart';
import 'package:duckie_app/data/models/channellist.dart';
import 'package:duckie_app/ui/mypage/my_channel.dart';
import 'package:duckie_app/ui/mypage/setting.dart';
import 'package:duckie_app/ui/signin/Kakaologin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:duckie_app/styles/styles.dart';
import 'package:provider/provider.dart';
import 'modify_profile.dart';

class MyPage extends StatefulWidget {
  String? _username;
  String? _picture;

  @override
  _MyPageState createState() => _MyPageState(_username, _picture);
}

class _MyPageState extends State<MyPage> {
  String? _username;
  String? _picture;
  bool _isAgree = false;

  _MyPageState(String? username, String? picture) {
    _username = username;
    _picture = picture;
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
    elevation: 0.0,
    textStyle: const TextStyle(fontSize: 15),
    shadowColor: Colors.transparent,
    primary: Colors.transparent,
  );
  @override
  initState() {
    super.initState();
    _loadProfile();
    print(_username);
    print(_picture);
  }

  _loadProfile() async {
    final storage = FlutterSecureStorage();
    String? username = await storage.read(key: 'username');
    String? picture = await storage.read(key: 'picture');
    setState(() => {_username = username, _picture = picture});
  }

  _logout() {
    AlertDialog dialog = AlertDialog(content: Text("로그아웃 되었습니다"));
    showDialog(context: context, builder: (BuildContext context) => dialog);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => KakoaLoginPage()));
  }

  withdrawal() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => KakoaLoginPage()))
        .then((_) => setState(() {}));
  }

  _moveProfileModify() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ModifyProfile()))
        .then((_) => setState(() {}));
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
          automaticallyImplyLeading: false,
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
    // const profileImage<> =  NetworkImage(widget.user.pictureUrl);
    var profileImage = _picture == null
        ? AssetImage('assets/images/profile_default.png')
        : Image.network(
            _picture!,
          ).image;

    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(children: <Widget>[
          Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.cover, image: profileImage)),
              )),
          GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _username == null ? "..." : _username!,
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
              onTap: _showWidrawModal,
            )
          ],
        ));
  }

  _showWidrawModal() {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          child: Container(
            padding: EdgeInsets.only(top: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  '탈덕하고 머글이 되시려구요?\n다시 한번 생각해보세요.',
                  style: h3,
                ),
                Container(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "탈퇴 시 유의사항",
                          style: body1BoldGray2,
                        ),
                        Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "탈퇴 시 운영 중인 채널이 폐쇄되며, 이용자가 작성한 모든 데이터는 복구가 불가능합니다.\n(타인 글의 댓글은 삭제되지 않으니 미리 확인해주세요.",
                              style: body1MediumGray2,
                            )),
                        Text(
                          "개인정보 보존기간 안내",
                          style: body1BoldGray2,
                        ),
                        Container(
                            child: Text(
                          "원칙적으로 회원 탈퇴 시 개인정보는 즉각 파기되나, 이용자에게 개인정보 보관기간에 대한 별도 동의를 얻은 경우, 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 개인정보가 보관됩니다.",
                          style: body1MediumGray2,
                        )),
                      ],
                    )),
                GestureDetector(
                    onTap: () => {
                          setState(() {
                            _isAgree = true;
                          })
                        },
                    child: Row(children: [
                      _isAgree
                          ? iconImageSmall("checkbox_active", 25.0)
                          : iconImageSmall("checkbox", 25.0),
                      Text("안내 사항을 모두 확인하였으며, 이에 동의합니다.", style: body2Primary),
                    ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: style,
                        onPressed: () => Navigator.pop(context),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: gray08,
                            ),
                            width: 160,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 40),
                            padding: const EdgeInsets.all(20),
                            child: Text('좀 더 고민해볼게요',
                                textAlign: TextAlign.center,
                                style: body1Bold))),
                    ElevatedButton(
                        style: style,
                        onPressed: withdrawal,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: primaryColor,
                            ),
                            width: 160,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 40),
                            padding: const EdgeInsets.all(20),
                            child: Text('머글로 돌아가기',
                                textAlign: TextAlign.center,
                                style: body1BoldWhite))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
