import 'package:duckie_app/ui/mypage/modify_profile.dart';
import 'package:duckie_app/ui/mypage/my_page.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:provider/provider.dart';

import 'ui/signin/Kakaologin.dart';
import 'ui/home.dart';

import 'data/models/auth.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthModel _auth = AuthModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthModel>.value(value: _auth),
        ],
        // child: Consumer<ThemeModel>(
        //   builder: (context, model, child) => MaterialApp(
        //     debugShowCheckedModeBanner: false,
        //     theme: model.theme,
        //     home: Consumer<AuthModel>(builder: (context, model, child) {
        //       // if (model?.user != null) return Home();
        //       return KakoaLoginPage();
        //     }),
        //     initialRoute: "/login",
        //     routes: <String, WidgetBuilder>{
        //       "/login": (BuildContext context) => KakoaLoginPage(),
        //       "/home": (BuildContext context) => Home(),
        //     },
        //   ),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: KakoaLoginPage(),
            initialRoute: "/home",
            routes: <String, WidgetBuilder>{
              "/login": (BuildContext context) => KakoaLoginPage(),
              "/home": (BuildContext context) => Home(),
              "/modify_profile": (BuildContext context) => ModifyProfile(),
              "/mypage": (BuildContext context) => MyPage(),
            },
        )
      );
  }
}
