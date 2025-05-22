import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class SecurityScreen extends StatefulWidget {

  const SecurityScreen({
    Key? key, VoidCallback? onAppBarBackPressed,
  }) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final _textStyles = RobotoTextStyles();

  bool _faceIdEnabled = false;
  bool _touchIdEnabled = false;
  bool _pinSecurityEnabled = false;

  Widget _buildSecurityOptionTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool hasDivider = true,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            title,
            style: _textStyles.regular(color: AppColors.textPrimary, fontSize: 14),
          ),
          trailing: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary500,
            inactiveThumbColor: AppColors.neutral300,
            inactiveTrackColor: AppColors.neutral200.withOpacity(0.5),
            activeTrackColor: AppColors.primary500.withOpacity(0.4),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppResponsive.width(16),
            vertical: AppResponsive.height(6),
          ),
          dense: true,
        ),
        if (hasDivider)
          Divider(
            height: 0.5,
            indent: AppResponsive.width(16),
            endIndent: AppResponsive.width(16),
            color: AppColors.neutral100,
            thickness: 0.5,
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral50,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        shadowColor: AppColors.neutral200.withOpacity(0.7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800, size: 20),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          AppStrings.security,
          style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: AppColors.neutral800, size: 24),
            onPressed: () {
              print("More options in Security tapped");
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.width(24),
          vertical: AppResponsive.height(24),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppResponsive.height(8)),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppResponsive.height(16)),
            boxShadow: [
              BoxShadow(
                color: AppColors.neutral200.withOpacity(0.6),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSecurityOptionTile(
                title: AppStrings.faceId,
                value: _faceIdEnabled,
                onChanged: (bool newValue) {
                  setState(() {
                    _faceIdEnabled = newValue;
                  });
                },
              ),
              _buildSecurityOptionTile(
                title: AppStrings.touchId,
                value: _touchIdEnabled,
                onChanged: (bool newValue) {
                  setState(() {
                    _touchIdEnabled = newValue;
                  });
                },
              ),
              _buildSecurityOptionTile(
                title: AppStrings.pinSecurity,
                value: _pinSecurityEnabled,
                onChanged: (bool newValue) {
                  setState(() {
                    _pinSecurityEnabled = newValue;
                  });
                },
                hasDivider: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}