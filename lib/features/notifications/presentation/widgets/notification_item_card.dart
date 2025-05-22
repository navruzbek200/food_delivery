import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/notification_item.dart';

class NotificationItemCard extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback onTap;

  const NotificationItemCard({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppResponsive.height(12),
          horizontal: AppResponsive.width(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: AppResponsive.width(40),
              height: AppResponsive.height(40),
              decoration: BoxDecoration(
                color: item.iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(AppResponsive.width(8)),
                child: SvgPicture.asset(
                  item.iconAssetPath,
                  width: AppResponsive.width(24),
                  height: AppResponsive.height(24),
                  placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(8.0),
                      child: const CircularProgressIndicator(strokeWidth: 2, color: AppColors.neutral300)),
                ),
              ),
            ),
            SizedBox(width: AppResponsive.width(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: _textStyles.medium(color: AppColors.neutral900, fontSize: 14,),),
                  if (item.subtitle != null && item.subtitle!.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: AppResponsive.height(4)),
                      child: Text(item.subtitle!, style: _textStyles.regular(color: AppColors.neutral700, fontSize: 12,), maxLines: 2, overflow: TextOverflow.ellipsis,),
                    ),
                ],
              ),
            ),
            SizedBox(width: AppResponsive.width(12)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(DateFormat('HH:mm dd/MM/yyyy').format(item.dateTime), style: _textStyles.regular(color: AppColors.neutral500, fontSize: 10,),),
                if (!item.isRead)
                  Padding(
                    padding: EdgeInsets.only(top: AppResponsive.height(6)),
                    child: Container(
                      width: AppResponsive.width(8),
                      height: AppResponsive.height(8),
                      decoration: const BoxDecoration(color: AppColors.primary500, shape: BoxShape.circle,),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}