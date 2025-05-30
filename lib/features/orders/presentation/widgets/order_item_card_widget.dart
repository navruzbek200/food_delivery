import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:logger/logger.dart';

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
      case 'Active':
        backgroundColor = AppColors.primary50.withOpacity(0.8);
        textColor = AppColors.primary500;
        statusText = AppStrings.active;
        break;
      case 'completed':
      case 'Completed':
        backgroundColor = AppColors.green50.withOpacity(0.8);
        textColor = AppColors.green500;
        statusText = AppStrings.completed;
        break;
      case 'cancelled':
      case 'Cancelled':
        backgroundColor = AppColors.neutral50.withOpacity(0.8);
        textColor = AppColors.neutral500;
        statusText = AppStrings.cancelled;
        break;
      default:
        backgroundColor = AppColors.neutral100;
        textColor = AppColors.neutral700;
    }
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.width(12),
        vertical: AppResponsive.height(6),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppResponsive.height(20)),
      ),
      child: Text(
        statusText,
        style: _textStyles.medium(fontSize: 13, color: textColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> itemImages = orderData['itemImageUrls'] as List<String>? ?? [];
    final String status = orderData['status'] ?? 'Unknown';
    // final double rating = orderData['rating'] as double? ?? 0.0;
    final String orderId = orderData['id'] ?? 'N/A';
    final String price = orderData['total_price'] ?? '42.5';
    final String image = orderData['image'] ?? 'N/A';
    var logger = Logger();
    logger.i("orderData $orderData");

    double imageDiameter = AppResponsive.height(55);
    double overlapFactor = 0.45;
    double leftPosition1 = 1 * (imageDiameter * (1 - overlapFactor));
    double leftPosition2 = 2 * (imageDiameter * (1 - overlapFactor));
    double leftPosition3 = 3 * (imageDiameter * (1 - overlapFactor));
    return Card(
      margin: EdgeInsets.only(bottom: AppResponsive.height(16)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(16))),
      elevation: 2.0,
      shadowColor: AppColors.neutral200.withOpacity(0.6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppResponsive.height(16)),
        child: Padding(
          padding: EdgeInsets.all(AppResponsive.width(22)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                  width: AppResponsive.width(90),
                  height: AppResponsive.height(70),
                  child:

                  Stack(
                    alignment: Alignment.centerLeft,

                    children: [
                      Positioned(
                        // left: leftPosition,
                        child: Container(
                          // width: imageDiameter,
                          // height: imageDiameter,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppResponsive.height(10)),
                            border: Border.all(color: AppColors.white, width: 2.5),
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/orders/order_item1.png"),
                              fit: BoxFit.cover,
                              onError: (e, s) {},
                            ),
                            color: AppColors.neutral100,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),),
                      ),
                      // Positioned(
                      //   left: leftPosition1,
                      //   child: Container(
                      //     // width: imageDiameter,
                      //     // height: imageDiameter,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(
                      //           AppResponsive.height(10)),
                      //       border: Border.all(color: AppColors.white, width: 2.5),
                      //       image: DecorationImage(
                      //         image: AssetImage(
                      //             "assets/images/orders/order_item1.png"),
                      //         fit: BoxFit.cover,
                      //         onError: (e, s) {},
                      //       ),
                      //       color: AppColors.neutral100,
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.black.withOpacity(0.15),
                      //           blurRadius: 4,
                      //           offset: const Offset(0, 2),
                      //         )
                      //       ],
                      //     ),),
                      // ),
                    ],
                  )
                // Stack(
                //   alignment: Alignment.centerLeft,
                //   children: List.generate(
                //     itemImages.length > 3 ? 3 : itemImages.length,
                //         (imgIndex) {
                //       double imageDiameter = AppResponsive.height(55);
                //       double overlapFactor = 0.45;
                //       double leftPosition = imgIndex * (imageDiameter * (1 - overlapFactor));
                //
                //       return Positioned(
                //         left: leftPosition,
                //         child: Container(
                //           width: imageDiameter,
                //           height: imageDiameter,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(AppResponsive.height(10)),
                //             border: Border.all(color: AppColors.white, width: 2.5),
                //             // image: DecorationImage(
                //             //   // image: AssetImage(itemImages[imgIndex]),
                //             //   // image: AssetImage(image),
                //             //   // image: Image.asset(image),
                //             //   fit: BoxFit.cover,
                //             //   onError: (e, s) {},
                //             // ),
                //             color: AppColors.neutral100,
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Colors.black.withOpacity(0.15),
                //                 blurRadius: 4,
                //                 offset: const Offset(0, 2),
                //               )
                //             ],
                //           ),
                //           child: Row(
                //             children: [
                //               Text("khk"),
                //               Image.asset('assets/images/orders/order_item1.png'),
                //             ],
                //           )
                //           // itemImages.isEmpty || itemImages.length <= imgIndex
                //           //     ? const Center(child: Icon(Icons.fastfood_outlined, color: AppColors.neutral300, size: 24))
                //           //     : null,
                //         ),
                //       );
                //     },
                //   ).reversed.toList(),
                // ),
              ),
              SizedBox(width: AppResponsive.width(16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Order ID : $orderId",
                      style: _textStyles.medium(color: AppColors.neutral800, fontSize: 13),
                    ),
                    SizedBox(height: AppResponsive.height(8)),
                    Text(
                      "$price",
                      style: _textStyles.bold(color: AppColors.primary500, fontSize: 18),

                    ),
                    SizedBox(height: AppResponsive.height(8)),
                    // if (status.toLowerCase() == 'completed' && rating > 0)
                    //   Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: List.generate(5, (i) => Icon(
                    //       i < rating ? Icons.star_rounded : Icons.star_border_rounded,
                    //       color: Colors.amber, size: AppResponsive.height(20),
                    //     )),
                    //   )
                    // else
                    //   SizedBox(height: AppResponsive.height(20)),
                  ],
                ),
              ),
              SizedBox(width: AppResponsive.width(10)),
              _buildStatusChip(status),
            ],
          ),
        ),
      ),
    );
  }
}