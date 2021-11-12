import 'package:duckie_app/components/appBarWithBack.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';
import '../../styles/styles.dart';
import 'modify_profile.dart';

class MyChannel extends StatefulWidget {
  @override
  _MyChannelState createState() => _MyChannelState();
}

class _MyChannelState extends State<MyChannel> {
  _moveChannelPage() {
    AlertDialog dialog = AlertDialog(content: Text("채널로 이동"));
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  _handleWithdraw() {
    AlertDialog dialog = AlertDialog(content: Text("탈퇴하기"));
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithBack("마이채널"),
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: <Widget>[_registeredChannels()],
    )));
  }

  Widget _registeredChannels() {
    return Container(
        margin: const EdgeInsetsDirectional.only(top: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              decoration: BoxDecoration(color: white, border: bottomBorder),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        "가입채널",
                        style: body1Bold,
                      ),
                    ),
                    Container(
                        child: Column(
                      children: [
                        _channelItem(Image.asset("assets/images/em_brush.png"),
                            "내가 청소왕이 될 상인가", false),
                        _channelItem(Image.asset("assets/images/em_brush.png"),
                            "내가 청소왕이 될 상인가", false)
                      ],
                    ))
                  ])),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(color: white, border: bottomBorder),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: white),
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        "내가 만든 채널",
                        style: body1Bold,
                      ),
                    ),
                    Container(
                        child: Column(
                      children: [
                        _channelItem(
                          Image.asset("assets/images/em_brush.png"),
                          "내가 청소왕이 될 상인가",
                          true,
                        ),
                      ],
                    ))
                  ]))
        ]));
  }

  Widget _channelItem(icon, title, isCreated) {
    return GestureDetector(
        child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1e000000),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        color: gray08,
                      ),
                      child: SizedBox(width: 28.0, height: 28.0, child: icon),
                    )),
                Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: h4),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  isCreated ? Color(0xffFFE8F9) : primaryColor2,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            child: isCreated
                                ? Text(
                                    "채널장",
                                    style: body2RegularNegative,
                                  )
                                : Text(
                                    "일반회원",
                                    style: body2RegularPrimary,
                                  )),
                        isCreated
                            ? Container(
                                child: Text(
                                "승인대기",
                                style: body1BoldGray3,
                              ))
                            : _withdrawButton()
                      ],
                    ))
              ],
            )),
        onTap: _moveChannelPage);
  }

  Widget _withdrawButton() {
    return Row(children: [
      Container(
          child: SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('assets/images/ic_withdraw.png'))),
      GestureDetector(
        child: Text("탈퇴하기", style: body1BoldPrimary),
        onTap: _handleWithdraw,
      )
    ]);
  }
}
