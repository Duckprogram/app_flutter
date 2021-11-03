import 'package:duckie_app/components/Icons.dart';
import 'package:duckie_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/auth.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  FocusNode focusNode = FocusNode();
  bool _isOpen1 = false;
  bool _isOpen2 = false;
  bool _isOpen3 = false;

  _toggleContent(number) {
    switch (number) {
      case 1:
        _isOpen1 = !_isOpen1;
        break;
      case 2:
        _isOpen2 = !_isOpen2;
        break;
      case 3:
        _isOpen3 = !_isOpen3;
        break;
    }
    setState(() {
      _isOpen1 = _isOpen1;
      _isOpen2 = _isOpen2;
      _isOpen3 = _isOpen3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          foregroundColor: gray01,
          title: Text(
            "알림",
            style: body2Bold,
          )),
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        _operatorNotice(
            1,
            "oprNotice",
            "방금",
            "더키 대규모 업데이트 안내",
            "디자인 요소를 최소화한 표현 방식, 정보 전달에 담긴 디자인적 의도, 유용성을 높인 규칙 등을 설명했다. 실제 진행했던 프로젝트를 예로 들어 이 방식이 디지털 프로덕트의 커뮤니케이션에서 어떤 효과를 주는지도 보여주었다.",
            _isOpen1),
        _operatorNotice(
            2,
            "oprNotice",
            "방금",
            "iF 디자인 어워드 2021 수상작에 담긴 디자인 인사이트를 나누는 시간",
            "디자인 요소를 최소화한 표현 방식, 정보 전달에 담긴 디자인적 의도, 유용성을 높인 규칙 등을 설명했다. 실제 진행했던 프로젝트를 예로 들어 이 방식이 디지털 프로덕트의 커뮤니케이션에서 어떤 효과를 주는지도 보여주었다.",
            _isOpen2),
        _operatorNotice(
            3,
            "oprNotice",
            "방금",
            "MZ세대의 관점에서 본 증권업에 대한 이해",
            "디자인 요소를 최소화한 표현 방식, 정보 전달에 담긴 디자인적 의도, 유용성을 높인 규칙 등을 설명했다. 실제 진행했던 프로젝트를 예로 들어 이 방식이 디지털 프로덕트의 커뮤니케이션에서 어떤 효과를 주는지도 보여주었다.",
            _isOpen3),
        _operatorNotice(4, "comment", "1시간 전",
            "디지털 프로덕트의 실용적인 커뮤니케이션 방법론이 발표되었습니다.", "", false),
      ],
    )));
  }

  Widget _operatorNotice(index, type, time, title, content, isOpen) {
    return Container(
        decoration: BoxDecoration(border: bottomBorder),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(color: white),
                  child: Column(
                    children: [
                      _noticeInfo(type, time),
                      Container(
                          padding: const EdgeInsets.only(top: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: body2Bold,
                              ),
                              type == "oprNotice"
                                  ? (isOpen
                                      ? iconImageSmall("arrow_bottom", 16)
                                      : iconImageSmall("arrow_top", 16))
                                  : Container()
                            ],
                          )),
                    ],
                  )),
              onTap: () {
                _toggleContent(index);
              },
            ),
            isOpen
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 32),
                    decoration: BoxDecoration(
                      color: gray08,
                    ),
                    child: Text(
                      content,
                      style: body2Regular,
                    ))
                : Container()
          ],
        ));
  }

  _noticeInfo(type, time) {
    var title = (type == "oprNotice") ? "공지사항" : "댓글알림";
    return Row(
      children: [
        Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: gray08,
            ),
            child: SizedBox(
              child: iconImageSmall(
                  type == "oprNotice" ? "notice_opr" : "notice_default", 10),
            )),
        Text(title, style: caption),
        Container(
          child: Text("|", style: captionGray03),
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        Text(time, style: captionGray03)
      ],
    );
  }
}
