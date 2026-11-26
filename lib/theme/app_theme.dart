import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppColors {
  // Brand (from logo)
  static const Color green = Color(0xFF0D3328); // main brand
  static const Color greenLight = Color(0xFF1B5A47); // hover / selected
  static const Color gold = Color(0xFFDDBA84); // main accent
  static const Color goldRich = Color(
    0xFFD4AF37,
  ); // premium highlights (Sree Sai Silks)
  static const Color brown = Color(0xFF2B1810); // Sree Sai Silks background

  // Neutrals
  static const Color cream = Color(0xFFF8F5F2); // light background
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF6B6560);
  static const Color divider = Color(0xFFE8E0D5);

  // Status
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF2E7D32);
}

abstract final class AppTheme {
  static final ThemeData light = _build(
    ColorScheme.light(
      primary: AppColors.green,
      onPrimary: Colors.white,
      secondary: AppColors.gold,
      onSecondary: AppColors.green,
      tertiary: AppColors.goldRich,
      surface: Colors.white,
      onSurface: AppColors.textDark,
      error: AppColors.error,
      onError: Colors.white,
      outline: AppColors.divider,
    ),
    scaffold: AppColors.cream,
  );

  static final ThemeData dark = _build(
    ColorScheme.dark(
      primary: AppColors.gold,
      onPrimary: AppColors.green,
      secondary: AppColors.goldRich,
      onSecondary: AppColors.brown,
      surface: const Color(0xFF14231E),
      onSurface: Colors.white,
      error: const Color(0xFFEF5350),
      onError: Colors.white,
    ),
    scaffold: const Color(0xFF0A1A15),
  );

  static ThemeData _build(ColorScheme scheme, {required Color scaffold}) {
    final isLight = scheme.brightness == Brightness.light;
    final radius = BorderRadius.circular(10);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,

      appBarTheme: AppBarTheme(
        backgroundColor: isLight ? AppColors.green : scheme.surface,
        foregroundColor: isLight ? Colors.white : AppColors.gold,
        elevation: 0,
        scrolledUnderElevation: 3,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: isLight ? Colors.white : AppColors.gold,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.green,
          minimumSize: const Size.fromHeight(50),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: radius),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.primary),
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(borderRadius: radius),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: scheme.primary),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight ? Colors.white : scheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(color: AppColors.gold),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(color: AppColors.gold),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.error),
        ),
        labelStyle: const TextStyle(color: AppColors.textGrey),
      ),

      cardTheme: CardThemeData(
        color: isLight ? Colors.white : scheme.surface,
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isLight ? Colors.white : scheme.surface,
        selectedItemColor: isLight ? AppColors.green : AppColors.gold,
        unselectedItemColor: AppColors.textGrey,
        type: BottomNavigationBarType.fixed,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.green,
      ),

      dividerTheme: const DividerThemeData(color: AppColors.divider),
      iconTheme: IconThemeData(color: scheme.primary),

      textTheme:
          GoogleFonts.poppinsTextTheme(
            isLight ? ThemeData.light().textTheme : ThemeData.dark().textTheme,
          ).copyWith(
            headlineSmall: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
            titleLarge: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: const TextStyle(fontSize: 16),
            bodyMedium: const TextStyle(fontSize: 14),
            bodySmall: const TextStyle(fontSize: 12, color: AppColors.textGrey),
          ),
    );
  }
}
