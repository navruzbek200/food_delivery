import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'profile_switch_item_widget.dart';

class SwitchSettingsSectionWidget extends StatelessWidget {
  final bool pushNotificationValue;
  final ValueChanged<bool> onPushNotificationChanged;
  final bool darkModeValue;
  final ValueChanged<bool> onDarkModeChanged;
  final bool soundValue;
  final ValueChanged<bool> onSoundChanged;
  final bool autoUpdateValue;
  final ValueChanged<bool> onAutoUpdateChanged;

  const SwitchSettingsSectionWidget({
    Key? key,
    required this.pushNotificationValue,
    required this.onPushNotificationChanged,
    required this.darkModeValue,
    required this.onDarkModeChanged,
    required this.soundValue,
    required this.onSoundChanged,
    required this.autoUpdateValue,
    required this.onAutoUpdateChanged,
  }) : super(key: key);

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
          ProfileSwitchItemWidget(title: AppStrings.pushNotification, value: pushNotificationValue, onChanged: onPushNotificationChanged),
          ProfileSwitchItemWidget(title: AppStrings.darkMode, value: darkModeValue, onChanged: onDarkModeChanged),
          ProfileSwitchItemWidget(title: AppStrings.sound, value: soundValue, onChanged: onSoundChanged),
          ProfileSwitchItemWidget(title: AppStrings.automaticallyUpdated, value: autoUpdateValue, onChanged: onAutoUpdateChanged, hasDivider: false),
        ],
      ),
    );
  }
}