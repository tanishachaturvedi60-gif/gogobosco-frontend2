import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Color(0xFFD32F2F);
  static const yellow = Color(0xFFFFD600);
  static const background = Color(0xFFF8F8F8);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: background,
    fontFamily: 'Nunito',
    appBarTheme: const AppBarTheme(backgroundColor: yellow, elevation: 0),
  );
}
