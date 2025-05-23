// file: features/profile/presentation/widgets/profile_menu_item_widget.dart
import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool hasDivider;

  const ProfileMenuItemWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.hasDivider = true,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.neutral800, size: AppResponsive.width(22)),
          title: Text(title, style: _textStyles.regular(color: AppColors.neutral900, fontSize: 14)),
          trailing: Icon(Icons.arrow_forward_ios, color: AppColors.neutral500, size: AppResponsive.width(16)),
          contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(2), horizontal: AppResponsive.width(16)),
          dense: true,
          onTap: onTap,
        ),
        if (hasDivider)
          const Divider(
            height: 1,
            indent: 56, // Ikonka kengligi + padding
            color: AppColors.neutral100,
          )
      ],
    );
  }
}