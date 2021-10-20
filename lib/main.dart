import 'package:flutter/material.dart';
import 'package:flutter_login/data/models/auth.dart';
import 'package:flutter_login/ui/signin/Kakaologin.dart';
import 'package:persist_theme/persist_theme.dart';
import 'package:provider/provider.dart';

import 'ui/home.dart';
import 'ui/signin/Kakaologin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeModel _model = ThemeModel();
  final AuthModel _auth = AuthModel();

  @override
  void initState() {
    try {
      _model.init();
    } catch (e) {
      print("Error Loading Theme: $e");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeModel>.value(value: _model),
          ChangeNotifierProvider<AuthModel>.value(value: _auth),
        ],
        child: Consumer<ThemeModel>(
          builder: (context, model, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: model.theme,
            home: Consumer<AuthModel>(builder: (context, model, child) {
              // if (model?.user != null) return Home();
              return KakoaLoginPage();
            }),
            initialRoute: "/login",
            routes: <String, WidgetBuilder>{
              "/login": (BuildContext context) => KakoaLoginPage(),
              "/home": (BuildContext context) => Home(),
            },
          ),
        ));
  }
}
