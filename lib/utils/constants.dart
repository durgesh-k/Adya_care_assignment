import 'package:flutter/material.dart';

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Color primary = const Color(0xFFfd950c);
Color secondary = const Color(0xFF263c7d);

//Maps emotions to respective video files
Map<String, String> emotionsUrl = {
  'happy': 'assets/images/happy.mp4',
  'sad': 'assets/images/sad.mp4',
  'angry': 'assets/images/angry.mp4',
  'relaxed': 'assets/images/relaxed.mp4',
};
