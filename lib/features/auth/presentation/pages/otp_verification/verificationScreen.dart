import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/features/home/presentation/pages/home_screen.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';
import '../forgot_password/create_new_password.dart';
import '../../widgets/verification_widgets.dart';

enum OtpVerificationPurpose { signUp, forgotPassword }

class VerificationScreen extends StatefulWidget {
  final String? verificationTarget;
  final OtpVerificationPurpose purpose;


  const VerificationScreen({
    Key? key,
    this.verificationTarget,
    required this.purpose,
    // required String verificationTargetEmail,
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
      if (mounted) _focusNode.requestFocus();
    });
    _pinController.addListener(() {
      if (mounted) {
        setState(() {});
      }
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
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_start == 0) {
        if (mounted) {
          setState(() {
            _canResendCode = true;
            timer.cancel();
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _start--;
          });
        }
      }
    });
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
    print(
      "Verifying OTP: '$otp' for target: ${widget.verificationTarget} (Purpose: ${widget.purpose})",
    );

    if (otp.length < 4) {
      if (mounted) {
        setState(() {
          _errorMessage = AppStrings.pleaseEnterAllDigits;
        });
      }
      return;
    }

    bool isOtpValid = true;

    if (!mounted) return;

    if (isOtpValid) {
      setState(() {
        _errorMessage = null;
      });
      print("OTP 'Verified' (Simulated Success)! Navigating...");
      if (widget.purpose == OtpVerificationPurpose.forgotPassword) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder:
                (context) => CreateNewPasswordScreen(
                ),
          ),
        );
      } else if (widget.purpose == OtpVerificationPurpose.signUp) {
        print("Sign Up OTP successful. Navigating to HomeScreen...");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sign up OTP verified! Welcome!"), // Yaxshiroq xabar
          ),
        );
      }
    }
  }

  void _handleResendCode() {
    if (_canResendCode) {
      print(
        'Resending OTP for ${widget.verificationTarget} (Purpose: ${widget.purpose})...',
      );
      _pinController.clear();
      startTimer();
    }
  }

  void _navigateToSignIn() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      print("Cannot pop, no previous route.");
    }
    print("Navigate to Sign In / Back from OTP error state");
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle =
        widget.purpose == OtpVerificationPurpose.forgotPassword
            ? AppStrings.forgotPassword
            : AppStrings.verification;

    String infoTextContent = AppStrings.codeHasBeenSentTo;
    if (widget.verificationTarget != null &&
        widget.verificationTarget!.isNotEmpty) {
      infoTextContent += widget.verificationTarget!;
    } else {
      infoTextContent +=
          (widget.purpose == OtpVerificationPurpose.signUp)
              ? "your registered email/phone."
              : "the provided email.";
    }

    bool showBackToSignInButton =
        _errorMessage != null &&
        widget.purpose == OtpVerificationPurpose.forgotPassword;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: VerificationAppBarTitle(
          titleText: appBarTitle,
          textStyles: _textStyles,
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
              VerificationInfoText(
                infoText: infoTextContent,
                textStyles: _textStyles,
              ),
              SizedBox(height: AppResponsive.height(32)),
              OtpPinput(
                controller: _pinController,
                focusNode: _focusNode,
                onCompleted: _performOtpVerification,
                forceErrorState: _errorMessage != null,
                errorMessage: _errorMessage,
                textStyles: _textStyles,
              ),
              SizedBox(height: AppResponsive.height(24)),
              ResendCodeSection(
                timerStartValue: _start,
                canResend: _canResendCode,
                onResendPressed: _handleResendCode,
                textStyles: _textStyles,
              ),
              SizedBox(height: AppResponsive.height(40)),
              VerifyOtpButton(
                isEnabled: _pinController.text.length == 4,
                onPressed: () => _performOtpVerification(_pinController.text),
                textStyles: _textStyles,
              ),
              if (showBackToSignInButton)
                Padding(
                  padding: EdgeInsets.only(top: AppResponsive.height(20)),
                  child: BackToSignInTextButton(
                    onPressed: _navigateToSignIn,
                    textStyles: _textStyles,
                  ),
                ),
              SizedBox(height: AppResponsive.height(30)),
            ],
          ),
        ),
      ),
    );
  }
}
