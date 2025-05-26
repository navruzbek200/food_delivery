import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/routes/route_names.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/features/auth/presentation/bloc/auth_event.dart';
import 'package:food_delivery/features/auth/presentation/bloc/confirmEmail/confirmEmail_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/confirmEmail/confirmEmail_state.dart';
import 'package:food_delivery/features/auth/presentation/bloc/forgotPassword/forgot_password_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/resendCode/resend_code_bloc.dart';
import 'package:food_delivery/features/auth/presentation/bloc/resendCode/resend_code_state.dart';
import 'package:logger/logger.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';
import '../../bloc/login/login_bloc.dart';
import '../forgot_password/create_new_password.dart';
import '../../widgets/verification_widgets.dart';

enum OtpVerificationPurpose { signUp, forgotPassword }

class VerificationScreen extends StatefulWidget {
  final Map data;


  const VerificationScreen({
    super.key,
    required this.data,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();
  final _textStyles = RobotoTextStyles();
  var logger = Logger();

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
        setState(() {
          _canResendCode = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
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

    if (otp.length < 4) {
      if (mounted) {
        setState(() {
          _errorMessage = AppStrings.pleaseEnterAllDigits;
        });
      }
      return;
    }

    final int code = int.tryParse(otp) ?? 0;
    context.read<ConfirmEmailBloc>().add(ConfirmEmailEvent(code: code));
    context.read<ForgotPasswordBloc>().add(ForgotPasswordEvent(email: otp));
    context.read<ResendCodeBloc>().add(ResendCodeEvent(email: otp));
  }


  void _handleResendCode() {
    if (_canResendCode) {
      context.read<ResendCodeBloc>().add(
        ResendCodeEvent(email: widget.data["verificationTarget"] ?? ''),
      );
      print('Resending OTP for ${widget.data["verificationTarget"]}...');
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
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle =
    widget.data["purpose"] == OtpVerificationPurpose.forgotPassword
        ? AppStrings.forgotPassword
        : AppStrings.verification;

    String infoTextContent = AppStrings.codeHasBeenSentTo;
    if (widget.data["verificationTarget"] != null &&
        widget.data["verificationTarget"]!.isNotEmpty) {
      infoTextContent += widget.data["verificationTarget"]!;
    } else {
      infoTextContent += widget.data["purpose"] == OtpVerificationPurpose.signUp
          ? "your registered email/phone."
          : "the provided email.";
    }

    bool showBackToSignInButton =
        _errorMessage != null &&
            widget.data["purpose"]  == OtpVerificationPurpose.forgotPassword;

    return BlocListener<ConfirmEmailBloc, ConfirmEmailState>(
        listener: (context, state) {
          if (state is ConfirmEmailLoaded) {
              if (widget.data["purpose"] == OtpVerificationPurpose.signUp) {
                context.read<LoginBloc>().add(LoginEvent(
                    email: widget.data["verificationTarget"],
                    password: widget.data["password"]));
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteNames.homeScreen,
                      (route) => false,
                );
              } else if (widget.data["purpose"] == OtpVerificationPurpose.forgotPassword) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => CreateNewPasswordScreen()),
                );
              }
            }
          if (state is ConfirmEmailError) {
            setState(() {
              _errorMessage = "The code you entered is incorrect.";
            });
          }
        },

    child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon:
            const Icon(Icons.arrow_back_ios, color: AppColors.neutral800),
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
            padding:
            EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)),
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

                BlocConsumer<ResendCodeBloc, ResendCodeState>(
                    builder: (context, state) {
                      if(state is ResendCodeLoading){
                      }
                      return ResendCodeSection(
                        verificationTarget: widget.data["verificationTarget"] ?? '',
                        timerStartValue: _start,
                        canResend: _canResendCode,
                        onResendPressed: _handleResendCode,
                        textStyles: _textStyles,
                      );
                    },
                    listener: (context, state) {
                      if (state is ResendCodeLoaded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("The code has been sent again")),
                        );
                      }
                      if (state is ResendCodeError) {}
                    },
                ),

                SizedBox(height: AppResponsive.height(40)),

                BlocBuilder<ConfirmEmailBloc, ConfirmEmailState>(
                  builder: (context, state) {
                    if (state is ConfirmEmailLoading) {
                      return const CircularProgressIndicator();
                    }
                    return VerifyOtpButton(
                      isEnabled: _pinController.text.length == 4,
                      onPressed: () =>
                          _performOtpVerification(_pinController.text),
                      textStyles: _textStyles,
                    );
                  },
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
      ),
    );
  }
}
