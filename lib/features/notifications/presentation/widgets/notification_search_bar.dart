import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

class NotificationSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onFilterPressed;

  const NotificationSearchBar({
    Key? key,
    required this.onChanged,
    required this.onFilterPressed,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.width(16.0),
        vertical: AppResponsive.height(12.0),
      ),
      child: TextField(
        onChanged: onChanged,
        style: _textStyles.regular(color: AppColors.neutral800, fontSize: 14),
        decoration: InputDecoration(
          hintText: AppStrings.search,
          hintStyle: _textStyles.regular(color: AppColors.neutral400, fontSize: 14),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.neutral500,
            size: AppResponsive.height(22),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.tune_outlined,
              color: AppColors.primary500,
              size: AppResponsive.height(22),
            ),
            onPressed: onFilterPressed,
          ),
          filled: true,
          fillColor: AppColors.neutral100.withOpacity(0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppResponsive.height(12)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppResponsive.height(12)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppResponsive.height(12)),
            borderSide: BorderSide(color: AppColors.primary300, width: 1.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(14)),
        ),
      ),
    );
  }
}