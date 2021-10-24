import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildbody(),
    );
  }

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

  // Widget _imageUrl() {
  //   if (widget.user.photoUrl == null) {
  //     var notnull = widget.user.photoUrl ?? [];
  //     return notnull;
  //   }
  // }

  Widget _buildbody() {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      SizedBox(
                        width: 80.0,
                        height: 80.0,
                        child: CircleAvatar(
                            // backgroundImage: NetworkImage(widget.user.photoUrl),
                            ),
                      ),
                      Container(
                        width: 80.0,
                        height: 80.0,
                        alignment: Alignment.bottomRight,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 28.0,
                              height: 28.0,
                              child: FloatingActionButton(
                                onPressed: null,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 25.0,
                              height: 25.0,
                              child: FloatingActionButton(
                                onPressed: null,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                ],
              ),
            ],
          )),
    );
  }
}
