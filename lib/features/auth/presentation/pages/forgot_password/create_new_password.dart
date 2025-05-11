import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';

import '../../../../../core/common/text_styles/name_textstyles.dart';
import '../login/login.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const CreateNewPasswordScreen({
    Key? key,
    required this.email,
    required this.otp,
  }) : super(key: key);

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _textStyles = RobotoTextStyles();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _rememberMe = false;
  bool _isContinueEnabled = false;

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
      final newState = _newPasswordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          (_newPasswordController.text == _confirmPasswordController.text) &&
          _newPasswordController.text.length >= 6;
      if (_isContinueEnabled != newState) {
        setState(() { _isContinueEnabled = newState; });
      }
    }
  }

  void _toggleNewPasswordVisibility() {
    setState(() { _obscureNewPassword = !_obscureNewPassword; });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() { _obscureConfirmPassword = !_obscureConfirmPassword; });
  }

  void _handleCreateNewPassword() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      final newPassword = _newPasswordController.text;
      print('Attempting to create new password for email: ${widget.email} with OTP: ${widget.otp}');
      print('New Password value (for dev): $newPassword'); // Avoid logging actual password in prod

      // TODO: Implement actual API call to update the password here
      // Simulate success for now
      bool passwordUpdateSuccess = true;

      if (!mounted) return;

      if (passwordUpdateSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.passwordUpdatedSuccessfully)), // Ensure this string exists
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
        );
      }
    } else {
      print('Create new password form is invalid');
    }
  }

  InputDecoration _inputDecoration({required String hintText, required IconData prefixIcon, required bool obscureText, required VoidCallback onToggleVisibility}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: _textStyles.regular(color: AppColors.neutral400, fontSize: 14),
      prefixIcon: Icon(prefixIcon, color: AppColors.neutral400, size: AppResponsive.height(20)),
      suffixIcon: IconButton(
        icon: Icon( obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.neutral400,),
        onPressed: onToggleVisibility,
      ),
      filled: true, fillColor: AppColors.neutral100.withOpacity(0.5),
      contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(16), horizontal: AppResponsive.width(16)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: BorderSide.none,),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: BorderSide.none,),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: BorderSide(color: AppColors.primary300, width: 1.0),),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: BorderSide(color: AppColors.primary500, width: 1.0),),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: BorderSide(color: AppColors.primary500, width: 1.5),),
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
          style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
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
                SizedBox(height: AppResponsive.height(30)),
                Container(
                  width: double.infinity,
                  height: AppResponsive.height(180),
                  decoration: BoxDecoration(
                    color: AppColors.neutral200,
                    borderRadius: BorderRadius.circular(AppResponsive.height(12)),
                  ),
                  child: Center(
                    child: Text( "Image Placeholder", style: _textStyles.regular(color: AppColors.neutral500, fontSize: 16),),
                  ),
                ),
                SizedBox(height: AppResponsive.height(30)),
                Text(
                  AppStrings.createYourNewPassword,
                  textAlign: TextAlign.center,
                  style: _textStyles.regular(color: AppColors.neutral800, fontSize: 16),
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
                    if (value == null || value.isEmpty) return AppStrings.pleaseEnterPassword;
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
                    if (value == null || value.isEmpty) return AppStrings.pleaseConfirmPassword;
                    if (value != _newPasswordController.text) return AppStrings.passwordsDoNotMatch;
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _isContinueEnabled ? _handleCreateNewPassword() : null,
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isContinueEnabled ? AppColors.primary500 : AppColors.primary200,
                    padding: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppResponsive.height(28)),
                    ),
                    elevation: _isContinueEnabled ? 2 : 0,
                  ),
                  onPressed: _isContinueEnabled ? _handleCreateNewPassword : null,
                  child: Text(
                    AppStrings.continueText,
                    style: _textStyles.semiBold(color: AppColors.white, fontSize: 16),
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