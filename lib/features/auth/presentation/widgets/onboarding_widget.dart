import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

import '../pages/onboarding/onboarding.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnboardingItem item;
  final RobotoTextStyles textStyles;

  const OnboardingPageContent({
    Key? key,
    required this.item,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              errorBuilder:
                  (context, error, stackTrace) => Icon(
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
            style: textStyles.semiBold(
              color: AppColors.primary500,
              fontSize: 22,
            ),
          ),
          SizedBox(height: AppResponsive.height(16)),
          Text(
            item.subtitle,
            textAlign: TextAlign.center,
            style: textStyles
                .regular(color: AppColors.neutral700, fontSize: 16)
                .copyWith(height: 1.4),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class OnboardingPageIndicator extends StatelessWidget {
  final int itemCount;
  final int currentPage;

  const OnboardingPageIndicator({
    Key? key,
    required this.itemCount,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: AppResponsive.width(4.0)),
          height: AppResponsive.height(8.0),
          width:
              currentPage == index
                  ? AppResponsive.width(24.0)
                  : AppResponsive.width(8.0),
          decoration: BoxDecoration(
            color:
                currentPage == index
                    ? AppColors.primary500
                    : AppColors.primary200,
            borderRadius: BorderRadius.circular(AppResponsive.height(4.0)),
          ),
        ),
      ),
    );
  }
}

class OnboardingNavigationButton extends StatelessWidget {
  final bool isLastPage;
  final VoidCallback onPressed;
  final RobotoTextStyles textStyles;

  const OnboardingNavigationButton({
    Key? key,
    required this.isLastPage,
    required this.onPressed,
    required this.textStyles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        onPressed: onPressed,
        child: Text(
          isLastPage ? AppStrings.startEnjoying : AppStrings.next,
          style: textStyles.semiBold(color: AppColors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;
  final RobotoTextStyles textStyles;
  final bool visible;

  const SkipButton({
    Key? key,
    required this.onPressed,
    required this.textStyles,
    required this.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Padding(
        padding: EdgeInsets.only(
          top: AppResponsive.height(16.0),
          right: AppResponsive.width(24.0),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            AppStrings.skip,
            style: textStyles.regular(
              color: AppColors.primary500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
