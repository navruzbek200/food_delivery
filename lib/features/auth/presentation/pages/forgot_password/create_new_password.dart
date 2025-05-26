import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/features/auth/presentation/bloc/resetPassword/reset_password_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/resetPassword/reset_password_state.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';
import '../../bloc/auth_event.dart';
import '../login/login.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _textStyles = RobotoTextStyles();


  bool _isResetPasswordEnabled = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _rememberMe = false;
  bool _isContinueEnabled = false;

  final String _illustrationPath =
      'assets/images/auth/create_password_illustration.png';
  final String _congratsImagePath = 'assets/images/payment_successful.png';

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_updateButtonState);
    _confirmPasswordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _newPasswordController.removeListener(_updateButtonState);
    _confirmPasswordController.removeListener(_updateButtonState);
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    if (mounted) {
      final newState =
          _newPasswordController.text.isNotEmpty &&
              _confirmPasswordController.text.isNotEmpty &&
              (_newPasswordController.text == _confirmPasswordController.text) &&
              _newPasswordController.text.length >= 6;
      if (_isContinueEnabled != newState) {
        setState(() {
          _isContinueEnabled = newState;
        });
      }
    }
  }

  void _toggleNewPasswordVisibility() {
    setState(() {
      _obscureNewPassword = !_obscureNewPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(AppResponsive.width(24)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppResponsive.height(16)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                _congratsImagePath,
                height: AppResponsive.height(120),
              ),
              SizedBox(height: AppResponsive.height(24)),
              Text(
                AppStrings.congratulations,
                style: _textStyles.bold(
                  fontSize: 20,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppResponsive.height(8)),
              Text(
                AppStrings.passwordChangedSuccessLogin,
                style: _textStyles.regular(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppResponsive.height(24)),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary500,
                    padding: EdgeInsets.symmetric(
                      vertical: AppResponsive.height(14),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppResponsive.height(25),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    AppStrings.okGreat,
                    style: _textStyles.semiBold(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateResetPasswordButtonState() {
    if (mounted) {
      final isValidEmail = RegExp(r'\S+@\S+\.\S+').hasMatch(_emailController.text);
      final isValidPassword = _newPasswordController.text.length >= 6;
      final newState = _emailController.text.isNotEmpty &&
          _newPasswordController.text.isNotEmpty &&
          isValidEmail &&
          isValidPassword;
      if (_isResetPasswordEnabled != newState) {
        setState(() {
          _isResetPasswordEnabled = newState;
        });
      }
    }
  }

  void _handleCreateNewPassword() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      final newPassword = _newPasswordController.text;
      print('New Password value (for dev): $newPassword');
      bool passwordUpdateSuccess = true;

      if (!mounted) return;
      if (passwordUpdateSuccess) {
        _showCongratulationsDialog();
      }
    } else {
      print('Create new password form is invalid');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.pleaseFillAllFieldsCorrectly)),
      );
    }
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: _textStyles.regular(color: AppColors.neutral400, fontSize: 14),
      prefixIcon: Icon(
        prefixIcon,
        color: AppColors.neutral400,
        size: AppResponsive.height(20),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.neutral400,
        ),
        onPressed: onToggleVisibility,
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
          AppStrings.createNewPassword,
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
              children: [
                SizedBox(height: AppResponsive.height(30)),
                SizedBox(
                  width: double.infinity,
                  height: AppResponsive.height(180),
                  child: Image.asset(
                    _illustrationPath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.neutral100,
                          borderRadius: BorderRadius.circular(
                            AppResponsive.height(12),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.neutral400,
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: AppResponsive.height(30)),
                Text(
                  AppStrings.createYourNewPassword,
                  textAlign: TextAlign.center,
                  style: _textStyles.regular(
                    color: AppColors.neutral800,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: AppResponsive.height(24)),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: AppStrings.email,
                    prefixIcon: Icon(Icons.email_outlined, color: AppColors.neutral400),
                    hintStyle: _textStyles.regular(color: AppColors.neutral400, fontSize: 14),
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
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.pleaseEnterEmail;
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),

                SizedBox(height: AppResponsive.height(24)),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: _obscureNewPassword,
                  decoration: _inputDecoration(
                    hintText: AppStrings.newPassword,
                    prefixIcon: Icons.lock_outline,
                    obscureText: _obscureNewPassword,
                    onToggleVisibility: _toggleNewPasswordVisibility,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppStrings.pleaseEnterPassword;
                    if (value.length < 6) return AppStrings.passwordTooShort;
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: AppResponsive.height(20)),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: _inputDecoration(
                    hintText: AppStrings.confirmNewPassword,
                    prefixIcon: Icons.lock_outline,
                    obscureText: _obscureConfirmPassword,
                    onToggleVisibility: _toggleConfirmPasswordVisibility,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.pleaseConfirmPassword;
                    }
                    if (value != _newPasswordController.text) {
                      return AppStrings.passwordsDoNotMatch;
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted:
                      (_) =>
                  _isContinueEnabled
                      ? _handleCreateNewPassword()
                      : null,
                ),
                SizedBox(height: AppResponsive.height(20)),
                InkWell(
                  onTap: () {
                    setState(() {
                      _rememberMe = !_rememberMe;
                    });
                  },
                  splashColor: AppColors.primary100,
                  highlightColor: AppColors.primary100,
                  child: Row(
                    children: [
                      SizedBox(
                        width: AppResponsive.width(24),
                        height: AppResponsive.height(24),
                        child: Checkbox(
                          value: _rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                          activeColor: AppColors.primary500,
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          side: BorderSide(
                            color:
                            _rememberMe
                                ? AppColors.primary500
                                : AppColors.neutral300,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppResponsive.height(4),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: AppResponsive.width(12)),
                      Text(
                        AppStrings.rememberMe,
                        style: _textStyles.medium(
                          color: AppColors.neutral800,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppResponsive.height(30)),

                BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
                    builder: (context, state) {
                      if(state is ResetPasswordLoading){
                        return CircularProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_newPasswordController.text == _confirmPasswordController.text) {
                            context.read<ResetPasswordBloc>().add(
                                ResetPasswordEvent(
                                  email: _emailController.text,
                                  password: _newPasswordController.text,
                                )
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppStrings.passwordsDoNotMatch),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity,50),
                          backgroundColor:
                          _isContinueEnabled
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
                          elevation: _isContinueEnabled ? 2 : 0,
                        ),
                        child: Text(
                          AppStrings.continueText,
                          style: _textStyles.semiBold(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                      );
                    },
                    listener: (context, state) {
                      if(state is ResetPasswordLoaded){
                        _showCongratulationsDialog();
                      }
                      if(state is ResetPasswordError){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error is occured")),
                        );
                      }
                    },
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