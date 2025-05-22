import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class OrderReviewInputWidget extends StatefulWidget {
  final double initialRating;
  final String initialReview;
  final Function(double) onRatingChanged;
  final Function(String) onReviewChanged;
  final VoidCallback onCameraTap;
  final VoidCallback onMicTap;

  const OrderReviewInputWidget({
    Key? key,
    required this.initialRating,
    required this.initialReview,
    required this.onRatingChanged,
    required this.onReviewChanged,
    required this.onCameraTap,
    required this.onMicTap,
  }) : super(key: key);

  @override
  State<OrderReviewInputWidget> createState() => _OrderReviewInputWidgetState();
}

class _OrderReviewInputWidgetState extends State<OrderReviewInputWidget> {
  late TextEditingController _reviewController;
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _reviewController = TextEditingController(text: widget.initialReview);
    _currentRating = widget.initialRating;
  }

  @override
  void didUpdateWidget(covariant OrderReviewInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialReview != oldWidget.initialReview) {
      _reviewController.text = widget.initialReview;
    }
    if (widget.initialRating != oldWidget.initialRating) {
      _currentRating = widget.initialRating;
    }
  }


  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = RobotoTextStyles();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppResponsive.height(24)),
        const Divider(color: AppColors.neutral100, thickness: 1.5),
        SizedBox(height: AppResponsive.height(16)),
        Text(AppStrings.rateYourOrder, style: textStyles.semiBold(fontSize: 16, color: AppColors.textPrimary)),
        SizedBox(height: AppResponsive.height(12)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (i) => InkWell(
            onTap: () {
              setState(() { _currentRating = (i + 1).toDouble(); });
              widget.onRatingChanged(_currentRating);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(2.0)),
              child: Icon(
                  i < _currentRating ? Icons.star_rounded : Icons.star_border_rounded,
                  color: i < _currentRating ? AppColors.secondary500 : AppColors.neutral300,
                  size: AppResponsive.width(32)
              ),
            ),
          )),
        ),
        SizedBox(height: AppResponsive.height(20)),
        TextField(
          controller: _reviewController,
          onChanged: widget.onReviewChanged,
          decoration: InputDecoration(
              hintText: AppStrings.typeYourReview,
              hintStyle: textStyles.regular(fontSize: 14, color: AppColors.neutral400),
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: const BorderSide(color: AppColors.neutral200, width: 1.0)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: const BorderSide(color: AppColors.neutral200, width: 1.0)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: const BorderSide(color: AppColors.primary300, width: 1.5)),
              contentPadding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16), vertical: AppResponsive.height(12)),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.camera_alt_outlined, color: AppColors.neutral500, size: 22), onPressed: widget.onCameraTap),
                  IconButton(icon: const Icon(Icons.mic_none_outlined, color: AppColors.neutral500, size: 22), onPressed: widget.onMicTap),
                ],
              )
          ),
          maxLines: 4,
          minLines: 2,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}