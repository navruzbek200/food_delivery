// file: features/profile/presentation/widgets/profile_switch_item_widget.dart
import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

class ProfileSwitchItemWidget extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool hasDivider;

  const ProfileSwitchItemWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.hasDivider = true,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: _textStyles.regular(color: AppColors.neutral900, fontSize: 14)),
          trailing: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary500,
            inactiveThumbColor: AppColors.neutral300,
            inactiveTrackColor: AppColors.neutral200.withOpacity(0.5),
            activeTrackColor: AppColors.primary500.withOpacity(0.4),
          ),
          contentPadding: EdgeInsets.only(left: AppResponsive.width(16), right:AppResponsive.width(8), top: AppResponsive.height(0), bottom: AppResponsive.height(0)),
          dense: true,
        ),
        if(hasDivider) const Divider(height: 1, indent: 16, color: AppColors.neutral100,)
      ],
    );
  }
}