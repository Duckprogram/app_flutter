import 'package:duckie_app/components/Icons.dart';
import 'package:duckie_app/ui/mypage/terms.dart';
import 'package:flutter/material.dart';
import '../../styles/styles.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  _movePOS() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TermsPage(title: "서비스 이용약관", type: "pos")));
  }

  _movePrivacyPolicy() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TermsPage(title: "개인정보 처리방침", type: "pp")));
  }

  _moveMarketingAgreement() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TermsPage(title: "마케팅 동의약관", type: "ma")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: white,
          foregroundColor: gray01,
          title: Text(
            "설정",
            style: body2Bold,
          )),
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: <Widget>[_settingMenus()],
    )));
  }

  Widget _settingMenus() {
    return Container(
        margin: const EdgeInsetsDirectional.only(top: 10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _menuButton("서비스 이용약관", _movePOS),
            _menuButton("개인정보", _movePrivacyPolicy),
            _menuButton("마케팅 동의약관", _moveMarketingAgreement)
          ],
        ));
  }

  Widget _menuButton(text, onTap) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: BorderBottom,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: body1Bold,
              ),
              arrowIcon(),
            ]),
      ),
      onTap: onTap,
    );
  }
}
