import 'package:flutter/material.dart';

getChannelIcon(icon) {
  if (icon != null) {
    return Image.network(icon.toString());
  } else {
    return Image.asset('assets/images/reading_glasses.png');
  }
}
