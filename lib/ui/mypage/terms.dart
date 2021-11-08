import 'package:duckie_app/components/appBarWithBack.dart';
import 'package:duckie_app/styles/styles.dart';
import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  final String title;
  final String type;
  const TermsPage({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWithBack(title),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Image.asset(
            'assets/images/terms_' + type + '.jpg',
          )
        ])));
  }
}
