import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

class LetsInHeaderImage extends StatelessWidget {
  final String imagePath;

  const LetsInHeaderImage({
    Key? key,
    this.imagePath = 'assets/images/intr2.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: AppResponsive.width(345),
      height: AppResponsive.height(230),
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) =>
              SizedBox(height: AppResponsive.height(230)),
    );
  }
}

class LetsInTitle extends StatelessWidget {
  final RobotoTextStyles textStyles;

  const LetsInTitle({Key? key, required this.textStyles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.letsYouIn,
      textAlign: TextAlign.center,
      style: textStyles.bold(color: AppColors.primary500, fontSize: 32),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final String iconAsset;
  final String text;
  final VoidCallback onPressed;
  final RobotoTextStyles textStyles;

  const SocialLoginButton({
    Key? key,
    required this.iconAsset,
    required this.text,
    required this.onPressed,
    required this.textStyles,
    required BuildContext context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppResponsive.height(50),
      child: OutlinedButton.icon(
        icon: Image.asset(
          iconAsset,
          height: AppResponsive.height(24),
          width: AppResponsive.width(24),
          errorBuilder:
              (context, error, stackTrace) => Icon(
                Icons.error_outline,
                size: AppResponsive.height(24),
                color: AppColors.neutral400,
              ),
        ),
        label: Text(
          text,
          style: textStyles.medium(color: AppColors.neutral800, fontSize: 16),
        ),
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(20)),
          side: BorderSide(color: AppColors.neutral300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppResponsive.height(12)),
          ),
        ),
      ),
    );
  }
}

class OrDividerText extends StatelessWidget {
  final RobotoTextStyles textStyles;

  const OrDividerText({Key? key, required this.textStyles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.or,
      style: textStyles.regular(color: AppColors.neutral500, fontSize: 14),
    );
  }
}

class SignInWithPasswordButton extends StatelessWidget {
  final VoidCallback onPressed;
  final RobotoTextStyles textStyles;

  const SignInWithPasswordButton({
    Key? key,
    required this.onPressed,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppResponsive.width(345),
      height: AppResponsive.height(53),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary500,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppResponsive.height(28)),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          AppStrings.signInWithPassword,
          style: textStyles.semiBold(color: AppColors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class SignUpNavigationRow extends StatelessWidget {
  final VoidCallback onSignUpPressed;
  final RobotoTextStyles textStyles;

  const SignUpNavigationRow({
    Key? key,
    required this.onSignUpPressed,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.dontHaveAccount,
          style: textStyles.regular(color: AppColors.neutral700, fontSize: 14),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(4)),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: onSignUpPressed,
          child: Text(
            AppStrings.signUp,
            style: textStyles.semiBold(
              color: AppColors.primary500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
