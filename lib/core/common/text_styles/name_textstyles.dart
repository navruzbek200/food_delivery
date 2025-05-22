import '../../utils/responsiveness/app_responsive.dart';
import 'app_textstyles.dart';
import 'package:flutter/material.dart';

class RobotoTextStyles extends AppTextStyles {

  String roboto = "Roboto";
  @override
  TextStyle bold({required Color color, required double fontSize}) => TextStyle(
    fontSize: AppResponsive.height(fontSize),
    color: color,
    fontWeight: FontWeight.bold,
    fontFamily: roboto,
  );

  @override
  TextStyle semiBold({required Color color, required double fontSize}) =>
      TextStyle(
        fontSize: AppResponsive.height(fontSize),
        color: color,
        fontWeight: FontWeight.w600,
        fontFamily: roboto,
      );

  @override
  TextStyle medium({required Color color, required double fontSize}) =>
      TextStyle(
        fontSize: AppResponsive.height(fontSize),
        color: color,
        fontWeight: FontWeight.w500,
        fontFamily: roboto,
      );

  @override
  TextStyle regular({required Color color, required double fontSize, TextDecoration? decoration}) =>
      TextStyle(
        fontSize: AppResponsive.height(fontSize),
        decoration: decoration,
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: roboto,
      );

  black({required Color color, required int fontSize}) {}
}