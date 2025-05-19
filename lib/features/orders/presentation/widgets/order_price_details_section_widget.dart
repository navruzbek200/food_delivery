import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class OrderPriceDetailsSectionWidget extends StatelessWidget {
  final String subtotal;
  final String deliveryFee;
  final bool isDeliveryFree;
  final String discount;
  final bool hasDiscount;
  final String total;

  const OrderPriceDetailsSectionWidget({
    Key? key,
    required this.subtotal,
    required this.deliveryFee,
    this.isDeliveryFree = false,
    required this.discount,
    this.hasDiscount = false,
    required this.total,
  }) : super(key: key);

  Widget _buildPriceRow(RobotoTextStyles textStyles, String label, String value, {bool isFree = false, bool isDiscount = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppResponsive.height(7)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyles.regular(fontSize: 14, color: AppColors.textSecondary)),
          Text(
            isFree ? AppStrings.free.toUpperCase() : (isDiscount ? "- $value" : value),
            style: textStyles.medium(
              fontSize: 14,
              color: isDiscount ? AppColors.primary500 : (isFree ? AppColors.green500 : AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(RobotoTextStyles textStyles, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppResponsive.height(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyles.semiBold(fontSize: 16, color: AppColors.textPrimary)),
          Text(value, style: textStyles.bold(fontSize: 18, color: AppColors.primary500)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = RobotoTextStyles();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPriceRow(textStyles, AppStrings.subtotal, subtotal),
        _buildPriceRow(textStyles, AppStrings.deliveryFee, deliveryFee, isFree: isDeliveryFree),
        if(hasDiscount)
          _buildPriceRow(textStyles, AppStrings.discount, discount, isDiscount: true),
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppResponsive.height(12.0)),
          child: const Divider(color: AppColors.neutral200, thickness: 1),
        ),
        _buildTotalRow(textStyles, AppStrings.total, total),
      ],
    );
  }
}