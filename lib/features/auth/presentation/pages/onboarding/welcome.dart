import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';
import 'onboarding.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Timer? _timer;
  static const Duration _navigationDelay = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _startNavigationTimer();
  }

  void _startNavigationTimer() {
    _timer = Timer(_navigationDelay, _navigateToNextScreen);
  }

  void _navigateToNextScreen() {
    if (!mounted) return;
    // Navigate to OnboardingScreen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const OnboardingScreen()), // MODIFIED HERE
    );
    print("Welcome screen done, navigating to Onboarding screen..."); // MODIFIED HERE
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/welcome.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: AppColors.primary700);
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.7],
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.15,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to',
                    textAlign: TextAlign.center,
                    style: DynamicTextStyles.regular(
                      color: AppColors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SPEEDY CHOW',
                    textAlign: TextAlign.center,
                    style: DynamicTextStyles.bold(
                      color: AppColors.white,
                      fontSize: 36,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}