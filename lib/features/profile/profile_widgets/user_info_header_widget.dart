// file: features/profile/presentation/widgets/user_info_header_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

class UserInfoHeaderWidget extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String email;
  final String? avatarPath; // Lokal rasm yo'li
  final VoidCallback onEditProfile;

  const UserInfoHeaderWidget({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.avatarPath,
    required this.onEditProfile,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppResponsive.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppResponsive.height(12)),
        boxShadow: [BoxShadow(color: AppColors.neutral200.withOpacity(0.5), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 1),),],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppResponsive.width(32),
            backgroundColor: AppColors.neutral200,
            backgroundImage: avatarPath != null && avatarPath!.isNotEmpty
                ? AssetImage(avatarPath!) as ImageProvider
                : null,
            child: avatarPath == null || avatarPath!.isEmpty
                ? Icon(Icons.person, size: AppResponsive.width(30), color: AppColors.neutral500)
                : null,
          ),
          SizedBox(width: AppResponsive.width(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),),
                SizedBox(height: AppResponsive.height(4)),
                Text(phoneNumber, style: _textStyles.regular(color: AppColors.neutral700, fontSize: 12),),
                SizedBox(height: AppResponsive.height(2)),
                Text(email, style: _textStyles.regular(color: AppColors.neutral700, fontSize: 12),),
              ],
            ),
          ),
          InkWell(
            onTap: onEditProfile,
            borderRadius: BorderRadius.circular(AppResponsive.width(21)),
            child: Container(
              width: AppResponsive.width(42),
              height: AppResponsive.width(42),
              padding: EdgeInsets.all(AppResponsive.width(10)),
              decoration: BoxDecoration(
                color: AppColors.primary50.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: AppColors.primary100.withOpacity(0.5), blurRadius: 5, offset: const Offset(0, 2),)],
              ),
              child: SvgPicture.asset(
                'assets/icons/profile/edit_icon.svg', // Yo'lni tekshiring
                width: AppResponsive.width(20),
                height: AppResponsive.width(20),
                colorFilter: const ColorFilter.mode(AppColors.primary500, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}