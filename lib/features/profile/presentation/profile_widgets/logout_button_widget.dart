import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

class LogoutButtonWidget extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutButtonWidget({Key? key, required this.onLogout}) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.logout_outlined, color: AppColors.primary500),
      label: Text(AppStrings.logout, style: _textStyles.semiBold(color: AppColors.primary500, fontSize: 16),),
      onPressed: onLogout,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary50.withOpacity(0.9),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)),),
        shadowColor: Colors.transparent,
      ),
    );
  }
}