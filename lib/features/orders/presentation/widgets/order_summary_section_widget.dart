import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';
import 'ordered_product_item_tile_widget.dart';

class OrderSummarySectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> orderedItems;
  final String orderStatus;

  const OrderSummarySectionWidget({
    Key? key,
    required this.orderedItems,
    required this.orderStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyles = RobotoTextStyles();
    bool canReorder = orderStatus.toLowerCase() == AppStrings.completed.toLowerCase() ||
        orderStatus.toLowerCase() == AppStrings.cancelled.toLowerCase();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: AppResponsive.height(12.0), top: AppResponsive.height(8.0)),
          child: Text(AppStrings.orderSummary, style: textStyles.semiBold(fontSize: 16, color: AppColors.textPrimary)),
        ),
        if (orderedItems.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
            child: Text("No items in this order.", style: textStyles.regular(fontSize: 14, color: AppColors.neutral500)),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderedItems.length,
            itemBuilder: (context, index) {
              final item = orderedItems[index];
              return OrderedProductItemTileWidget(
                name: item['name'] ?? 'Unknown Item',
                price: item['price'] ?? 'N/A',
                originalPrice: item['originalPrice'] as String?,
                imagePath: item['imagePath'] ?? 'assets/images/placeholder.png',
                addons: (item['addons'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
                quantity: item['quantity'] as int? ?? 1,
                onReorder: canReorder ? () { print("Reorder item: ${item['name']}"); } : null,
              );
            },
          ),
      ],
    );
  }
}