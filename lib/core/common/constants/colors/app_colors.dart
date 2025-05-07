// lib/core/common/constants/colors/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {

  AppColors._();

  // Primary Colors
  static const Color primary50 = Color(0xFFFFF8F5);
  static const Color primary100 = Color(0xFFFFEFEB);
  static const Color primary200 = Color(0xFFFFD7CA);
  static const Color primary300 = Color(0xFFFFB69D);
  static const Color primary400 = Color(0xFFFF9684);
  static const Color primary500 = Color(0xFFFF6247);
  static const Color primary600 = Color(0xFFE85A41);
  static const Color primary700 = Color(0xFFD14A32);
  static const Color primary800 = Color(0xFFBC3C27);
  static const Color primary900 = Color(0xFF9B2A1E);


  // Secondary Colors
  static const Color secondary50 = Color(0xFFFFFBE6);
  static const Color secondary100 = Color(0xFFFFF2C2);
  static const Color secondary200 = Color(0xFFFFE58A);
  static const Color secondary300 = Color(0xFFFFD654);
  static const Color secondary400 = Color(0xFFFFC923);
  static const Color secondary500 = Color(0xFFF7B700);
  static const Color secondary600 = Color(0xFFE09F00);
  static const Color secondary700 = Color(0xFFC98500);
  static const Color secondary800 = Color(0xFFAD6C00);
  static const Color secondary900 = Color(0xFF8A5400);

  // Neutral Colors
  static const Color neutral50 = Color(0xFFF8F9FA);
  static const Color neutral100 = Color(0xFFE9ECEF);
  static const Color neutral200 = Color(0xFFDEE2E6);
  static const Color neutral300 = Color(0xFFD0D4D9);
  static const Color neutral400 = Color(0xFFADB5BD);
  static const Color neutral500 = Color(0xFF868E96);
  static const Color neutral600 = Color(0xFF495057);
  static const Color neutral700 = Color(0xFF343A40);
  static const Color neutral800 = Color(0xFF212529);
  static const Color neutral900 = Color(0xFF0D1217);

  // Green Colors (for success, positive states, etc.)
  static const Color green50 = Color(0xFFF2FBF5);
  static const Color green100 = Color(0xFFE0F3E9);
  static const Color green200 = Color(0xFFB2E3C7);
  static const Color green300 = Color(0xFF85D3A5);
  static const Color green400 = Color(0xFF57C383);
  static const Color green500 = Color(0xFF29B362);
  static const Color green600 = Color(0xFF1FA151);
  static const Color green700 = Color(0xFF168F41);
  static const Color green800 = Color(0xFF0E7D31);
  static const Color green900 = Color(0xFF055120);

  // Common Semantic Colors (optional, but good practice)
  static const Color textPrimary = neutral800;
  static const Color textSecondary = neutral600;
  static const Color textDisabled = neutral400;
  static const Color background = Colors.white; // Or neutral50 if preferred
  static const Color surface = Colors.white;    // Or neutral50

  // If you need a specific Red for errors, add it
  // static const Color warningYellow = secondary400;
  static const Color successGreen = green500;

  // Commonly used standard colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
}