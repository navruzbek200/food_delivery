import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/features/auth/presentation/pages/signup/sign_up.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';
import 'login/login.dart';



class LetsInScreen extends StatelessWidget {
  const LetsInScreen({Key? key}) : super(key: key);

  static final RobotoTextStyles _textStyles = RobotoTextStyles();

  void _navigateToSpecificAuthScreen(BuildContext context, {bool isSignUp = false}) {
    Widget targetScreen;
    if (isSignUp) {
      targetScreen = const SignUpScreen();
      print("Navigating from Let's In to Sign Up Screen...");
    } else {
      targetScreen = const LoginScreen();
      print("Navigating from Let's In to Login Screen...");
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => targetScreen),
    );
  }

  void _onContinueWithFacebook(BuildContext context) { /* ... placeholder ... */ }
  void _onContinueWithGoogle(BuildContext context) { /* ... placeholder ... */ }
  void _onContinueWithApple(BuildContext context) { /* ... placeholder ... */ }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppResponsive.height(50)),

                Image.asset(
                  'assets/images/intr2.png',
                  width: AppResponsive.width(345),
                  height: AppResponsive.height(230),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => SizedBox(height: AppResponsive.height(230)),
                ),
                SizedBox(height: AppResponsive.height(15)),

                Text(
                  AppStrings.letsYouIn,
                  textAlign: TextAlign.center,
                  style: _textStyles.bold(
                    color: AppColors.primary500,
                    fontSize: 32,
                  ),
                ),
                SizedBox(height: AppResponsive.height(30)),

                SizedBox(
                  width: AppResponsive.width(345),
                  child: Column(
                    children: [
                      _buildSocialLoginButton(
                        context: context,
                        iconAsset: 'assets/icons/facebook_icon.png',
                        text: AppStrings.continueWithFacebook,
                        onPressed: () => _onContinueWithFacebook(context),
                      ),
                      SizedBox(height: AppResponsive.height(16)),
                      _buildSocialLoginButton(
                        context: context,
                        iconAsset: 'assets/icons/google_icon.png',
                        text: AppStrings.continueWithGoogle,
                        onPressed: () => _onContinueWithGoogle(context),
                      ),
                      SizedBox(height: AppResponsive.height(16)),
                      _buildSocialLoginButton(
                        context: context,
                        iconAsset: 'assets/icons/apple_icon.png',
                        text: AppStrings.continueWithApple,
                        onPressed: () => _onContinueWithApple(context),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppResponsive.height(24)),

                Text(
                  AppStrings.or,
                  style: _textStyles.regular(color: AppColors.neutral500, fontSize: 14),
                ),
                SizedBox(height: AppResponsive.height(24)),

                SizedBox(
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
                    onPressed: () => _navigateToSpecificAuthScreen(context, isSignUp: false),
                    child: Text(
                      AppStrings.signInWithPassword,
                      style: _textStyles.semiBold(color: AppColors.white, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: AppResponsive.height(16)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAccount,
                      style: _textStyles.regular(color: AppColors.neutral700, fontSize: 14),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(4)),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () => _navigateToSpecificAuthScreen(context, isSignUp: true),
                      child: Text(
                        AppStrings.signUp,
                        style: _textStyles.semiBold(color: AppColors.primary500, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppResponsive.height(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required BuildContext context,
    required String iconAsset,
    required String text,
    required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: AppResponsive.height(50),
      child: OutlinedButton.icon(
        icon: Image.asset(iconAsset, height: AppResponsive.height(24), width: AppResponsive.width(24),
          errorBuilder: (context, error, stackTrace) => Icon(Icons.error_outline, size: AppResponsive.height(24), color: AppColors.neutral400),
        ),
        label: Text(
          text,
          style: _textStyles.medium(color: AppColors.neutral800, fontSize: 16),
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