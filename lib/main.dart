import 'package:duckie_app/ui/splash.dart';
import 'package:flutter/material.dart';
import 'ui/signin/Kakaologin.dart';
import 'package:provider/provider.dart';

import 'data/models/auth.dart';

import 'ui/home/home.dart';
import 'ui/signin/Kakaologin.dart';

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthModel>.value(value: _auth),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: KakoaLoginPage(),
          initialRoute: "/splash",
          routes: <String, WidgetBuilder>{
            "/splash": (BuildContext context) => SplashPage(),
            "/login": (BuildContext context) => KakoaLoginPage(),
            "/home": (BuildContext context) => Home(),
          },
        ));
  }
}
