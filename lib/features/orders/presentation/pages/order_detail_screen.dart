import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/orders/presentation/pages/cancel_order_screen.dart';
import 'package:food_delivery/features/orders/presentation/pages/track_order_screen.dart'; // TrackOrderScreen uchun import
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';
import '../widgets/order_summary_section_widget.dart';
import '../widgets/order_info_row_widget.dart';
import '../widgets/order_price_details_section_widget.dart';
import '../widgets/order_action_buttons_widget.dart';
import '../widgets/order_cancellation_info_widget.dart';
import '../widgets/order_review_input_widget.dart';

class OrderDetailScreen extends StatefulWidget {
  final Map<String, dynamic> initialOrderData;
  final VoidCallback? onAppBarBackPressed;

  const OrderDetailScreen({
    Key? key,
    required this.initialOrderData,
    this.onAppBarBackPressed,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late Map<String, dynamic> _currentOrderData;
  final _textStyles = RobotoTextStyles();

  @override
  void initState() {
    super.initState();
    _currentOrderData = Map.from(widget.initialOrderData);
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor; Color textColor; String statusText = status;
    String lowerCaseStatus = status.toLowerCase();
    if (lowerCaseStatus == AppStrings.active.toLowerCase()) { backgroundColor = AppColors.primary50.withOpacity(0.8); textColor = AppColors.primary500; statusText = AppStrings.active;
    } else if (lowerCaseStatus == AppStrings.completed.toLowerCase()) { backgroundColor = AppColors.green50.withOpacity(0.8); textColor = AppColors.green500; statusText = AppStrings.completed;
    } else if (lowerCaseStatus == AppStrings.cancelled.toLowerCase()) { backgroundColor = AppColors.neutral50.withOpacity(0.8); textColor = AppColors.neutral500; statusText = AppStrings.cancelled;
    } else { backgroundColor = AppColors.neutral100; textColor = AppColors.neutral700; statusText = AppStrings.unknown; }
    return Container( padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(10), vertical: AppResponsive.height(4),), decoration: BoxDecoration( color: backgroundColor, borderRadius: BorderRadius.circular(AppResponsive.height(15)),), child: Text(statusText, style: _textStyles.medium(fontSize: 12, color: textColor),),);
  }

  @override
  Widget build(BuildContext context) {
    final String status = _currentOrderData['status'] as String? ?? AppStrings.unknown;
    final List<Map<String, dynamic>> orderedItems = (_currentOrderData['orderedItems'] as List<dynamic>?)?.map((item) => item as Map<String, dynamic>).toList() ?? [];
    final double userRating = _currentOrderData['userRating'] as double? ?? 0.0;
    final String userReview = _currentOrderData['userReview'] as String? ?? "";
    final String cancellationReason = _currentOrderData['cancellationReason'] as String? ?? "No reason provided";

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _currentOrderData['status'] != widget.initialOrderData['status']);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.neutral50,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.5,
          shadowColor: AppColors.neutral100,
          title: Text(
            _currentOrderData['id'] as String? ?? AppStrings.orderDetails,
            style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz, color: AppColors.neutral800),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24), vertical: AppResponsive.height(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: Alignment.centerRight, child: _buildStatusChip(status),),
              SizedBox(height: AppResponsive.height(16)),
              OrderSummarySectionWidget(orderedItems: orderedItems, orderStatus: status),
              SizedBox(height: AppResponsive.height(24)),
              const Divider(color: AppColors.neutral100, thickness: 1.5),
              SizedBox(height: AppResponsive.height(16)),
              OrderInfoRowWidget(iconData: Icons.location_on_outlined, title: AppStrings.deliverTo, value: _currentOrderData['deliveryAddressLabel'] as String? ?? AppStrings.notAvailable, valueColor: AppColors.primary500, isValueBold: true),
              Padding(padding: EdgeInsets.only(left: AppResponsive.width(36), top: AppResponsive.height(2), bottom: AppResponsive.height(8)), child: Text(_currentOrderData['deliveryAddressFull'] as String? ?? AppStrings.addressNotProvided, style: _textStyles.regular(fontSize: 13, color: AppColors.textSecondary),),),
              const Divider(color: AppColors.neutral100, thickness: 1.5),
              OrderInfoRowWidget(iconData: Icons.payment_outlined, title: AppStrings.paymentMethod, value: _currentOrderData['paymentMethod'] as String? ?? AppStrings.notAvailable,),
              const Divider(color: AppColors.neutral100, thickness: 1.5),
              OrderInfoRowWidget(
                iconData: Icons.local_offer_outlined,
                title: AppStrings.promotions,
                value: "",
                trailingWidget: ((_currentOrderData['promotionsApplied'] as List<dynamic>?)?.map((p) => p as Map<String, dynamic>).toList() ?? []).isNotEmpty
                    ? Wrap(
                  spacing: AppResponsive.width(8),
                  runSpacing: AppResponsive.height(4),
                  alignment: WrapAlignment.end,
                  children: ((_currentOrderData['promotionsApplied'] as List<dynamic>?)?.map((p) => p as Map<String, dynamic>).toList() ?? [])
                      .map((promo) => Chip(label: Text("${promo['name'] ?? ''} ${promo['discount'] ?? ''}".trim(), style: _textStyles.medium(fontSize: 10, color: AppColors.secondary600)), backgroundColor: AppColors.secondary50, padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(8), vertical: AppResponsive.height(2)), labelPadding: EdgeInsets.zero, visualDensity: VisualDensity.compact,)).toList(),
                )
                    : Text(AppStrings.noPromotionsApplied, style: _textStyles.regular(fontSize: 14, color: AppColors.neutral500)),
              ),
              SizedBox(height: AppResponsive.height(16)),
              OrderPriceDetailsSectionWidget(
                subtotal: _currentOrderData['subtotal'] as String? ?? "£0.00",
                deliveryFee: _currentOrderData['deliveryFee'] as String? ?? "£0.00",
                isDeliveryFree: (_currentOrderData['deliveryFee'] as String?)?.toLowerCase() == AppStrings.free.toLowerCase(),
                discount: _currentOrderData['discountValue'] as String? ?? "£0.00",
                hasDiscount: ((_currentOrderData['discountValue'] as String?)?.isNotEmpty ?? false) && (_currentOrderData['discountValue'] as String?) != "£0.00",
                total: _currentOrderData['price'] as String? ?? "£0.00",
              ),

              if (status.toLowerCase() == AppStrings.cancelled.toLowerCase())
                OrderCancellationInfoWidget(
                  reason: cancellationReason,
                  onEditReason: () {},
                ),

              if (status.toLowerCase() == AppStrings.completed.toLowerCase())
                OrderReviewInputWidget(
                  initialRating: userRating,
                  initialReview: userReview,
                  onRatingChanged: (newRating) { setState(() { _currentOrderData['userRating'] = newRating; }); },
                  onReviewChanged: (newReview) { setState(() { _currentOrderData['userReview'] = newReview; }); },
                  onCameraTap: () {},
                  onMicTap: () {},
                ),

              OrderActionButtonsWidget(
                status: status,
                onCancelOrder: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CancelOrderScreen(orderId: _currentOrderData['id'] as String? ?? 'UNKNOWN_ID'),
                    ),
                  );
                  if (result == true && mounted) {
                    Navigator.pop(context, true);
                  }
                },
                onTrackOrder: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackOrderScreen(
                        orderId: _currentOrderData['id'] as String? ?? 'UNKNOWN_ID',
                        completeOrderData: _currentOrderData,
                      ),
                    ),
                  );
                },
                onReorder: () {},
              ),
              SizedBox(height: AppResponsive.height(20)),
            ],
          ),
        ),
      ),
    );
  }
}