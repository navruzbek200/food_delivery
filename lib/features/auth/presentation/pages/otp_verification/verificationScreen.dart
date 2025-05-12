import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/common/text_styles/name_textstyles.dart';
import '../forgot_password/create_new_password.dart';

enum OtpVerificationPurpose { signUp, forgotPassword }

class VerificationScreen extends StatefulWidget {
  final String? verificationTarget; 
  final OtpVerificationPurpose purpose; 
  const VerificationScreen({
    Key? key,
    this.verificationTarget,
    required this.purpose, required String verificationTargetEmail,
  }) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();
  final _textStyles = RobotoTextStyles();

  Timer? _timer;
  int _start = 60;
  bool _canResendCode = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void startTimer() {
    if (mounted) {
      setState(() {
        _canResendCode = false;
        _start = 60;
        _errorMessage = null;
      });
    }
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (Timer timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        if (_start == 0) {
          setState(() {
            _canResendCode = true;
            timer.cancel();
          });
        } else {
          setState(() { _start--; });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _performOtpVerification(String otp) {
    FocusScope.of(context).unfocus();
    print("Verifying OTP: '$otp' for target: ${widget.verificationTarget} (Purpose: ${widget.purpose})");

    if (otp.length < 4) {
      if (mounted) {
        setState(() { _errorMessage = AppStrings.pleaseEnterAllDigits; }); // Make sure this string exists
      }
      return;
    }

    // --- TEMPORARY: For UI testing, assume any 4-digit OTP is valid ---
    // TODO: Replace this with actual API call logic
    bool isOtpValid = true; // Simulate API success if 4 digits are entered

    if (!mounted) return;

    if (isOtpValid) {
      setState(() { _errorMessage = null; });
      print("OTP 'Verified' (Simulated Success)! Navigating...");

      if (widget.purpose == OtpVerificationPurpose.forgotPassword) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => CreateNewPasswordScreen(
              email: widget.verificationTarget ?? "unknown_email@example.com", // Ensure target is passed
              otp: otp,
            ),
          ),
        );
      } else if (widget.purpose == OtpVerificationPurpose.signUp) {
        // TODO: Navigate to the next screen after successful sign-up OTP
        print("Sign Up OTP successful. Navigate to next step (e.g., profile setup or home).");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign up OTP verified! (Placeholder navigation)")),
        );
      }
    } else {

    }
  }

  void _handleResendCode() {
    if (_canResendCode) {
      print('Resending OTP for ${widget.verificationTarget} (Purpose: ${widget.purpose})...');
      // TODO: Implement API call to resend OTP, potentially different endpoint based on purpose
      _pinController.clear();
      startTimer();
    }
  }

  void _navigateToSignIn() {
    // This is primarily for the "Forgot Password" flow if an error occurs and they want to go back
    // If it's a sign-up flow error, usually they just retry or contact support.
    if (widget.purpose == OtpVerificationPurpose.forgotPassword) {
      Navigator.of(context).popUntil((route) => route.isFirst); // Go to initial route
      // Then potentially push login if not already there or if stack was fully cleared
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
      print("Navigate to Sign In");
    } else {
      // For sign-up, maybe just pop back to sign-up screen
      if(Navigator.canPop(context)) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: AppResponsive.width(60),
      height: AppResponsive.height(60),
      textStyle: _textStyles.bold(color: AppColors.neutral900, fontSize: 24),
      decoration: BoxDecoration(
        color: AppColors.neutral100.withOpacity(0.7),
        borderRadius: BorderRadius.circular(AppResponsive.height(12)),
        border: Border.all(color: Colors.transparent),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(border: Border.all(color: AppColors.primary500, width: 2)),
    );
    // Submitted theme changes border color based on error state
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(
              color: _errorMessage != null ? AppColors.primary600 : AppColors.primary300,
              width: 1.5
          )
      ),
    );
    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(border: Border.all(color: AppColors.primary600, width: 2)),
    );

    String infoText = AppStrings.codeHasBeenSentTo;
    if (widget.verificationTarget != null && widget.verificationTarget!.isNotEmpty) {
      infoText += widget.verificationTarget!;
    } else {
      infoText += (widget.purpose == OtpVerificationPurpose.signUp)
          ? "your registered email/phone." // Generic for sign up
          : "the provided email."; // Generic for forgot password
    }


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
          // Title changes based on purpose
          widget.purpose == OtpVerificationPurpose.forgotPassword ? AppStrings.forgotPassword : AppStrings.verification,
          style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppResponsive.height(30)),
              Text(
                infoText,
                textAlign: TextAlign.center,
                style: _textStyles.regular(color: AppColors.neutral700, fontSize: 14),
              ),
              SizedBox(height: AppResponsive.height(32)),

              Pinput(
                controller: _pinController,
                focusNode: _focusNode,
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                errorPinTheme: errorPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                showCursor: true,
                onCompleted: (pin) => _performOtpVerification(pin),
                forceErrorState: _errorMessage != null,
              ),
              SizedBox(height: AppResponsive.height(8)),
              if (_errorMessage != null)
                Padding(
                  padding: EdgeInsets.only(top: AppResponsive.height(8.0)),
                  child: Text(
                    _errorMessage!,
                    style: _textStyles.regular(color: AppColors.primary600, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              SizedBox(height: AppResponsive.height(24)),

              Text(
                AppStrings.didntReceiveCode,
                style: _textStyles.regular(color: AppColors.neutral700, fontSize: 14),
              ),
              SizedBox(height: AppResponsive.height(12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time, color: AppColors.neutral500, size: AppResponsive.height(18)),
                  SizedBox(width: AppResponsive.width(8)),
                  Text(
                    "00:${_start.toString().padLeft(2, '0')}",
                    style: _textStyles.semiBold(color: AppColors.primary500, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: AppResponsive.height(12)),
              TextButton(
                onPressed: _canResendCode ? _handleResendCode : null,
                child: Text(
                  AppStrings.resendCode,
                  style: _textStyles.semiBold(
                    color: _canResendCode ? AppColors.primary500 : AppColors.neutral400,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: AppResponsive.height(40)),

              SizedBox(
                width: AppResponsive.width(345),
                height: AppResponsive.height(53),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _pinController.text.length == 4 ? AppColors.primary500 : AppColors.primary200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppResponsive.height(28)),
                    ),
                  ),
                  onPressed: _pinController.text.length == 4 ? () => _performOtpVerification(_pinController.text) : null,
                  child: Text(
                    AppStrings.verify,
                    style: _textStyles.semiBold(color: AppColors.white, fontSize: 16),
                  ),
                ),
              ),
              // Show "Back to Sign In" only if it's for forgot password and there's an error
              if (_errorMessage != null && widget.purpose == OtpVerificationPurpose.forgotPassword) ...[
                SizedBox(height: AppResponsive.height(20)),
                TextButton(
                  onPressed: _navigateToSignIn,
                  child: Text(
                    AppStrings.backToSignIn,
                    style: _textStyles.medium(color: AppColors.primary600, fontSize: 14),
                  ),
                ),
              ],
              SizedBox(height: AppResponsive.height(30)),
            ],
          ),
        ),
      ),
    );
  }
}