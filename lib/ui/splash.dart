import 'dart:async';

import 'package:duckie_app/styles/styles.dart';
import 'package:duckie_app/ui/home/home_page.dart';
import 'package:duckie_app/ui/signin/Kakaologin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:duckie_app/data/models/auth.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  static final storage = FlutterSecureStorage();
  final AuthModel _auth = AuthModel();

  @override
  initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), () {
      var user = _auth.getLoginedUser();
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => KakoaLoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: Container(
              color: primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Image.asset('assets/login/login.png')],
              ))),
    );
  }
}
