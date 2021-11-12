import 'package:flutter/material.dart';

class FlavorTheme {
  static const Color green = Color(0xff8cc63f);
  static const Color blue = Color(0xFF559ccd);
  static const Color grey = Color(0xFFb4b4b4);

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
  );

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: green,
      primaryVariant: blue,
      secondary: grey,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    fontFamily: 'Open Sans',
    textTheme: TextTheme(
      subtitle1: TextStyle(
          color: Colors.black,
          fontFamily: 'Open Sans',
          fontSize: 17,
          fontWeight: FontWeight.w500),
      subtitle2: TextStyle(
          color: Colors.white,
          fontFamily: 'Open Sans',
          fontSize: 17,
          fontWeight: FontWeight.w500),
      bodyText1: TextStyle(
          fontFamily: 'Open Sans', fontSize: 16, fontWeight: FontWeight.normal),
      bodyText2: TextStyle(
          fontFamily: 'Open Sans', fontSize: 15, fontWeight: FontWeight.normal),
      headline1:
          TextStyle(color: Colors.black, fontFamily: 'Open Sans', fontSize: 17),
      headline2:
          TextStyle(color: Colors.white, fontFamily: 'Open Sans', fontSize: 17),
    ),
  );
}
