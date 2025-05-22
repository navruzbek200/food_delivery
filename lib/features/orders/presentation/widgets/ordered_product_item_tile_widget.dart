import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class OrderedProductItemTileWidget extends StatelessWidget {
  final String name;
  final String price;
  final String? originalPrice;
  final String imagePath;
  final List<String> addons;
  final int quantity;
  final VoidCallback? onReorder;

  const OrderedProductItemTileWidget({
    Key? key,
    required this.name,
    required this.price,
    this.originalPrice,
    required this.imagePath,
    this.addons = const [],
    this.quantity = 1,
    this.onReorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyles = RobotoTextStyles();
    bool showReorderButton = onReorder != null;

    return Card(
      margin: EdgeInsets.only(bottom: AppResponsive.height(12)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12))),
      elevation: 0.5,
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(AppResponsive.width(12)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppResponsive.height(8)),
              child: Image.asset(
                imagePath,
                width: AppResponsive.width(65),
                height: AppResponsive.width(65),
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  width: AppResponsive.width(65),
                  height: AppResponsive.width(65),
                  color: AppColors.neutral100,
                  child: const Icon(Icons.restaurant_menu_outlined, color: AppColors.neutral300, size: 30),
                ),
              ),
            ),
            SizedBox(width: AppResponsive.width(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: textStyles.medium(fontSize: 14, color: AppColors.textPrimary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppResponsive.height(4)),
                  if (originalPrice != null && originalPrice!.isNotEmpty)
                    Row(
                      children: [
                        Text(price, style: textStyles.semiBold(fontSize: 14, color: AppColors.primary500)),
                        SizedBox(width: AppResponsive.width(8)),
                        Text(originalPrice!, style: textStyles.regular(fontSize: 12, color: AppColors.neutral400, decoration: TextDecoration.lineThrough)),
                      ],
                    )
                  else
                    Text(price, style: textStyles.semiBold(fontSize: 14, color: AppColors.primary500)),

                  if (quantity > 1) // Agar miqdor 1 dan katta bo'lsa ko'rsatamiz
                    Padding(
                      padding: EdgeInsets.only(top: AppResponsive.height(3)),
                      child: Text("Qty: $quantity", style: textStyles.regular(fontSize: 12, color: AppColors.neutral600)),
                    ),

                  if (addons.isNotEmpty)
                    ...addons.map((addon) => Padding(
                      padding: EdgeInsets.only(top: AppResponsive.height(3)),
                      child: Text(
                        '+ $addon',
                        style: textStyles.regular(fontSize: 11, color: AppColors.neutral500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )).toList(),
                ],
              ),
            ),
            if (showReorderButton)
              Padding(
                padding: EdgeInsets.only(left: AppResponsive.width(8)),
                child: TextButton(
                    onPressed: onReorder,
                    style: TextButton.styleFrom(
                        backgroundColor: AppColors.primary50,
                        padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(12), vertical: AppResponsive.height(6)),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(20)))
                    ),
                    child: Text(AppStrings.reorder, style: textStyles.medium(fontSize: 11, color: AppColors.primary500))
                ),
              )
          ],
        ),
      ),
    );
  }
}