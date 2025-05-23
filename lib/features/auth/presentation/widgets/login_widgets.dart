import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

InputDecoration globalAuthInputDecoration({
  required String hintText,
  required IconData prefixIcon,
  Widget? suffixIcon,
  required RobotoTextStyles textStyles,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: textStyles.regular(color: AppColors.neutral400, fontSize: 14),
    prefixIcon: Icon(
      prefixIcon,
      color: AppColors.neutral400,
      size: AppResponsive.height(20),
    ),
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: AppColors.neutral100.withOpacity(0.5),
    contentPadding: EdgeInsets.symmetric(
      vertical: AppResponsive.height(16),
      horizontal: AppResponsive.width(16),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppResponsive.height(12)),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppResponsive.height(12)),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppResponsive.height(12)),
      borderSide: BorderSide(color: AppColors.primary300, width: 1.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppResponsive.height(12)),
      borderSide: BorderSide(color: AppColors.primary500, width: 1.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppResponsive.height(12)),
      borderSide: BorderSide(color: AppColors.primary500, width: 1.5),
    ),
  );
}

class LoginTitle extends StatelessWidget {
  final RobotoTextStyles textStyles;

  const LoginTitle({Key? key, required this.textStyles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.login,
      style: textStyles.bold(color: AppColors.primary500, fontSize: 30),
    );
  }
}

class EmailTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final RobotoTextStyles textStyles;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  const EmailTextFormField({
    Key? key,
    required this.controller,
    required this.textStyles,
    this.validator,
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: globalAuthInputDecoration(
        hintText: AppStrings.email,
        prefixIcon: Icons.email_outlined,
        textStyles: textStyles,
      ),
      validator:
      validator ??
              (value) {
            if (value == null || value.isEmpty)
              return AppStrings.pleaseEnterEmail;
            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value))
              return AppStrings.pleaseEnterValidEmail;
            return null;
          },
      textInputAction: textInputAction,
    );
  }
}

class PasswordTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final RobotoTextStyles textStyles;
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;

  const PasswordTextFormField({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.onToggleVisibility,
    required this.textStyles,
    required this.hintText,
    this.validator,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: globalAuthInputDecoration(
        hintText: hintText,
        prefixIcon: Icons.lock_outline,
        textStyles: textStyles,
        suffixIcon: IconButton(
          icon: Icon(
            obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: AppColors.neutral400,
          ),
          onPressed: onToggleVisibility,
        ),
      ),
      validator: validator,
      textInputAction:
      onFieldSubmitted != null
          ? TextInputAction.done
          : TextInputAction.next,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}

class RememberMeCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final RobotoTextStyles textStyles;

  const RememberMeCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      splashColor: AppColors.primary100,
      highlightColor: AppColors.primary100,
      child: Row(
        children: [
          SizedBox(
            width: AppResponsive.width(24),
            height: AppResponsive.height(24),
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primary500,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              side: BorderSide(
                color: value ? AppColors.primary500 : AppColors.neutral300,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppResponsive.height(4)),
              ),
            ),
          ),
          SizedBox(width: AppResponsive.width(12)),
          Text(
            AppStrings.rememberMe,
            style: textStyles.medium(color: AppColors.neutral800, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class PrimaryElevatedButton extends StatelessWidget {
  final String buttonText;
  final bool isEnabled;
  final VoidCallback? onPressed;
  final RobotoTextStyles textStyles;

  const PrimaryElevatedButton({
    Key? key,
    required this.buttonText,
    required this.isEnabled,
    this.onPressed,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
          isEnabled ? AppColors.primary500 : AppColors.primary200,
          padding: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppResponsive.height(28)),
          ),
          elevation: isEnabled ? 2 : 0,
        ),
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          buttonText,
          style: textStyles.semiBold(color: AppColors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  final VoidCallback onPressed;
  final RobotoTextStyles textStyles;

  const ForgotPasswordButton({
    Key? key,
    required this.onPressed,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        AppStrings.forgotPassword,
        style: textStyles.medium(color: AppColors.primary500, fontSize: 14),
      ),
    );
  }
}

class OrDividerWithText extends StatelessWidget {
  final String text;
  final RobotoTextStyles textStyles;

  const OrDividerWithText({
    Key? key,
    required this.text,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(20)),
      child: Row(
        children: [
          const Expanded(
            child: Divider(color: AppColors.neutral200, thickness: 1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16)),
            child: Text(
              text,
              style: textStyles.regular(
                color: AppColors.neutral600,
                fontSize: 14,
              ),
            ),
          ),
          const Expanded(
            child: Divider(color: AppColors.neutral200, thickness: 1),
          ),
        ],
      ),
    );
  }
}

class SocialLoginIcons extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onFacebookTap;
  final VoidCallback onAppleTap;

  const SocialLoginIcons({
    Key? key,
    required this.onGoogleTap,
    required this.onFacebookTap,
    required this.onAppleTap,
  }) : super(key: key);

  Widget _buildSocialIcon(String iconAsset, VoidCallback onPressed) {
    return IconButton(
      icon: Image.asset(
        iconAsset,
        height: AppResponsive.height(24),
        width: AppResponsive.width(24),
        errorBuilder:
            (context, error, stackTrace) => Icon(
          Icons.error,
          size: AppResponsive.height(24),
          color: AppColors.neutral400,
        ),
      ),
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon('assets/icons/google_icon.png', onGoogleTap),
        SizedBox(width: AppResponsive.width(20)),
        _buildSocialIcon('assets/icons/facebook_icon.png', onFacebookTap),
        SizedBox(width: AppResponsive.width(20)),
        _buildSocialIcon('assets/icons/apple_icon.png', onAppleTap),
      ],
    );
  }
}

class NavigationTextRow extends StatelessWidget {
  final String leadingText;
  final String actionText;
  final VoidCallback onActionPressed;
  final RobotoTextStyles textStyles;

  const NavigationTextRow({
    Key? key,
    required this.leadingText,
    required this.actionText,
    required this.onActionPressed,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          leadingText,
          style: textStyles.regular(color: AppColors.neutral700, fontSize: 14),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(4)),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: onActionPressed,
          child: Text(
            actionText,
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

class ScreenHeaderImagePlaceholder extends StatelessWidget {
  final double? height;
  final String placeholderText;

  const ScreenHeaderImagePlaceholder({
    Key? key,
    this.height,
    this.placeholderText = "Image Placeholder",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? AppResponsive.height(180),
      decoration: BoxDecoration(
        color: AppColors.neutral200,
        borderRadius: BorderRadius.circular(AppResponsive.height(12)),
      ),
      child: Center(
        child: Text(
          placeholderText,
          style: RobotoTextStyles().regular(
            color: AppColors.neutral500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class InstructionText extends StatelessWidget {
  final String text;
  final RobotoTextStyles textStyles;

  const InstructionText({
    Key? key,
    required this.text,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: textStyles.regular(color: AppColors.neutral800, fontSize: 16),
    );
  }
}