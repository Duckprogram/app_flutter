import '../../components/appBarWithBack.dart';
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
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                          "마이채널",
                          style: body1Bold,
                        ),
                      ])),
              onTap: _moveChannelPage)
        ]
      )
    );
  }

}
