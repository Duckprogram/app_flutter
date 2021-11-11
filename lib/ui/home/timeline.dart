import 'package:duckie_app/data/classes/channel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/type.dart';

class TimeLine extends StatefulWidget {
  TimeLine({Key? key, required this.choice}) : super(key: key);
  final Channel choice;
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: 20,
        padding: const EdgeInsets.all(6.0),
        itemBuilder: (_, index) => ListTile(
          // leading: Container(
          //   height: 40,
          //   width: 40,
          //   decoration:
          //       BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          //   alignment: Alignment.center,
          //   child: Text(index.toString()),
          // ),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(5)),
          title: Text('List element $index'),
          minVerticalPadding: 50,
        ),
      ),
    );
  }
}
