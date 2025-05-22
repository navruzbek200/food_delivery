import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

class OrderFilterTabsWidget extends StatelessWidget {
  final String selectedStatusFilter;
  final Function(String) onFilterTabSelected;
  final List<String> statuses;

  const OrderFilterTabsWidget({
    Key? key,
    required this.selectedStatusFilter,
    required this.onFilterTabSelected,
    required this.statuses,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppResponsive.height(42),
      padding: EdgeInsets.symmetric(vertical: AppResponsive.height(0)),
      margin: EdgeInsets.only(left: AppResponsive.width(24), right: AppResponsive.width(24), bottom: AppResponsive.height(16)),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: statuses.length,
        itemBuilder: (context, index) {
          final status = statuses[index];
          bool isSelected = selectedStatusFilter == status;
          return ElevatedButton(
            onPressed: () => onFilterTabSelected(status),
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? AppColors.primary500 : AppColors.white,
              foregroundColor: isSelected ? AppColors.white : AppColors.neutral700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppResponsive.height(25)),
                side: isSelected ? BorderSide.none : BorderSide(color: AppColors.neutral300.withOpacity(0.7)),
              ),
              elevation: isSelected ? 2 : 0.5,
              padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(20), vertical: AppResponsive.height(10)),
              minimumSize: Size(AppResponsive.width(80), AppResponsive.height(42)),
            ),
            child: Text(
              status,
              style: _textStyles.medium(fontSize: 14, color: AppColors.black),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: AppResponsive.width(12)),
      ),
    );
  }
}