import 'package:flutter/material.dart';

class FlavorTheme {
  static const Color green = Color(0xff8cc63f);
  static const Color blue = Color(0xFF559ccd);
  static const Color grey = Color(0xFFb4b4b4);

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      colorScheme: ColorScheme.dark());

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: green,
      primaryVariant: blue,
      secondary: grey,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    fontFamily: 'OpenSans',
    textTheme: TextTheme(
      subtitle1: TextStyle(
        color: Colors.black,
        fontFamily: 'OpenSans',
        fontSize: 17,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        wordSpacing: 0,
      ),
      subtitle2: TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
        fontSize: 17,
        letterSpacing: 0,
        wordSpacing: 0,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: TextStyle(
          fontFamily: 'OpenSans', fontSize: 16, fontWeight: FontWeight.normal),
      bodyText2: TextStyle(
          fontFamily: 'OpenSans', fontSize: 15, fontWeight: FontWeight.normal),
      headline1:
          TextStyle(color: Colors.black, fontFamily: 'OpenSans', fontSize: 17),
      headline2:
          TextStyle(color: Colors.white, fontFamily: 'OpenSans', fontSize: 17),
    ),
  );
}
