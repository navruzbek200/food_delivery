import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'profile_menu_item_widget.dart';

class AdditionalLinksSectionWidget extends StatelessWidget {
  const AdditionalLinksSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppResponsive.height(8)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppResponsive.height(12)),
        boxShadow: [ BoxShadow( color: AppColors.neutral200.withOpacity(0.5), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 1),),],
      ),
      child: Column(
        children: [
          ProfileMenuItemWidget(icon: Icons.article_outlined, title: AppStrings.termOfService, onTap: () {}),
          ProfileMenuItemWidget(icon: Icons.privacy_tip_outlined, title: AppStrings.privacyPolicy, onTap: () {}),
          ProfileMenuItemWidget(icon: Icons.info_outline, title: AppStrings.aboutApp, onTap: () {}, hasDivider: false),
        ],
      ),
    );
  }
}