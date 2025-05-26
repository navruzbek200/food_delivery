import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import '../lets_in.dart';
import '../../widgets/onboarding_widget.dart';

class OnboardingItem {
  final String imagePath;
  final String title;
  final String subtitle;

  OnboardingItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final RobotoTextStyles _textStyles = RobotoTextStyles();

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      imagePath: 'assets/images/intr1.png',
      title: "Wide Selection",
      subtitle: "More than 400 restaurants nationwide.",
    ),
    OnboardingItem(
      imagePath: 'assets/images/intr3.png',
      title: "Order Tracking",
      subtitle: "Track your orders in real-time.",
    ),
    OnboardingItem(
      imagePath: 'assets/images/intr4.png',
      title: "Special Offers",
      subtitle: "Weekly deals and discounts.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final currentPage = _pageController.page?.round();
      if (currentPage != null && currentPage != _currentPage) {
        if (mounted) {
          setState(() {
            _currentPage = currentPage;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToLetsInScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LetsInScreen()),
    );
  }

  void _onNextPressed() {
    bool isLastContentPage = _currentPage == _onboardingItems.length - 1;

    if (isLastContentPage) {
      _navigateToLetsInScreen();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSkipPressed() {
    _navigateToLetsInScreen();
  }

  @override
  Widget build(BuildContext context) {
    bool isLastContentPage = _currentPage == _onboardingItems.length - 1;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: SkipButton(
                onPressed: _onSkipPressed,
                textStyles: _textStyles,
                visible: !isLastContentPage,
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingItems.length,
                onPageChanged: (int page) {
                  if (mounted) {
                    setState(() {
                      _currentPage = page;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return OnboardingPageContent(
                    item: _onboardingItems[index],
                    textStyles: _textStyles,
                  );
                },
              ),
            ),
            OnboardingPageIndicator(
              itemCount: _onboardingItems.length,
              currentPage: _currentPage,
            ),
            SizedBox(height: AppResponsive.height(30)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.width(24.0),
                vertical: AppResponsive.height(20.0),
              ),
              child: OnboardingNavigationButton(
                isLastPage: isLastContentPage,
                onPressed: _onNextPressed,
                textStyles: _textStyles,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
