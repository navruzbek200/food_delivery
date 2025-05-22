import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({Key? key}) : super(key: key);

  static final List<Map<String, String>> _socialPlatforms = [
    {'assetPath': 'assets/icons/social/twitter_icon.png', 'colorHex': '#33CCFF'},
    {'assetPath': 'assets/icons/social/facebook_icon.png', 'colorHex': '#3B5998'},
    {'assetPath': 'assets/icons/social/messenger_icon.png', 'colorHex': '#0084FF'},
    {'assetPath': 'assets/icons/social/discord_icon.png', 'colorHex': '#5865F2'},
    {'assetPath': 'assets/icons/social/skype_icon.png', 'colorHex': '#00AFF0'},
    {'assetPath': 'assets/icons/social/telegram_icon.png', 'colorHex': '#2AABEE'},
    {'assetPath': 'assets/icons/social/wechat_icon.png', 'colorHex': '#7BB32E'},
    {'assetPath': 'assets/icons/social/whatsapp_icon.png', 'colorHex': '#25D366'},
  ];

  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    try {
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return AppColors.neutral100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = RobotoTextStyles();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        shadowColor: AppColors.neutral200.withOpacity(0.7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800, size: 20),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          AppStrings.inviteFriends,
          style: textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: AppColors.neutral800, size: 24),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.width(24),
          vertical: AppResponsive.height(30),
        ),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: AppResponsive.width(20),
            mainAxisSpacing: AppResponsive.height(20),
            childAspectRatio: 1,
          ),
          itemCount: _socialPlatforms.length,
          itemBuilder: (context, index) {
            final platform = _socialPlatforms[index];
            final bgColor = _hexToColor(platform['colorHex']!);

            return GestureDetector(
              onTap: () {},
              child: Container(
                width: AppResponsive.width(60),
                height: AppResponsive.height(60),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(AppResponsive.height(12)),
                ),
                child: Center(
                  child: Image.asset(
                    platform['assetPath']!,
                    width: AppResponsive.width(30),
                    height: AppResponsive.height(30),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}