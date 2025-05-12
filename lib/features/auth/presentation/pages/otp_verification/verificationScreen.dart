import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/features/home/presentation/pages/home_screen.dart';
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
      if(mounted) _focusNode.requestFocus();
    });
  }

  void startTimer() { /* ... Same as your provided code ... */
    if (mounted) { setState(() { _canResendCode = false; _start = 60; _errorMessage = null;});}
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!mounted) { timer.cancel(); return;}
      if (_start == 0) { setState(() { _canResendCode = true; timer.cancel(); });
      } else { setState(() { _start--; });}
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); _pinController.dispose(); _focusNode.dispose(); super.dispose();
  }

  void _performOtpVerification(String otp) {
    FocusScope.of(context).unfocus();
    print("Verifying OTP: '$otp' for target: ${widget.verificationTarget} (Purpose: ${widget.purpose})");
    if (otp.length < 4) {
      if (mounted) { setState(() { _errorMessage = AppStrings.pleaseEnterAllDigits; });}
      return;
    }
    bool isOtpValid = true;
    if (!mounted) return;
    if (isOtpValid) {
      setState(() { _errorMessage = null; });
      print("OTP 'Verified' (Simulated Success)! Navigating...");
      if (widget.purpose == OtpVerificationPurpose.forgotPassword) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute( builder: (context) => CreateNewPasswordScreen(
            email: widget.verificationTarget ?? "unknown_email@example.com", otp: otp,),),);
      } else if (widget.purpose == OtpVerificationPurpose.signUp) {
        print("Sign Up OTP successful. Navigating to HomeScreen...");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false,
        );
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar( content: Text("Sign up OTP verified! Welcome!"),),);
      }
    }
  }

  void _handleResendCode() {
    if (_canResendCode) {
      print('Resending OTP for ${widget.verificationTarget} (Purpose: ${widget.purpose})...');
      _pinController.clear(); startTimer();
    }
  }

  void _navigateToSignIn() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {

    }
    print("Navigate to Sign In / Back from OTP error state");
  }

  // --- UI Helper Methods ---

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: Text(
        widget.purpose == OtpVerificationPurpose.forgotPassword
            ? AppStrings.forgotPassword
            : AppStrings.verification,
        style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
      ),
      centerTitle: true,
    );
  }

  Widget _buildInfoText() {
    String infoText = AppStrings.codeHasBeenSentTo;
    if (widget.verificationTarget != null && widget.verificationTarget!.isNotEmpty) {
      infoText += widget.verificationTarget!;
    } else {
      infoText += (widget.purpose == OtpVerificationPurpose.signUp)
          ? "your registered email/phone."
          : "the provided email.";
    }
    return Text(
      infoText,
      textAlign: TextAlign.center,
      style: _textStyles.regular(color: AppColors.neutral700, fontSize: 14),
    );
  }

  Widget _buildPinputSection() {
    final defaultPinTheme = PinTheme( /* ... Same as your provided code ... */
      width: AppResponsive.width(60), height: AppResponsive.height(60),
      textStyle: _textStyles.bold(color: AppColors.neutral900, fontSize: 24),
      decoration: BoxDecoration( color: AppColors.neutral100.withOpacity(0.7), borderRadius: BorderRadius.circular(AppResponsive.height(12)), border: Border.all(color: Colors.transparent),),);
    final focusedPinTheme = defaultPinTheme.copyWith( decoration: defaultPinTheme.decoration!.copyWith(border: Border.all(color: AppColors.primary500, width: 2)),);
    final submittedPinTheme = defaultPinTheme.copyWith( decoration: defaultPinTheme.decoration!.copyWith( border: Border.all( color: _errorMessage != null ? AppColors.primary600 : AppColors.primary300, width: 1.5)));
    final errorPinTheme = defaultPinTheme.copyWith( decoration: defaultPinTheme.decoration!.copyWith(border: Border.all(color: AppColors.primary600, width: 2)),);

    return Column(
      children: [
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
      ],
    );
  }

  Widget _buildResendCodeSection() {
    return Column(
      children: [
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
      ],
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
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
    );
  }

  Widget _buildBackToSignInButton() {
    // Conditionally built if error and purpose is forgotPassword
    if (_errorMessage != null && widget.purpose == OtpVerificationPurpose.forgotPassword) {
      return Column(
        children: [
          SizedBox(height: AppResponsive.height(20)),
          TextButton(
            onPressed: _navigateToSignIn, // You had this commented, I assumed it's needed.
            child: Text(
              AppStrings.backToSignIn,
              style: _textStyles.medium(color: AppColors.primary600, fontSize: 14),
            ),
          ),
        ],
      );
    }
    return const SizedBox.shrink(); // Return empty if not needed
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppResponsive.height(30)),
              _buildInfoText(),
              SizedBox(height: AppResponsive.height(32)),
              _buildPinputSection(),
              SizedBox(height: AppResponsive.height(24)),
              _buildResendCodeSection(),
              SizedBox(height: AppResponsive.height(40)),
              _buildVerifyButton(),
              _buildBackToSignInButton(),
              SizedBox(height: AppResponsive.height(30)),
            ],
          ),
        ),
      ),
    );
  }
}