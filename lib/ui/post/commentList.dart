import 'package:flutter/material.dart';
import '../../styles/styles.dart';
//list 비교 함수

Widget commentlist = Container(
    child: ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: 3,
        padding: const EdgeInsets.only(bottom: 30),
        itemBuilder: (context, index) => Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            decoration: BorderBottom,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 8),
                  child: Image.asset('assets/images/ic_person.png',
                      width: 32, height: 32),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "에드워드맘",
                          style: body2Bold,
                        )),
                    Container(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          "상태 진짜 좋습니다!! \n책 구매하고 고이고이 모셔두기만 했어요!!",
                          style: body2,
                        )),
                    Text("2021.10.14 21:10", style: captionGray03)
                  ],
                )
              ],
            ))));
