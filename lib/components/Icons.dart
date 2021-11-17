import 'package:flutter/material.dart';

Widget arrowIcon() {
  return Image.asset(
    'assets/images/ic_right_arrow.png',
    fit: BoxFit.cover,
    height: 24.0,
    width: 24.0,
  );
}

Widget modifyIcon() {
  return Image.asset(
    'assets/images/ic_modify.png',
    fit: BoxFit.cover,
    height: 24.0,
    width: 24.0,
  );
}

Image iconImageSmall(name, size) {
  return Image.asset(
    'assets/images/ic_' + name + '.png',
    fit: BoxFit.cover,
    height: size,
    width: size,
  );
}

Image getImageOrBasic(String? image) {
  if (image != null) {
    // try {
    //   var data = Image.network(image.toString(), width: 30, height: 20);
    //   return data;
    // } catch (e) {
      return Image.asset('assets/images/ic_person.png');
    // }
  } else {
    return Image.asset('assets/images/ic_person.png');
  }
}
