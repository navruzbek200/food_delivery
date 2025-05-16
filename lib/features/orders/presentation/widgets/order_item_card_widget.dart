import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';


class OrderItemCardWidget extends StatelessWidget {
  final Map<String, dynamic> orderData;
  final VoidCallback onTap;

  const OrderItemCardWidget({
    Key? key,
    required this.orderData,
    required this.onTap,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    String statusText = status;

    switch (status.toLowerCase()) {
      case 'active':
        backgroundColor = AppColors.primary50.withOpacity(0.8);
        textColor = AppColors.primary500;
        statusText = AppStrings.active;
        break;
      case 'completed':
        backgroundColor = AppColors.green50.withOpacity(0.8);
        textColor = AppColors.green500;
        statusText = AppStrings.completed;
        break;
      case 'cancelled':
        backgroundColor = AppColors.neutral50.withOpacity(0.8);
        textColor = AppColors.neutral500;
        statusText = AppStrings.cancelled;
        break;
      default:
        backgroundColor = AppColors.neutral100;
        textColor = AppColors.neutral700;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(10), vertical: AppResponsive.height(4),),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(AppResponsive.height(15)),),
      child: Text(statusText, style: _textStyles.medium(fontSize: 12, color: textColor),),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> itemImages = orderData['itemImageUrls'] as List<String>? ?? [];
    final String status = orderData['status'] ?? 'Unknown';
    final double rating = orderData['rating'] as double? ?? 0.0;

    return Card(
      margin: EdgeInsets.only(bottom: AppResponsive.height(16)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12))),
      elevation: 1.0,
      shadowColor: AppColors.neutral200.withOpacity(0.5),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppResponsive.height(12)),
        child: Padding(
          padding: EdgeInsets.all(AppResponsive.width(12)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: AppResponsive.width(85),
                height: AppResponsive.height(60),
                child: Stack(
                  children: List.generate(
                    itemImages.length > 3 ? 3 : itemImages.length,
                        (imgIndex) {
                      double imageDiameter = AppResponsive.height(48);
                      double leftPosition = imgIndex * (imageDiameter * 0.55);
                      return Positioned(
                        left: leftPosition,
                        top: (AppResponsive.height(60) - imageDiameter) / 2,
                        child: Container(
                          width: imageDiameter,
                          height: imageDiameter,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppResponsive.height(8)),
                              border: Border.all(color: AppColors.white, width: 2),
                              image: DecorationImage(
                                image: AssetImage(itemImages[imgIndex]),
                                fit: BoxFit.cover,
                                onError: (e,s){},
                              ),
                              color: AppColors.neutral100,
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: const Offset(0,1))]
                          ),
                          child: itemImages.isEmpty || itemImages.length <= imgIndex
                              ? const Center(child: Icon(Icons.fastfood_outlined, color: AppColors.neutral300, size: 20))
                              : null,
                        ),
                      );
                    },
                  ).reversed.toList(),
                ),
              ),
              SizedBox(width: AppResponsive.width(16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Order ID : ${orderData['id']}", style: _textStyles.medium(color: AppColors.neutral700, fontSize: 12),),
                    SizedBox(height: AppResponsive.height(6)),
                    Text(orderData['price'], style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 16),),
                    SizedBox(height: AppResponsive.height(6)),
                    if (status == 'Completed' && rating > 0)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (i) => Icon(
                          i < rating ? Icons.star_rounded : Icons.star_border_rounded,
                          color: Colors.amber, size: AppResponsive.height(18),
                        )),
                      )
                    else SizedBox(height: AppResponsive.height(18)),
                  ],
                ),
              ),
              SizedBox(width: AppResponsive.width(8)),
              _buildStatusChip(status),
            ],
          ),
        ),
      ),
    );
  }
}