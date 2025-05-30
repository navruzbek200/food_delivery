import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/routes/route_names.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/features/auth/presentation/pages/signup/sign_up.dart';
import 'package:food_delivery/features/auth/presentation/pages/forgot_password/forgot_password.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_state.dart';
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

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  bool _password = true;
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isSignInEnabled = false;
  bool _text_field_1_color = false;
  bool _text_field_2_color = false;


  @override
  void initState() {
    super.initState();

    focusNode1.addListener(() {
      setState(() {
        _text_field_1_color = focusNode1.hasFocus;
      });
    });
    focusNode2.addListener(() {
      setState(() {
        _text_field_2_color = focusNode2.hasFocus;
      });
    });

    _emailController.addListener(_updateSignInButtonState);
    _passwordController.addListener(_updateSignInButtonState);
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateSignInButtonState);
    _passwordController.removeListener(_updateSignInButtonState);
    _emailController.dispose();
    _passwordController.dispose();

    focusNode1.dispose();
    focusNode2.dispose();
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
      logIn();
      print(
        'Login Attempt: Email: ${_emailController.text}, Remember Me: $_rememberMe',
      );
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

  void logIn(){
    context.read<LoginBloc>().add(LoginEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim()),);
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
                    key: Key('emailField'),
                    controller: _emailController,
                    textStyles: _textStyles,
                  ),
                  SizedBox(height: AppResponsive.height(20)),
                  PasswordTextFormField(
                    key: Key('passwordField'),
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

                  BlocConsumer<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoading) {
                            return CircularProgressIndicator();
                        }
                        return PrimaryElevatedButton(
                          key: Key('loginButton'),
                          buttonText: AppStrings.signIn,
                          isEnabled: _isSignInEnabled,
                          onPressed: _handleLogin,
                          textStyles: _textStyles,
                        );
                      },
                      listener: (context, state) {
                        if(state is LoginLoaded){
                          Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
                        }
                        if(state is LoginError){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error is occured")),
                          );
                        }
                      },
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
