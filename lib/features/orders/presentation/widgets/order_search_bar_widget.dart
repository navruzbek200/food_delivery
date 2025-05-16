import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

class OrderSearchBarWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onFilterPressed;

  const OrderSearchBarWidget({
    Key? key,
    required this.onChanged,
    required this.onFilterPressed,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.width(24),
          vertical: AppResponsive.height(16)),
      child: SizedBox(
        height: AppResponsive.height(56),
        child: TextField(
          onChanged: onChanged,
          style: _textStyles.regular(color: AppColors.neutral800, fontSize: 14),
          decoration: InputDecoration(
            hintText: AppStrings.searchOrdersHint,
            hintStyle: _textStyles.regular(color: AppColors.neutral400, fontSize: 14),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: AppResponsive.width(16), right: AppResponsive.width(12)),
              child: Icon(Icons.search, color: AppColors.neutral500, size: AppResponsive.height(22)),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: Padding(
              padding: EdgeInsets.only(left: AppResponsive.width(12), right: AppResponsive.width(16)),
              child: IconButton(
                icon: Icon(Icons.tune_outlined, color: AppColors.primary500, size: AppResponsive.height(22)),
                onPressed: onFilterPressed,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
            suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppResponsive.height(12)),
              borderSide: BorderSide(color: AppColors.neutral200, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppResponsive.height(12)),
              borderSide: BorderSide(color: AppColors.neutral200, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppResponsive.height(12)),
              borderSide: BorderSide(color: AppColors.primary300, width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(18)),
          ),
        ),
      ),
    );
  }
}