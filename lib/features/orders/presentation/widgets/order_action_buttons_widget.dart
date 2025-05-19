import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class OrderActionButtonsWidget extends StatelessWidget {
  final String status;
  final VoidCallback onCancelOrder;
  final VoidCallback onTrackOrder;
  final VoidCallback onReorder;

  const OrderActionButtonsWidget({
    Key? key,
    required this.status,
    required this.onCancelOrder,
    required this.onTrackOrder,
    required this.onReorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyles = RobotoTextStyles();
    String currentStatus = status.toLowerCase();

    if (currentStatus == AppStrings.active.toLowerCase()) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: AppResponsive.height(24), horizontal: AppResponsive.width(0)),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onCancelOrder,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary500, width: 1.5),
                  padding: EdgeInsets.symmetric(vertical: AppResponsive.height(15)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(28))),
                ),
                child: Text(AppStrings.cancelOrder, style: textStyles.semiBold(fontSize: 16, color: AppColors.primary500)),
              ),
            ),
            SizedBox(width: AppResponsive.width(16)),
            Expanded(
              child: ElevatedButton(
                onPressed: onTrackOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary500,
                  padding: EdgeInsets.symmetric(vertical: AppResponsive.height(15)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(28))),
                  elevation: 2.0,
                ),
                child: Text(AppStrings.trackOrder, style: textStyles.semiBold(fontSize: 16, color: AppColors.white)),
              ),
            ),
          ],
        ),
      );
    } else if (currentStatus == AppStrings.completed.toLowerCase() || currentStatus == AppStrings.cancelled.toLowerCase()) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: AppResponsive.height(24), horizontal: AppResponsive.width(0)),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.shopping_bag_outlined, size: 20, color: AppColors.white),
            label: Text(AppStrings.reorder, style: textStyles.semiBold(fontSize: 16, color: AppColors.white)),
            onPressed: onReorder,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary500,
              padding: EdgeInsets.symmetric(vertical: AppResponsive.height(15)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(28))),
              elevation: 2.0,
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}