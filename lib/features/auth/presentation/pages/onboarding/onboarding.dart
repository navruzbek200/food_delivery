import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import '../../../../../core/common/text_styles/app_textstyles.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';

// TODO: Import your Login/Registration screen
// import 'package:food_delivery/features/auth/presentation/pages/login_screen.dart'; // Example

// Data model for each onboarding page
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

  // List of onboarding items
  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      imagePath: 'assets/images/intr1.png', // TODO: Verify asset path
      title: 'Wide Selection',
      subtitle: 'More than 400 restaurants nationwide.',
    ),
    OnboardingItem(
      imagePath: 'assets/images/intr2.png', // TODO: Verify asset path
      title: 'Fast Delivery',
      subtitle: 'Receive goods after 10 minutes.',
    ),
    OnboardingItem(
      imagePath: 'assets/images/intr3.png', // TODO: Verify asset path
      title: 'Order Tracking',
      subtitle: 'Track your orders in real-time.',
    ),
    OnboardingItem(
      imagePath: 'assets/images/intr4.png', // TODO: Verify asset path
      title: 'Special Offers',
      subtitle: 'Weekly deals and discounts.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page?.round() != _currentPage) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPage < _onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Last page: Navigate to Login/Registration or main app
      _navigateToAuthScreen();
    }
  }

  void _onSkipPressed() {
    // Navigate to Login/Registration or main app
    _navigateToAuthScreen();
  }

  void _navigateToAuthScreen() {
    // TODO: Implement actual navigation
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (context) => const LoginScreen()), // Replace with your auth screen
    // );
    print("Navigating to Auth Screen...");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white, // Assuming a white background for pages
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button (Top Right - for first 3 pages)
            if (_currentPage < _onboardingItems.length -1) // Show skip only if not on the last page for the "Next" button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, right: 24.0),
                  child: TextButton(
                    onPressed: _onSkipPressed,
                    child: Text(
                      'Skip',
                      style: DynamicTextStyles.regular( // Or AppTextStyles.s16w400
                        color: AppColors.primary500, // Or a neutral color
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            else
              const SizedBox(height: 50), // Placeholder for consistent spacing when skip is not shown

            // PageView for Onboarding Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingItems.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_onboardingItems[index]);
                },
              ),
            ),

            // Page Indicator
            _buildPageIndicator(),
            const SizedBox(height: 30),

            // Buttons Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: _buildBottomButtons(),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build each onboarding page's content
  Widget _buildOnboardingPage(OnboardingItem item) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3, // Give more space to image
            child: Image.asset(
              item.imagePath,
              fit: BoxFit.contain, // Adjust fit as needed
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 100, color: AppColors.neutral300),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: DynamicTextStyles.semiBold( // Or AppTextStyles.s22w600
              color: AppColors.primary500, // Figma shows title in primary color
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            item.subtitle,
            textAlign: TextAlign.center,
            style: DynamicTextStyles.regular( // Or AppTextStyles.s16w400
              color: AppColors.neutral700, // Figma shows subtitle in a neutral color
              fontSize: 16,
              height: 1.4, // Line height
            ),
          ),
          const Spacer(flex: 1), // Pushes content up a bit
        ],
      ),
    );
  }

  // Widget to build the page indicator dots
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _onboardingItems.length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: _currentPage == index ? 24.0 : 8.0, // Active dot is wider
          decoration: BoxDecoration(
            color: _currentPage == index ? AppColors.primary500 : AppColors.primary200, // Active vs Inactive color
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }

  // Widget to build the bottom buttons (Next/Start Enjoying, Skip/Login)
  Widget _buildBottomButtons() {
    bool isLastPage = _currentPage == _onboardingItems.length - 1;

    if (isLastPage) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary500,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // Rounded button
                ),
              ),
              onPressed: _navigateToAuthScreen, // Changed from _onNextPressed for clarity
              child: Text(
                'Start enjoying',
                style: AppTextStyles.s18w600.copyWith(color: AppColors.white),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: _navigateToAuthScreen,
            child: Text(
              'Login / Registration',
              style: DynamicTextStyles.regular( // Or AppTextStyles.s16w400
                color: AppColors.primary600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    } else {
      // Buttons for first 3 pages
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary500,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25), // Rounded button
            ),
          ),
          onPressed: _onNextPressed,
          child: Text(
            'Next',
            style: AppTextStyles.s18w600.copyWith(color: AppColors.white),
          ),
        ),
      );
      // The Skip button is now at the top right for the first 3 pages.
      // If you prefer it at the bottom:
      /*
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: _onSkipPressed,
            child: Text(
              'Skip',
              style: DynamicTextStyles.regular(
                color: AppColors.primary500,
                fontSize: 16,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary500,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onPressed: _onNextPressed,
            child: Text(
              'Next',
              style: AppTextStyles.s18w600.copyWith(color: AppColors.white),
            ),
          ),
        ],
      );
      */
    }
  }
}