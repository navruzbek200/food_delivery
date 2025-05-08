import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';
import '../lets_in.dart';


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
      title: AppStrings.wideSelection,
      subtitle: AppStrings.wideSelectionSubtitle,
    ),
    OnboardingItem(
      imagePath: 'assets/images/intr3.png',
      title: AppStrings.orderTracking,
      subtitle: AppStrings.trackYourOrdersRealTime,
    ),
    OnboardingItem(
      imagePath: 'assets/images/intr4.png',
      title: AppStrings.specialOffers,
      subtitle: AppStrings.specialOffersSubtitle,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final currentPage = _pageController.page?.round();
      if (currentPage != null && currentPage != _currentPage) {
        if (mounted) {
          setState(() { _currentPage = currentPage; });
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
    print("Navigating to Let's In Screen...");
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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Visibility(
                visible: _currentPage < _onboardingItems.length - 1,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Padding(
                  padding: EdgeInsets.only(top: AppResponsive.height(16.0), right: AppResponsive.width(24.0)),
                  child: TextButton(
                    onPressed: _onSkipPressed,
                    child: Text(
                      AppStrings.skip,
                      style: _textStyles.regular(
                        color: AppColors.primary500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingItems.length,
                itemBuilder: (context, index) {
                  return _buildContentPage(_onboardingItems[index]);
                },
              ),
            ),

            _buildPageIndicator(),
            SizedBox(height: AppResponsive.height(30)),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.width(24.0),
                vertical: AppResponsive.height(20.0),
              ),
              child: _buildBottomButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentPage(OnboardingItem item) {
    return Padding(
      padding: EdgeInsets.all(AppResponsive.width(24.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          Expanded(
            flex: 4,
            child: Image.asset(
              item.imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.image_not_supported,
                size: AppResponsive.height(100),
                color: AppColors.neutral300,
              ),
            ),
          ),
          SizedBox(height: AppResponsive.height(40)),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: _textStyles.semiBold(
              color: AppColors.primary500,
              fontSize: 22,
            ),
          ),
          SizedBox(height: AppResponsive.height(16)),
          Text(
            item.subtitle,
            textAlign: TextAlign.center,
            style: _textStyles.regular(
              color: AppColors.neutral700,
              fontSize: 16,
            ).copyWith(height: 1.4),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _onboardingItems.length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: AppResponsive.width(4.0)),
          height: AppResponsive.height(8.0),
          width: _currentPage == index ? AppResponsive.width(24.0) : AppResponsive.width(8.0),
          decoration: BoxDecoration(
            color: _currentPage == index ? AppColors.primary500 : AppColors.primary200,
            borderRadius: BorderRadius.circular(AppResponsive.height(4.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    bool isLastContentPage = _currentPage == _onboardingItems.length - 1;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary500,
          padding: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppResponsive.height(25)),
          ),
        ),
        onPressed: _onNextPressed,
        child: Text(
          isLastContentPage ? AppStrings.startEnjoying : AppStrings.next,
          style: _textStyles.semiBold(color: AppColors.white, fontSize: 18),
        ),
      ),
    );
  }
}