import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class OrderInfoRowWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String value;
  final Color? valueColor;
  final bool isValueBold;
  final Widget? trailingWidget;
  final VoidCallback? onTap;

  const OrderInfoRowWidget({
    Key? key,
    required this.iconData,
    required this.title,
    required this.value,
    this.valueColor,
    this.isValueBold = false,
    this.trailingWidget,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyles = RobotoTextStyles();

    Widget content = Row(
      children: [
        Icon(iconData, color: AppColors.neutral700, size: AppResponsive.width(20)),
        SizedBox(width: AppResponsive.width(12)),
        Text(title, style: textStyles.regular(fontSize: 14, color: AppColors.textSecondary)),
        const Spacer(),
        if (trailingWidget == null)
          Text(
            value,
            style: isValueBold
                ? textStyles.semiBold(fontSize: 14, color: valueColor ?? AppColors.textPrimary)
                : textStyles.medium(fontSize: 14, color: valueColor ?? AppColors.textPrimary),
          ),
        if (trailingWidget != null)
          trailingWidget!,
      ],
    );

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppResponsive.height(12), horizontal: AppResponsive.width(0)), // Gorizontal paddingni 0 qildik, chunki umumiy padding bor
        child: content,
      ),
    );
  }
}