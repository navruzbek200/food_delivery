import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';import 'package:food_delivery/features/auth/presentation/pages/onboarding/welcome.dart';
import '../../../../../core/common/text_styles/app_textstyles.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

enum LoadingStage { start, middle, done }

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  LoadingStage _currentStage = LoadingStage.start;

  late AnimationController _progressController;
  late AnimationController _logoController;
  late AnimationController _textController;

  late Animation<double> _progressAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _appNameOpacityAnimation;
  late Animation<double> _taglineOpacityAnimation;

  static const Color _backgroundColor = AppColors.primary500;

  static const Duration _progressSegmentDuration = Duration(seconds: 1);
  static const Duration _fadeDuration = Duration(milliseconds: 700);
  static const Duration _initialDelay = Duration(milliseconds: 300);
  static const Duration _finalScreenDelay = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      duration: _progressSegmentDuration * 2,
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _logoController = AnimationController(duration: _fadeDuration, vsync: this);
    _logoScaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    _textController = AnimationController(duration: _fadeDuration, vsync: this);
    _appNameOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );
    _taglineOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    _startLoadingAnimationSequence();
  }

  void _startLoadingAnimationSequence() async {
    await Future.delayed(_initialDelay);
    if (!mounted) return;

    _progressController.forward();

    await Future.delayed(_progressSegmentDuration);
    if (!mounted) return;
    setState(() { _currentStage = LoadingStage.middle; });
    _logoController.forward();
    _textController.forward();

    await Future.delayed(_progressSegmentDuration);
    if (!mounted) return;
    setState(() { _currentStage = LoadingStage.done; });

    await Future.delayed(_finalScreenDelay);
    if (!mounted) return;
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    if (!mounted) return;
    // Navigate to WelcomeScreen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
    print("Splash screen done, navigating to Welcome screen...");
  }

  @override
  void dispose() {
    _progressController.dispose();
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FadeTransition(
                  opacity: _logoOpacityAnimation,
                  child: ScaleTransition(
                    scale: _logoScaleAnimation,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: SizedBox(
                        width: 170,
                        height: 170,
                        child: Image.asset(
                          'assets/icons/logo.png',
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.fastfood, color: AppColors.white, size: 80);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _currentStage == LoadingStage.done ? _appNameOpacityAnimation.value : 0.0,
                  duration: _fadeDuration,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'SPEEDY CHOW',
                        style: DynamicTextStyles.bold(
                          color: AppColors.white,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Version 2.1.0',
                        style: DynamicTextStyles.regular(
                          color: AppColors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.12 + 30, left: 20, right: 20),
              child: AnimatedOpacity(
                opacity: _currentStage != LoadingStage.start ? _taglineOpacityAnimation.value : 0.0,
                duration: _fadeDuration,
                child: Text(
                  'As fast as lightning,\nas delicious as thunder!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.s16w400.copyWith(
                    color: AppColors.white,
                    height: 1.3,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: screenHeight * 0.08,
                left: screenWidth * 0.1,
                right: screenWidth * 0.1,
              ),
              child: Container(
                height: 6,
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 6,
                        width: (screenWidth * 0.8) * _progressAnimation.value,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}