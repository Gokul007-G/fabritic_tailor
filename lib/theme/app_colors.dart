import 'package:flutter/material.dart';

class AppColors {
  final BuildContext context;
  AppColors(this.context);

  ThemeData get _theme => Theme.of(context);

  // Primary Colors
  Color get primary => _theme.colorScheme.primary;
  Color get secondary => _theme.colorScheme.secondary;

  // Background / Surface
  Color get background => _theme.colorScheme.background;
  Color get surface => _theme.colorScheme.surface;

  // Text / Icons
  Color get textPrimary => _theme.colorScheme.onBackground;
  Color get icon => _theme.iconTheme.color!;

  // Buttons / Borders
  Color get buttonBackground => _theme.colorScheme.secondary;
  Color get buttonText => _theme.colorScheme.onSecondary;
  Color get border => _theme.colorScheme.secondary;

  // Status Colors
  Color get error => _theme.colorScheme.error;
  Color get success => const Color(0xFF4CAF50); // Optional custom
  Color get warning => const Color(0xFFFBC02D); // Optional custom
  Color get white => const Color(0xFFFFFFFF); // Optional custom
  Color get black => const Color(0xFF000000); // Optional custom
}
