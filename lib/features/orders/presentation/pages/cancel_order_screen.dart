import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class CancelOrderScreen extends StatefulWidget {
  final String orderId;

  const CancelOrderScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  State<CancelOrderScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  final _textStyles = RobotoTextStyles();
  String? _selectedReason;
  final TextEditingController _otherReasonController = TextEditingController();
  bool _showOtherReasonTextField = false;
  bool _isSubmitEnabled = false;

  final List<String> _cancellationReasons = [
    AppStrings.cancelReasonChangeMind,
    AppStrings.cancelReasonFoundBetterPrice,
    AppStrings.cancelReasonDeliveryDelay,
    AppStrings.cancelReasonIncorrectItem,
    AppStrings.cancelReasonDuplicateOrder,
    AppStrings.cancelReasonUnableToFulfill,
    AppStrings.cancelReasonOther,
  ];

  @override
  void initState() {
    super.initState();
    _otherReasonController.addListener(_updateSubmitButtonState);
  }

  @override
  void dispose() {
    _otherReasonController.dispose();
    super.dispose();
  }

  void _updateSubmitButtonState() {
    if (mounted) {
      bool canSubmit = false;
      if (_selectedReason != null) {
        if (_selectedReason == AppStrings.cancelReasonOther) {
          canSubmit = _otherReasonController.text.trim().isNotEmpty;
        } else {
          canSubmit = true;
        }
      }
      if (_isSubmitEnabled != canSubmit) {
        setState(() {
          _isSubmitEnabled = canSubmit;
        });
      }
    }
  }

  void _onReasonSelected(String? reason) {
    setState(() {
      _selectedReason = reason;
      _showOtherReasonTextField = (reason == AppStrings.cancelReasonOther);
      _updateSubmitButtonState();
    });
  }

  void _submitCancellation() {
    if (!_isSubmitEnabled) return;
    FocusScope.of(context).unfocus();

    String finalReason = _selectedReason ?? "";
    if (_selectedReason == AppStrings.cancelReasonOther) {
      finalReason = _otherReasonController.text.trim();
    }

    print("Order ID: ${widget.orderId} cancellation submitted.");
    print("Reason: $finalReason");

    _showCancellationSuccessDialog();
  }

  void _showCancellationSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(AppResponsive.width(24)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(16))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.close, color: AppColors.neutral400, size: 20),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
              Image.asset(
                'assets/images/order_canceled_icon.png',
                height: AppResponsive.height(100),
              ),
              SizedBox(height: AppResponsive.height(20)),
              Text(
                AppStrings.yourOrderCanceled,
                style: _textStyles.bold(fontSize: 20, color: AppColors.textPrimary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppResponsive.height(8)),
              Text(
                AppStrings.orderCancellationInfo,
                style: _textStyles.regular(fontSize: 14, color: AppColors.textSecondary,),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppResponsive.height(24)),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary500,
                    padding: EdgeInsets.symmetric(vertical: AppResponsive.height(14)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(25))),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    Navigator.of(context).pop(true);
                  },
                  child: Text(AppStrings.ok, style: _textStyles.semiBold(color: AppColors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        shadowColor: AppColors.neutral200.withOpacity(0.7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800, size: 20),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          AppStrings.cancelOrderTitle,
          style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24), vertical: AppResponsive.height(20)),
              itemCount: _cancellationReasons.length,
              itemBuilder: (context, index) {
                final reason = _cancellationReasons[index];
                return RadioListTile<String>(
                  title: Text(reason, style: _textStyles.regular(fontSize: 14, color: AppColors.textPrimary)),
                  value: reason,
                  groupValue: _selectedReason,
                  onChanged: _onReasonSelected,
                  activeColor: AppColors.primary500,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  controlAffinity: ListTileControlAffinity.trailing,
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.neutral100),
            ),
          ),
          if (_showOtherReasonTextField)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24), vertical: AppResponsive.height(16)),
              child: TextField(
                controller: _otherReasonController,
                decoration: InputDecoration(
                  hintText: AppStrings.otherReasonHint,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: const BorderSide(color: AppColors.neutral200)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: const BorderSide(color: AppColors.primary300, width: 1.5)),
                  contentPadding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16), vertical: AppResponsive.height(12)),
                ),
                maxLines: 3,
                onChanged: (text) => _updateSubmitButtonState(),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: AppResponsive.width(24),
              right: AppResponsive.width(24),
              top: AppResponsive.height(16),
              bottom: AppResponsive.height(24) + MediaQuery.of(context).padding.bottom,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isSubmitEnabled ? AppColors.primary500 : AppColors.primary100,
                  padding: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(25))),
                  elevation: _isSubmitEnabled ? 2 : 0,
                ),
                onPressed: _isSubmitEnabled ? _submitCancellation : null,
                child: Text(
                  AppStrings.submit,
                  style: _textStyles.semiBold(
                    color: _isSubmitEnabled ? AppColors.white : AppColors.primary300,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}