import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:pinput/pinput.dart';

class VerificationAppBarTitle extends StatelessWidget {
  final String titleText;
  final RobotoTextStyles textStyles;

  const VerificationAppBarTitle({
    Key? key,
    required this.titleText,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
    );
  }
}

class VerificationInfoText extends StatelessWidget {
  final String infoText;
  final RobotoTextStyles textStyles;

  const VerificationInfoText({
    Key? key,
    required this.infoText,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      infoText,
      textAlign: TextAlign.center,
      style: textStyles.regular(color: AppColors.neutral700, fontSize: 14),
    );
  }
}

class OtpPinput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onCompleted;
  final bool forceErrorState;
  final String? errorMessage;
  final RobotoTextStyles textStyles;

  const OtpPinput({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onCompleted,
    required this.forceErrorState,
    this.errorMessage,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: AppResponsive.width(60),
      height: AppResponsive.height(60),
      textStyle: textStyles.bold(color: AppColors.neutral900, fontSize: 24),
      decoration: BoxDecoration(
        color: AppColors.neutral100.withOpacity(0.7),
        borderRadius: BorderRadius.circular(AppResponsive.height(12)),
        border: Border.all(color: Colors.transparent),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary500, width: 2),
      ),
    );
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(
          color: forceErrorState ? AppColors.primary600 : AppColors.primary300,
          width: 1.5,
        ),
      ),
    );
    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary600, width: 2),
      ),
    );

    return Column(
      children: [
        Pinput(
          controller: controller,
          focusNode: focusNode,
          length: 4,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          errorPinTheme: errorPinTheme,
          pinputAutovalidateMode: PinputAutovalidateMode.disabled,
          showCursor: true,
          onCompleted: onCompleted,
          forceErrorState: forceErrorState,
        ),
        SizedBox(height: AppResponsive.height(8)),
        if (errorMessage != null && forceErrorState)
          Padding(
            padding: EdgeInsets.only(top: AppResponsive.height(8.0)),
            child: Text(
              errorMessage!,
              style: textStyles.regular(
                color: AppColors.primary600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}

class ResendCodeSection extends StatelessWidget {
  final int timerStartValue;
  final bool canResend;
  final VoidCallback onResendPressed;
  final RobotoTextStyles textStyles;

  const ResendCodeSection({
    Key? key,
    required this.timerStartValue,
    required this.canResend,
    required this.onResendPressed,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.didntReceiveCode,
          style: textStyles.regular(color: AppColors.neutral700, fontSize: 14),
        ),
        SizedBox(height: AppResponsive.height(12)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.access_time,
              color: AppColors.neutral500,
              size: AppResponsive.height(18),
            ),
            SizedBox(width: AppResponsive.width(8)),
            Text(
              "00:${timerStartValue.toString().padLeft(2, '0')}",
              style: textStyles.semiBold(
                color: AppColors.primary500,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: AppResponsive.height(12)),
        TextButton(
          onPressed: canResend ? onResendPressed : null,
          child: Text(
            AppStrings.resendCode,
            style: textStyles.semiBold(
              color: canResend ? AppColors.primary500 : AppColors.neutral400,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class VerifyOtpButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;
  final RobotoTextStyles textStyles;

  const VerifyOtpButton({
    Key? key,
    required this.isEnabled,
    required this.onPressed,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppResponsive.width(345), // yoki double.infinity va Padding bilan
      height: AppResponsive.height(53),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isEnabled ? AppColors.primary500 : AppColors.primary200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppResponsive.height(28)),
          ),
        ),
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          AppStrings.verify,
          style: textStyles.semiBold(color: AppColors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class BackToSignInTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final RobotoTextStyles textStyles;

  const BackToSignInTextButton({
    Key? key,
    required this.onPressed,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        AppStrings.backToSignIn,
        style: textStyles.medium(color: AppColors.primary600, fontSize: 14),
      ),
    );
  }
}
