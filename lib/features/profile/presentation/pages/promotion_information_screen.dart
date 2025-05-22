import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class PromotionInformationScreen extends StatelessWidget {

  const PromotionInformationScreen({
    Key? key,
  }) : super(key: key);

  static String _promoTitle = AppStrings.freeShipping;
  static const String _promoIconPath = 'assets/icons/payment_methods/discount_promo_icon.png';

  static const String _description = "Enjoy free shipping on all orders throughout this month!";
  static const String _duration = "01/05/2024 - 31/05/2024";
  static const String _promoCode = "FREESHIP";
  static const String _applicableScope = "Applicable to all orders on our website or app.";
  static const String _discountAmount = "100% off shipping (Free shipping).";
  static const String _termsAndConditions = "No minimum order requirement. Applicable for standard shipping within the country.";


  Widget _buildInfoRow(RobotoTextStyles textStyles, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppResponsive.height(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textStyles.medium(color: AppColors.neutral600, fontSize: 13),
          ),
          SizedBox(height: AppResponsive.height(4)),
          Text(
            value,
            style: textStyles.regular(color: AppColors.textPrimary, fontSize: 14,),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _textStyles = RobotoTextStyles();

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
          AppStrings.promotionInformation,
          style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppResponsive.width(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: AppResponsive.height(20)),
            Container(
              width: AppResponsive.width(83.33),
              height: AppResponsive.height(66.67),
              padding: EdgeInsets.all(AppResponsive.width(12)),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFEB692), Color(0xFFEA5455)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppResponsive.height(16)),
              ),
              child: Image.asset(
                _promoIconPath,
              ),
            ),
            SizedBox(height: AppResponsive.height(16)),
            Text(
              _promoTitle,
              style: _textStyles.bold(color: AppColors.textPrimary, fontSize: 20),
            ),
            SizedBox(height: AppResponsive.height(30)),

            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(_textStyles, AppStrings.description, _description),
                  _buildInfoRow(_textStyles, AppStrings.duration, _duration),
                  _buildInfoRow(_textStyles, AppStrings.promoCode, _promoCode),
                  _buildInfoRow(_textStyles, AppStrings.applicableScope, _applicableScope),
                  _buildInfoRow(_textStyles, AppStrings.discountAmount, _discountAmount),
                  _buildInfoRow(_textStyles, AppStrings.termsAndConditions, _termsAndConditions),
                ],
              ),
            ),
            SizedBox(height: AppResponsive.height(24)),
          ],
        ),
      ),
    );
  }
}