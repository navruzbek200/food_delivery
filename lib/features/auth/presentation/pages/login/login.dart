import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/features/auth/presentation/pages/signup/sign_up.dart';
import 'package:food_delivery/features/auth/presentation/pages/forgot_password/forgot_password.dart';
import 'package:food_delivery/features/home/presentation/pages/home_screen.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';
import '../../widgets/login_widgets.dart';

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
    if (mounted) {
      final newState =
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
      if (_isSignInEnabled != newState) {
        setState(() {
          _isSignInEnabled = newState;
        });
      }
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _handleLogin() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      print(
        'Login Attempt: Email: ${_emailController.text}, Remember Me: $_rememberMe',
      );
      bool loginSuccess = true;
      if (!mounted) return;
      if (loginSuccess) {
        print("Login successful! Navigating to HomeScreen...");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false,
        );
      }
    } else {
      print('Login form is invalid');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.pleaseFillAllFieldsCorrectly)),
      );
    }
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
    print("Navigate to Register Screen");
  }

  void _forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
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
            padding: EdgeInsets.symmetric(
              horizontal: AppResponsive.width(24.0),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppResponsive.height(40)),
                  LoginTitle(textStyles: _textStyles),
                  SizedBox(height: AppResponsive.height(40)),
                  EmailTextFormField(
                    controller: _emailController,
                    textStyles: _textStyles,
                  ),
                  SizedBox(height: AppResponsive.height(20)),
                  PasswordTextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    onToggleVisibility: _togglePasswordVisibility,
                    textStyles: _textStyles,
                    hintText: AppStrings.password,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return AppStrings.pleaseEnterPassword;
                      if (value.length < 6) return AppStrings.passwordTooShort;
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      if (_isSignInEnabled) {
                        _handleLogin();
                      }
                    },
                  ),
                  SizedBox(height: AppResponsive.height(20)),
                  RememberMeCheckbox(
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                    textStyles: _textStyles,
                  ),
                  SizedBox(height: AppResponsive.height(30)),
                  PrimaryElevatedButton(
                    buttonText: AppStrings.signIn,
                    isEnabled: _isSignInEnabled,
                    onPressed: _handleLogin,
                    textStyles: _textStyles,
                  ),
                  SizedBox(height: AppResponsive.height(16)),
                  ForgotPasswordButton(
                    onPressed: _forgotPassword,
                    textStyles: _textStyles,
                  ),
                  SizedBox(height: AppResponsive.height(30)),
                  OrDividerWithText(
                    text: AppStrings.orSignIn,
                    textStyles: _textStyles,
                  ),
                  SizedBox(height: AppResponsive.height(20)),
                  SocialLoginIcons(
                    onGoogleTap: _onContinueWithGoogle,
                    onFacebookTap: _onContinueWithFacebook,
                    onAppleTap: _onContinueWithApple,
                  ),
                  SizedBox(height: AppResponsive.height(40)),
                  NavigationTextRow(
                    leadingText: AppStrings.dontHaveAccount,
                    actionText: AppStrings.register,
                    onActionPressed: _navigateToRegister,
                    textStyles: _textStyles,
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
}
