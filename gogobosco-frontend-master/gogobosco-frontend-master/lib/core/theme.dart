import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryRed = Color(0xFFFF0000);
  static const Color accentYellow = Color(0xFFFFCD1C);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  
  // Neutral Colors (sleek light theme)
  static const Color textDark = Color(0xFF1E2022);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color bgLight = Color(0xFFF9FAFB);
  static const Color borderLight = Color(0xFFE5E7EB);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryRed,
      scaffoldBackgroundColor: bgLight,
      colorScheme: const ColorScheme.light(
        primary: primaryRed,
        secondary: accentYellow,
        surface: backgroundWhite,
        error: primaryRed,
      ),
      fontFamily: 'Nunito',
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundWhite,
        foregroundColor: textDark,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryRed,
          foregroundColor: backgroundWhite,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito',
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textDark,
          side: const BorderSide(color: borderLight, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: borderLight, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: borderLight, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryRed, width: 2),
        ),
        labelStyle: const TextStyle(color: textMuted),
        hintStyle: const TextStyle(color: textMuted),
      ),
      cardTheme: CardThemeData(
        color: backgroundWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderLight, width: 1),
        ),
      ),
    );
  }
}

