// lib/core/common/constants/text_styles/app_textstyles.dart
import 'package:flutter/material.dart';
// You might want to import your AppColors here if you want to set default colors for text styles
// import 'package:YOUR_ACTUAL_APP_NAME_HERE/core/common/constants/colors/app_colors.dart';

class AppTextStyles {
  AppTextStyles._(); // Private constructor to prevent instantiation

  static const String _fontFamilyRoboto = 'Roboto';

  // Helper for letter spacing calculation (5% of font size)
  static double _letterSpacingPercent(double fontSize, double percent) {
    return fontSize * (percent / 100);
  }

  // 40px, Semi Bold
  static const TextStyle s40w600 = TextStyle(
    fontFamily: _fontFamilyRoboto,
    fontSize: 40,
    fontWeight: FontWeight.w600, // SemiBold
    // color: AppColors.textPrimary, // Optional: default color
  );

  // 30px, Bold
  static const TextStyle s30w700 = TextStyle(
    fontFamily: _fontFamilyRoboto,
    fontSize: 30,
    fontWeight: FontWeight.w700, // Bold
  );

  // 22px, Semi Bold, 5% Letter Spacing
  static TextStyle get s22w600ls5 {
    const double fontSize = 22;
    return TextStyle(
      fontFamily: _fontFamilyRoboto,
      fontSize: fontSize,
      fontWeight: FontWeight.w600, // SemiBold
      letterSpacing: _letterSpacingPercent(fontSize, 5), // 22 * 0.05 = 1.1
    );
  }

  // 22px, Semi Bold
  static const TextStyle s22w600 = TextStyle(
    fontFamily: _fontFamilyRoboto,
    fontSize: 22,
    fontWeight: FontWeight.w600, // SemiBold
  );

  // 22px, Regular
  static const TextStyle s22w400 = TextStyle(
    fontFamily: _fontFamilyRoboto,
    fontSize: 22,
    fontWeight: FontWeight.w400, // Regular
  );

  // 18px, Semi Bold
  static const TextStyle s18w600 = TextStyle(
    fontFamily: _fontFamilyRoboto,
    fontSize: 18,
    fontWeight: FontWeight.w600, // SemiBold
  );

  // 18px, Regular
  static const TextStyle s18w400 = TextStyle(
    fontFamily: _fontFamilyRoboto,
    fontSize: 18,
    fontWeight: FontWeight.w400, // Regular
  );

  // 16px, Semi Bold
  static const TextStyle s16w600 = TextStyle(
    fontFamily: _fontFamilyRoboto,
    fontSize: 16,
    fontWeight: FontWeight.w600, // SemiBold
  );

  // 16px, Regular
  static const TextStyle s16w400 = TextStyle(
    fontFamily: _fontFamilyRoboto,
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
  );

  // 16px, Light
  static const TextStyle s16w300 = TextStyle(
    fontFamily: _fontFamilyRoboto,
    fontSize: 16,
    fontWeight: FontWeight.w300, // Light
  );

  // 12px, Medium
  static const TextStyle s12w500 = TextStyle(
    fontFamily: _fontFamilyRoboto,
    fontSize: 12,
    fontWeight: FontWeight.w500, // Medium
  );

  // 12px, Regular
  static const TextStyle s12w400 = TextStyle(
    fontFamily: _fontFamilyRoboto,
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
  );

// You can add more general styles or styles that take parameters:
// static TextStyle customStyle({
//   double fontSize = 16,
//   FontWeight fontWeight = FontWeight.w400,
//   Color color = AppColors.textPrimary, // Example default
//   double? letterSpacing,
//   TextDecoration? decoration,
// }) {
//   return TextStyle(
//     fontFamily: _fontFamilyRoboto,
//     fontSize: fontSize,
//     fontWeight: fontWeight,
//     color: color,
//     letterSpacing: letterSpacing,
//     decoration: decoration,
//   );
// }
}