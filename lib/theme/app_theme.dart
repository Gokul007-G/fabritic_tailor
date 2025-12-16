import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  // LIGHT THEME
  static ThemeData light = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF0D3328),
      secondary: Color(0xFFDDBA84),
      background: Color(0xFFF8F5F2),
      surface: Colors.white,
      error: Color(0xFFE53935),
      onPrimary: Colors.white,
      onSecondary: Color(0xFF0D3328),
      onBackground: Color(0xFF1A1A1A),
      onSurface: Color(0xFF1A1A1A),
    ),
    scaffoldBackgroundColor: const Color(0xFFF8F5F2),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0D3328),
      foregroundColor: Colors.white,
      elevation: 3,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFDDBA84),
        foregroundColor: const Color(0xFF0D3328),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFDDBA84)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF0D3328), width: 2),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF0D3328)),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      bodyLarge: const TextStyle(fontSize: 16, color: Color(0xFF1A1A1A)),
      bodyMedium: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
      titleLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );

  // DARK THEME
  static ThemeData dark = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF0D3328),
      secondary: Color(0xFFDDBA84),
      background: Color(0xFFF8F5F2),
      surface: Colors.white,
      error: Color(0xFFE53935),
      onPrimary: Colors.white,
      onSecondary: Color(0xFF0D3328),
      onBackground: Color(0xFF1A1A1A),
      onSurface: Color(0xFF1A1A1A),
    ),
    scaffoldBackgroundColor: const Color(0xFFF8F5F2),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0D3328),
      foregroundColor: Colors.white,
      elevation: 3,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFDDBA84),
        foregroundColor: const Color(0xFF0D3328),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFDDBA84)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF0D3328), width: 2),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF0D3328)),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF1A1A1A)),
      bodyMedium: TextStyle(color: Color(0xFF1A1A1A)),
    ),
  );
}
