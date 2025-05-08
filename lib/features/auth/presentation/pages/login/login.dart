import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart'; // Verify path

// Import SignUpScreen for navigation
import 'package:food_delivery/features/auth/presentation/pages/signup/sign_up.dart';

import '../../../../../core/common/text_styles/name_textstyles.dart'; // Verify path

// TODO: Import Forgot Password screen when created
// import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _textStyles = RobotoTextStyles();

  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isSignInEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateSignInButtonState);
    _passwordController.addListener(_updateSignInButtonState);
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateSignInButtonState);
    _passwordController.removeListener(_updateSignInButtonState);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateSignInButtonState() {
    // Basic check, can add more validation feedback later
    if (mounted) {
      setState(() {
        _isSignInEnabled = _emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;
      });
    }
  }

  void _togglePasswordVisibility() {
    setState(() { _obscurePassword = !_obscurePassword; });
  }

  // Placeholder for Login Logic
  void _handleLogin() {
    // Hide keyboard
    FocusScope.of(context).unfocus();
    // Validate form
    if (_formKey.currentState?.validate() ?? false) {
      print('Login Attempt: Email: ${_emailController.text}, Remember Me: $_rememberMe');
      // TODO: Implement actual login API call here
      // On success, navigate to main app screen (e.g., HomeScreen)
      // Example: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      // On failure, show error message (e.g., using ScaffoldMessenger or another state variable)
    } else {
      print('Login form is invalid');
      // Optionally show a generic error message if needed
    }
  }

  // Navigation to Registration
  void _navigateToRegister() {
    // Use push so the user can navigate back from SignUp to Login if desired
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()), // Ensure SignUpScreen exists and import path is correct
    );
    print("Navigate to Register Screen");
  }

  void _forgotPassword() {
    print("Forgot Password Tapped");
  }

  void _onContinueWithFacebook() {
    print("Continue with Facebook");
  }
  void _onContinueWithGoogle() {
    print("Continue with Google");
  }
  void _onContinueWithApple() {
    print("Continue with Apple");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppResponsive.height(40)),

                  Text(
                    AppStrings.login,
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
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _isSignInEnabled ? _handleLogin() : null,
                      ),
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
                          style: _textStyles.medium( color: AppColors.neutral800, fontSize: 14),
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
                        backgroundColor: _isSignInEnabled ? AppColors.primary500 : AppColors.primary200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppResponsive.height(28)),
                        ),
                        elevation: _isSignInEnabled ? 2 : 0,
                      ),
                      onPressed: _isSignInEnabled ? _handleLogin : null,
                      child: Text(
                        AppStrings.signIn,
                        style: _textStyles.semiBold(color: AppColors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: AppResponsive.height(16)),

                  TextButton(
                    onPressed: _forgotPassword,
                    child: Text(
                      AppStrings.forgotPassword,
                      style: _textStyles.medium( color: AppColors.primary500, fontSize: 14),
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
                            AppStrings.orSignIn,
                            style: _textStyles.regular( color: AppColors.neutral600, fontSize: 14),
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
                        AppStrings.dontHaveAccount,
                        style: _textStyles.regular(color: AppColors.neutral700, fontSize: 14),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(4)),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: _navigateToRegister,
                        child: Text(
                          AppStrings.register,
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