import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';
import '../login/login.dart';
import '../otp_verification/verificationScreen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _textStyles = RobotoTextStyles();

  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isRegisterEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateRegisterButtonState);
    _passwordController.addListener(_updateRegisterButtonState);
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateRegisterButtonState);
    _passwordController.removeListener(_updateRegisterButtonState);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateRegisterButtonState() {
    if (mounted) {
      final newState = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
      if (_isRegisterEnabled != newState) {
        setState(() {
          _isRegisterEnabled = newState;
        });
      }
    }
  }

  void _togglePasswordVisibility() {
    setState(() { _obscurePassword = !_obscurePassword; });
  }


  // In _SignUpScreenState class
  void _handleRegister() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      print('Registration Attempt:');
      print('Email: ${_emailController.text}');
      // ... other prints ...

      // TODO: Implement actual registration API call/logic here
      // If API call is successful:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationScreen(
            verificationTarget: _emailController.text,
            purpose: OtpVerificationPurpose.signUp, verificationTargetEmail: 'navrozbekbektemirov7@gmail.com', // <<< ADD THIS LINE
          ),
        ),
      );
    } else {
      print('Registration form is invalid');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.pleaseFillAllFieldsCorrectly)), // Make sure this string exists
      );
    }
  }
  void _navigateToLogin() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
    print("Navigate to Login Screen");
  }

  void _onContinueWithFacebook() => print("Sign Up with Facebook");
  void _onContinueWithGoogle() => print("Sign Up with Google");
  void _onContinueWithApple() => print("Sign Up with Apple");

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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.registration,
                    style: _textStyles.bold(
                      color: AppColors.primary500,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: AppResponsive.height(40)),

                  Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDecoration(
                          hintText: AppStrings.email,
                          prefixIcon: Icons.email_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return AppStrings.pleaseEnterEmail;
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return AppStrings.pleaseEnterValidEmail;
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: AppResponsive.height(20)),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: _inputDecoration(
                          hintText: AppStrings.password,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: AppColors.neutral400,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return AppStrings.pleaseEnterPassword;
                          if (value.length < 6) return AppStrings.passwordTooShort;
                          return null;
                        },
                        textInputAction: TextInputAction.done, // Change to next if confirm password is added
                        onFieldSubmitted: (_) => _isRegisterEnabled ? _handleRegister() : null,
                      ),
                      // TODO: Add Confirm Password Field here if needed
                    ],
                  ),
                  SizedBox(height: AppResponsive.height(20)),

                  InkWell(
                    onTap: () { setState(() { _rememberMe = !_rememberMe; }); },
                    splashColor: AppColors.primary100,
                    highlightColor: AppColors.primary100,
                    child: Row(
                      children: [
                        SizedBox(
                          width: AppResponsive.width(24),
                          height: AppResponsive.height(24),
                          child: Checkbox(
                            value: _rememberMe,
                            onChanged: (bool? value) { setState(() { _rememberMe = value ?? false; }); },
                            activeColor: AppColors.primary500,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            side: BorderSide(color: _rememberMe ? AppColors.primary500 : AppColors.neutral300),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(4))),
                          ),
                        ),
                        SizedBox(width: AppResponsive.width(12)),
                        Text(
                          AppStrings.rememberMe,
                          style: _textStyles.medium(color: AppColors.neutral800, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppResponsive.height(30)),

                  SizedBox(
                    width: AppResponsive.width(345),
                    height: AppResponsive.height(53),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isRegisterEnabled ? AppColors.primary500 : AppColors.primary200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppResponsive.height(28)),
                        ),
                        elevation: _isRegisterEnabled ? 2 : 0,
                      ),
                      onPressed: _isRegisterEnabled ? _handleRegister : null,
                      child: Text(
                        AppStrings.register,
                        style: _textStyles.semiBold(color: AppColors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: AppResponsive.height(30)),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(20)),
                    child: Row(
                      children: [
                        const Expanded(child: Divider(color: AppColors.neutral200, thickness: 1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16)),
                          child: Text(
                            AppStrings.orSignUp,
                            style: _textStyles.regular(color: AppColors.neutral600, fontSize: 14),
                          ),
                        ),
                        const Expanded(child: Divider(color: AppColors.neutral200, thickness: 1)),
                      ],
                    ),
                  ),
                  SizedBox(height: AppResponsive.height(20)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon('assets/icons/google_icon.png', _onContinueWithGoogle),
                      SizedBox(width: AppResponsive.width(20)),
                      _buildSocialIcon('assets/icons/facebook_icon.png', _onContinueWithFacebook),
                      SizedBox(width: AppResponsive.width(20)),
                      _buildSocialIcon('assets/icons/apple_icon.png', _onContinueWithApple),
                    ],
                  ),
                  SizedBox(height: AppResponsive.height(40)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.alreadyHaveAccount,
                        style: _textStyles.regular(color: AppColors.neutral700, fontSize: 14),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(4)),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: _navigateToLogin,
                        child: Text(
                          AppStrings.signIn,
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
      ),
    );
  }

  InputDecoration _inputDecoration({required String hintText, required IconData prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: _textStyles.regular(color: AppColors.neutral400, fontSize: 14),
      prefixIcon: Icon(prefixIcon, color: AppColors.neutral400, size: AppResponsive.height(20)),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.neutral100.withOpacity(0.5),
      contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(16), horizontal: AppResponsive.width(16)),
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

  Widget _buildSocialIcon(String iconAsset, VoidCallback onPressed) {
    return IconButton(
      icon: Image.asset(
        iconAsset,
        height: AppResponsive.height(24),
        width: AppResponsive.width(24),
        errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: AppResponsive.height(24), color: AppColors.neutral400),
      ),
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}