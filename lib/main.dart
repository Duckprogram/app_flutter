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
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthModel>.value(value: _auth),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: KakoaLoginPage(),
          initialRoute: "/login",
          routes: <String, WidgetBuilder>{
            "/login": (BuildContext context) => KakoaLoginPage(),
            "/home": (BuildContext context) => Home(),
          },
        ));
  }
}
