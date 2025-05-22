import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';
import '../../pages/search.dart';

class HomeSearchBarWidget extends StatelessWidget {
  const HomeSearchBarWidget({Key? key}) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchScreen()),
          );
          print("Search bar tapped from HomeSearchBarWidget, navigating to SearchScreen");
        },
        child: AbsorbPointer(
          child: Container(
            width: AppResponsive.width(345),
            height: AppResponsive.height(56),
            decoration: BoxDecoration(
              color: AppColors.neutral100.withOpacity(0.8),
              borderRadius: BorderRadius.circular(AppResponsive.height(12)),
            ),
            padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16.0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: AppColors.neutral500,
                  size: AppResponsive.height(22),
                ),
                SizedBox(width: AppResponsive.width(12)),
                Expanded(
                  child: TextField(
                    enabled: false,
                    style: _textStyles.regular(color: AppColors.neutral800, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: AppStrings.search,
                      hintStyle: _textStyles.regular(color: AppColors.neutral400, fontSize: 14),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(14)),
                    ),
                  ),
                ),
                SizedBox(width: AppResponsive.width(12)),
                InkWell(
                  onTap: () {
                    print("Filter button tapped from HomeSearchBarWidget (visual only)");
                  },
                  child: Icon(
                    Icons.tune_outlined,
                    color: AppColors.primary500,
                    size: AppResponsive.height(22),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}