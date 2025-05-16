import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';
import '../otp_verification/verificationScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _textStyles = RobotoTextStyles();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateButtonState);
    _emailController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    if (mounted) {
      final newState =
          _emailController.text.isNotEmpty &&
          RegExp(r'\S+@\S+\.\S+').hasMatch(_emailController.text);
      if (_isButtonEnabled != newState) {
        setState(() {
          _isButtonEnabled = newState;
        });
      }
    }
  }

  // In _ForgotPasswordScreenState class
  void _handleSendCode() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;
      print('Sending password reset code to: $email');
      // TODO: Implement API call

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => VerificationScreen(
                verificationTarget: email,
                purpose: OtpVerificationPurpose.forgotPassword,
              ),
        ),
      );
    } else {
      print('Email form is invalid on Forgot Password Screen');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(AppStrings.pleaseEnterValidEmail)));
    }
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: _textStyles.regular(color: AppColors.neutral400, fontSize: 14),
      prefixIcon: Icon(
        prefixIcon,
        color: AppColors.neutral400,
        size: AppResponsive.height(20),
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          AppStrings.forgotPassword,
          style: _textStyles.semiBold(
            color: AppColors.neutral900,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: AppResponsive.height(40)),
                Text(
                  AppStrings.enterEmailForVerificationCode,
                  textAlign: TextAlign.center,
                  style: _textStyles.regular(
                    color: AppColors.neutral700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: AppResponsive.height(30)),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration(
                    hintText: AppStrings.email,
                    prefixIcon: Icons.email_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.pleaseEnterEmail;
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return AppStrings.pleaseEnterValidEmail;
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted:
                      (_) => _isButtonEnabled ? _handleSendCode() : null,
                ),
                SizedBox(height: AppResponsive.height(40)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isButtonEnabled
                            ? AppColors.primary500
                            : AppColors.primary200,
                    padding: EdgeInsets.symmetric(
                      vertical: AppResponsive.height(16),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppResponsive.height(28),
                      ),
                    ),
                    elevation: _isButtonEnabled ? 2 : 0,
                  ),
                  onPressed: _isButtonEnabled ? _handleSendCode : null,
                  child: Text(
                    AppStrings.resendCode,
                    style: _textStyles.semiBold(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
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
