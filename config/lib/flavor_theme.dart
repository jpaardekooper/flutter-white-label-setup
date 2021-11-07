import 'package:flutter/material.dart';

class FlavorTheme {
  static const Color green = Color(0xff8cc63f);
  static const Color blue = Color(0xFF559ccd);
  static const Color grey = Color(0xFFb4b4b4);

  static ThemeData getTheme() {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: green,
        primaryVariant: blue,
        secondary: grey,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      fontFamily: 'Open Sans',
      textTheme: const TextTheme(
        subtitle1: TextStyle(
            color: Colors.black,
            fontFamily: 'Open Sans',
            fontSize: 24,
            fontWeight: FontWeight.w700),
        subtitle2: TextStyle(
            color: Colors.white,
            fontFamily: 'Open Sans',
            fontSize: 24,
            fontWeight: FontWeight.w700),
        bodyText1: TextStyle(
            color: Colors.black, fontFamily: 'Open Sans', fontSize: 16),
        bodyText2:
            TextStyle(color: grey, fontFamily: 'Open Sans', fontSize: 16),
        headline1: TextStyle(
            color: Colors.black, fontFamily: 'Open Sans', fontSize: 21),
        headline2: TextStyle(
            color: Colors.white, fontFamily: 'Open Sans', fontSize: 21),
      ),
    );
  }
}
