import 'package:flutter/material.dart';

class Palette {
  // Main app colors
  static Color accentColor = const Color(0xFF181823);
  static Color accentSubColor = const Color(0xFFC0EEF2);
  static Color mainColor = const Color(0xFF1C315E);
  static Color mainSubColor = const Color(0xFFE9F8F9);

  // Constant colors
  static Color dark = const Color(0xFF000000);
  static Color light = const Color(0xFFFFFFFF);

  static Color bgColor = const Color(0xFF03001C);
  static Color barColor = const Color(0xFF03001C);
  static Color barTextColor = const Color(0xFFffffff);
  static Color bgTextColor = const Color(0xFF5B8FB9);
  static Color DrawerHeaderColor = const Color(0xFFF0DFCB);
  static Color searchBarColor = const Color(0xFFFFFFFF);
  static Color ListColor = const Color(0xFF301E67);
  static Color checkColor = const Color(0xFFFFFFFF);
  static Color fillColor = const Color(0xFF000000);
  static Color buttonColor = const Color(0xFF000000);
  static Color cardColor = const Color(0xFFFFFFFF);
  static Color selColor = const Color(0xFFFFFFFF);

  static EdgeInsets mainPadding = const EdgeInsets.all(10);

  static TextStyle mainTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: accentSubColor,
  );
  static TextStyle body = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
}
