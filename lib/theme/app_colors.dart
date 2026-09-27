import 'package:flutter/material.dart';

/// Centralized color palette for the Horizon app.
///
/// Every screen reads its colors from here instead of hardcoding hex
/// values inline. That is what keeps Login, Sign-Up, and Home feeling
/// like one consistent product instead of three separately styled
/// pages.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF1F5C54);
  static const Color primaryDark = Color(0xFF143E38);
  static const Color primaryLight = Color(0xFFDCEEEA);

  static const Color accent = Color(0xFFE3A626);

  static const Color background = Color(0xFFF6F7F5);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF1C2624);
  static const Color textSecondary = Color(0xFF5F6B68);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color border = Color(0xFFD8DED9);
  static const Color error = Color(0xFFC1493E);
}
