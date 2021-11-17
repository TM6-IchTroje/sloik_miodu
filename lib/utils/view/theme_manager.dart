import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ThemeManager {
  static String appName = "";

  //Colors for theme
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Colors.black;
  static Color primaryColor = Color(0xFFFA6442);
  static Color lightAccent = Color(0xFFFA6442);
  static Color darkAccent =  Color(0xFFFA6442);
//  static Color lightBG = Color(0xfffcfcff);
  static Color lightBG = Colors.grey.shade50;
  static Color darkBG = Colors.black;
  static Color badgeColor = Color(0xFFFA6442);




  static ThemeData lightTheme = ThemeData(


    fontFamily: 'cupertino',
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightPrimary,
      appBarTheme: AppBarTheme(
        color: const Color(0xFFFA6442),

      ),
    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w800),
      subtitle1: TextStyle(
          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500),
      bodyText1: TextStyle(
          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500),
      bodyText2: TextStyle(
          color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
      button: TextStyle(
          color: lightBG, fontSize: 18.0, fontWeight: FontWeight.w500),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFFA6442),
      height: 50.0,
      textTheme: ButtonTextTheme.primary,
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: lightAccent), textSelectionTheme: TextSelectionThemeData(cursorColor: lightAccent),


  );
}
