import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/features/auth/presentation/pages/signup/sign_up.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';
import '../widgets/lets_in_widget.dart';
import 'login/login.dart';

class LetsInScreen extends StatelessWidget {
  const LetsInScreen({Key? key}) : super(key: key);

  static final RobotoTextStyles _textStyles = RobotoTextStyles();

  void _navigateToSpecificAuthScreen(
    BuildContext context, {
    bool isSignUp = false,
  }) {
    Widget targetScreen;
    if (isSignUp) {
      targetScreen = const SignUpScreen();
      print("Navigating from Let's In to Sign Up Screen...");
    } else {
      targetScreen = const LoginScreen();
      print("Navigating from Let's In to Login Screen...");
    }

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (ctx) => targetScreen));
  }

  void _onContinueWithFacebook(BuildContext context) {
    print("Continue with Facebook pressed");
  }

  void _onContinueWithGoogle(BuildContext context) {
    print("Continue with Google pressed");
  }

  void _onContinueWithApple(BuildContext context) {
    print("Continue with Apple pressed");
  }

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

                const LetsInHeaderImage(),
                SizedBox(height: AppResponsive.height(15)),

                LetsInTitle(textStyles: _textStyles),
                SizedBox(height: AppResponsive.height(30)),

                SizedBox(
                  width: AppResponsive.width(345),
                  child: Column(
                    children: [
                      SocialLoginButton(
                        context: context,
                        iconAsset: 'assets/icons/facebook_icon.png',
                        text: AppStrings.continueWithFacebook,
                        onPressed: () => _onContinueWithFacebook(context),
                        textStyles: _textStyles,
                      ),
                      SizedBox(height: AppResponsive.height(16)),
                      SocialLoginButton(
                        context: context,
                        iconAsset: 'assets/icons/google_icon.png',
                        text: AppStrings.continueWithGoogle,
                        onPressed: () => _onContinueWithGoogle(context),
                        textStyles: _textStyles,
                      ),
                      SizedBox(height: AppResponsive.height(16)),
                      SocialLoginButton(
                        context: context,
                        iconAsset: 'assets/icons/apple_icon.png',
                        text: AppStrings.continueWithApple,
                        onPressed: () => _onContinueWithApple(context),
                        textStyles: _textStyles,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppResponsive.height(24)),

                OrDividerText(textStyles: _textStyles),
                SizedBox(height: AppResponsive.height(24)),

                SignInWithPasswordButton(
                  onPressed:
                      () => _navigateToSpecificAuthScreen(
                        context,
                        isSignUp: false,
                      ),
                  textStyles: _textStyles,
                ),
                SizedBox(height: AppResponsive.height(16)),

                SignUpNavigationRow(
                  onSignUpPressed:
                      () => _navigateToSpecificAuthScreen(
                        context,
                        isSignUp: true,
                      ),
                  textStyles: _textStyles,
                ),
                SizedBox(height: AppResponsive.height(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
