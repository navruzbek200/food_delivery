import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class OrderCancellationInfoWidget extends StatelessWidget {
  final String reason;
  final VoidCallback onEditReason;

  const OrderCancellationInfoWidget({
    Key? key,
    required this.reason,
    required this.onEditReason,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyles = RobotoTextStyles();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppResponsive.height(24)),
        const Divider(color: AppColors.neutral100, thickness: 1.5),
        SizedBox(height: AppResponsive.height(16)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.reasonForCancellation, style: textStyles.medium(fontSize: 14, color: AppColors.textPrimary)),
            InkWell(
              onTap: onEditReason,
              borderRadius: BorderRadius.circular(AppResponsive.width(12)),
              child: Padding(
                padding: EdgeInsets.all(AppResponsive.width(4.0)),
                child: Icon(Icons.edit_outlined, color: AppColors.primary500, size: 20),
              ),
            )
          ],
        ),
        SizedBox(height: AppResponsive.height(4)),
        Text(reason, style: textStyles.regular(fontSize: 14, color: AppColors.textSecondary)),
      ],
    );
  }
}