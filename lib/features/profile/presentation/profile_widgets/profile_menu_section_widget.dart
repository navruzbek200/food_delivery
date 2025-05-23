// features/profile/presentation/widgets/profile_menu_section_widget.dart
import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'profile_menu_item_widget.dart';

class ProfileMenuSectionWidget extends StatelessWidget {
  const ProfileMenuSectionWidget({Key? key}) : super(key: key);

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
          ProfileMenuItemWidget(icon: Icons.location_on_outlined, title: AppStrings.myLocations, onTap: () {}),
          ProfileMenuItemWidget(icon: Icons.local_offer_outlined, title: AppStrings.myPromotions, onTap: () {}),
          ProfileMenuItemWidget(icon: Icons.payment_outlined, title: AppStrings.paymentMethods, onTap: () {}),
          ProfileMenuItemWidget(icon: Icons.chat_bubble_outline, title: AppStrings.messages, onTap: () {}),
          ProfileMenuItemWidget(icon: Icons.people_alt_outlined, title: AppStrings.inviteFriends, onTap: () {}),
          ProfileMenuItemWidget(icon: Icons.security_outlined, title: AppStrings.security, onTap: () {}),
          ProfileMenuItemWidget(icon: Icons.help_outline, title: AppStrings.helpCenter, onTap: () {}, hasDivider: false),
        ],
      ),
    );
  }
}