import 'package:flutter/material.dart';

/// Custom theme
ThemeData oneTaskTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
    ),
    checkboxTheme: const CheckboxThemeData(
      shape: CircleBorder(),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      headline1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 21,
      ),
      headline3: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),
  );
}
