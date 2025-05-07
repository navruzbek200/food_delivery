import 'package:flutter/material.dart';

class AppResponsive {
  static double height(double logicalPixelFontSize) {
    return logicalPixelFontSize;
  }

}

const String _defaultFontFamily = 'Roboto';

class DynamicTextStyles {
  // Private constructor to prevent instantiation if it's only static methods
  DynamicTextStyles._();

  static TextStyle bold({
    required Color color,
    required double fontSize,
    String fontFamily = _defaultFontFamily,
    double? letterSpacing,
    TextDecoration? decoration,
    double? height, // Line height
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppResponsive.height(fontSize), // Apply responsive scaling
      color: color,
      fontWeight: FontWeight.w700, // Bold
      letterSpacing: letterSpacing,
      decoration: decoration,
      height: height,
    );
  }

  static TextStyle semiBold({
    required Color color,
    required double fontSize,
    String fontFamily = _defaultFontFamily,
    double? letterSpacing,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppResponsive.height(fontSize),
      color: color,
      fontWeight: FontWeight.w600, // SemiBold
      letterSpacing: letterSpacing,
      decoration: decoration,
      height: height,
    );
  }

  static TextStyle medium({
    required Color color,
    required double fontSize,
    String fontFamily = _defaultFontFamily,
    double? letterSpacing,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppResponsive.height(fontSize),
      color: color,
      fontWeight: FontWeight.w500, // Medium
      letterSpacing: letterSpacing,
      decoration: decoration,
      height: height,
    );
  }

  static TextStyle regular({
    required Color color,
    required double fontSize,
    String fontFamily = _defaultFontFamily,
    double? letterSpacing,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppResponsive.height(fontSize),
      color: color,
      fontWeight: FontWeight.w400, // Regular
      letterSpacing: letterSpacing,
      decoration: decoration,
      height: height,
    );
  }

  static TextStyle light({
    required Color color,
    required double fontSize,
    String fontFamily = _defaultFontFamily,
    double? letterSpacing,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppResponsive.height(fontSize),
      color: color,
      fontWeight: FontWeight.w300, // Light
      letterSpacing: letterSpacing,
      decoration: decoration,
      height: height,
    );
  }
}