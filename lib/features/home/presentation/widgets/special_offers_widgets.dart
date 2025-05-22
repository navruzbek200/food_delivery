import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class SpecialOffersSearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onClear;
  final VoidCallback onFilterTapped;

  const SpecialOffersSearchBarWidget({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.onFilterTapped,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppResponsive.width(345),
      height: AppResponsive.height(56),
      margin: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
      decoration: BoxDecoration(
        color: AppColors.neutral100.withOpacity(0.8),
        borderRadius: BorderRadius.circular(AppResponsive.height(12)),
      ),
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            color: AppColors.neutral500,
            size: AppResponsive.height(22),
          ),
          SizedBox(width: AppResponsive.width(12)),
          Expanded(
            child: TextField(
              controller: controller,
              style: _textStyles.regular(
                color: AppColors.neutral800,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText:
                    "${AppStrings.search} ${AppStrings.specialOffers.toLowerCase()}",
                hintStyle: _textStyles.regular(
                  color: AppColors.neutral400,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: AppResponsive.height(15),
                ),
                suffixIcon:
                    controller.text.isNotEmpty
                        ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: AppColors.neutral500,
                            size: AppResponsive.height(20),
                          ),
                          onPressed: onClear,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        )
                        : null,
              ),
              onChanged: onChanged,
              textInputAction: TextInputAction.search,
            ),
          ),
          SizedBox(width: AppResponsive.width(12)),
          InkWell(
            onTap: onFilterTapped,
            child: Icon(
              Icons.tune_outlined,
              color: AppColors.primary500,
              size: AppResponsive.height(22),
            ),
          ),
        ],
      ),
    );
  }
}

class SpecialOffersNotFoundWidget extends StatelessWidget {
  const SpecialOffersNotFoundWidget({Key? key}) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied_outlined,
            size: AppResponsive.height(80),
            color: AppColors.neutral300,
          ),
          SizedBox(height: AppResponsive.height(16)),
          Text(
            AppStrings.notFound,
            style: _textStyles.semiBold(
              color: AppColors.neutral700,
              fontSize: 18,
            ),
          ),
          SizedBox(height: AppResponsive.height(8)),
          Text(
            AppStrings.tryDifferentKeywordsOrFilters,
            textAlign: TextAlign.center,
            style: _textStyles.regular(
              color: AppColors.neutral500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
