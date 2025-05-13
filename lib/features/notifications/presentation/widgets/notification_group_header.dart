import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart'; // To'g'ri yo'lni ko'rsating
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart'; // To'g'ri yo'lni ko'rsating
import 'package:food_delivery/core/common/constants/colors/app_colors.dart'; // To'g'ri yo'lni ko'rsating

class NotificationGroupHeader extends StatelessWidget {
  final String title;

  const NotificationGroupHeader({Key? key, required this.title}) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppResponsive.height(20),
        bottom: AppResponsive.height(8),
        left: AppResponsive.width(16),
        right: AppResponsive.width(16),
      ),
      child: Text(
        title,
        style: _textStyles.semiBold(
          color: AppColors.neutral900,
          fontSize: 16,
        ),
      ),
    );
  }
}