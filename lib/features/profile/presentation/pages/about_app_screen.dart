import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textStyles = RobotoTextStyles();
    final String logoAssetPath = 'assets/images/logo.png';

    return Scaffold(
      backgroundColor: AppColors.primary50,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.neutral800,
            size: 20,
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          AppStrings.aboutApp,
          style: _textStyles.semiBold(
            color: AppColors.neutral900,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Spacer(flex: 2),
            SizedBox(
              width: AppResponsive.width(220),
              height: AppResponsive.height(220),
              child: Image.asset(logoAssetPath),
            ),
            SizedBox(height: AppResponsive.height(30)),

            Text(
              AppStrings.appNameFull,
              textAlign: TextAlign.center,
              style: _textStyles.black(
                color: AppColors.primary500,
                fontSize: 40,
              ),
            ),
            SizedBox(height: AppResponsive.height(8)),

            Text(
              AppStrings.appVersion,
              textAlign: TextAlign.center,
              style: _textStyles.regular(
                color: AppColors.neutral700,
                fontSize: 16,
              ),
            ),
            const Spacer(flex: 3),

            Text(
              AppStrings.websiteUrl,
              textAlign: TextAlign.center,
              style: _textStyles.regular(
                color: AppColors.neutral600,
                fontSize: 12,
              ),
            ),
            SizedBox(height: AppResponsive.height(4)),

            Text(
              AppStrings.copyrightText,
              textAlign: TextAlign.center,
              style: _textStyles.regular(
                color: AppColors.neutral600,
                fontSize: 12,
              ),
            ),
            SizedBox(height: AppResponsive.height(40)),
          ],
        ),
      ),
    );
  }
}
