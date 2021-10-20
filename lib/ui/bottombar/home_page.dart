import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Widget _Pop(BuildContext context, document) {
  return Text(
    document['contents'],
  );
}

class _HomePageState extends State<HomePage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _mainwidget = <Widget>[
    Container(
      color: Colors.blue,
      child: Text(
        'Index 1 ',
        style: optionStyle,
      ),
    ),
    Container(
      color: Colors.green,
      child: Text(
        'Index 2 ',
        style: optionStyle,
      ),
    ),
    Container(
      color: Colors.purple,
      child: Text(
        'Index 3 ',
        style: optionStyle,
      ),
    ),
    Container(
      color: Colors.red,
      child: Text(
        'Index 4 ',
        style: optionStyle,
      ),
    ),
  ];

  Widget _buildAppbar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              children: _mainwidget,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 350),
          ),
        ],
      ),
    );
  }
}
