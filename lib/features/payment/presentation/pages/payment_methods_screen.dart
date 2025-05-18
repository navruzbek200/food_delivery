import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/payment/domain/entities/payment_method_item.dart';
import 'package:food_delivery/features/payment/domain/entities/payment_method_type.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';
import 'add_new_card_screen.dart';

class PaymentMethodsScreen extends StatefulWidget {
  final VoidCallback? onAppBarBackPressed;

  const PaymentMethodsScreen({Key? key, this.onAppBarBackPressed}) : super(key: key);

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final _textStyles = RobotoTextStyles();
  String? _selectedPaymentMethodId;

  final List<PaymentMethodItem> _paymentMethods = [
    PaymentMethodItem(id: 'cash', type: PaymentMethodType.cash, name: AppStrings.cash, iconAssetPath: 'assets/icons/payment_methods/cash.png', isSelected: true),
    PaymentMethodItem(id: 'paypal', type: PaymentMethodType.paypal, name: AppStrings.paypal, iconAssetPath: 'assets/icons/payment_methods/paypal.png'),
    PaymentMethodItem(id: 'google_pay', type: PaymentMethodType.googlePay, name: AppStrings.googlePay, iconAssetPath: 'assets/icons/payment_methods/googlePay.png'),
    PaymentMethodItem(id: 'apple_pay', type: PaymentMethodType.applePay, name: AppStrings.applePay, iconAssetPath: 'assets/icons/payment_methods/applePay.png'),
    PaymentMethodItem(
        id: 'card_0895',
        type: PaymentMethodType.creditCard,
        name: "**** **** **** 0895",
        iconAssetPath: 'assets/icons/payment_methods/visa_icon.png',
        last4Digits: "0895",
        cardBrandIconPath: 'assets/icons/payment_methods/visa_icon.png'
    ),
    PaymentMethodItem(
        id: 'card_2259',
        type: PaymentMethodType.creditCard,
        name: "**** **** **** 2259",
        iconAssetPath: 'assets/icons/payment_methods/jcb_icon.png',
        last4Digits: "2259",
        cardBrandIconPath: 'assets/icons/payment_methods/jcb_icon.png'
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (_paymentMethods.isNotEmpty) {
      final selectedMethod = _paymentMethods.firstWhere((method) => method.isSelected, orElse: () => _paymentMethods.first);
      _selectedPaymentMethodId = selectedMethod.id;
    }
  }

  void _onPaymentMethodSelected(String methodId) {
    setState(() {
      _selectedPaymentMethodId = methodId;
      for (var method in _paymentMethods) {
        method.isSelected = (method.id == methodId);
      }
    });
  }

  void _navigateToAddCard() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewCardScreen()),
    );
    if (result == true && mounted) {
      setState(() {});
      print("Returned from AddNewCardScreen, refresh needed if card added.");
    }
  }

  void _applyPaymentMethod() {
    Navigator.maybePop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral50,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        shadowColor: AppColors.neutral200.withOpacity(0.7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800, size: 20),
          onPressed: widget.onAppBarBackPressed ?? () => Navigator.maybePop(context),
        ),
        title: Text(
          AppStrings.paymentMethods,
          style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24), vertical: AppResponsive.height(20)),
              itemCount: _paymentMethods.length + 1,
              itemBuilder: (context, index) {
                if (index == _paymentMethods.length) {
                  return _buildAddNewCardButton();
                }
                final method = _paymentMethods[index];
                return _buildPaymentMethodTile(method);
              },
              separatorBuilder: (context, index) {
                if (index == _paymentMethods.length -1 && _paymentMethods.isNotEmpty) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: AppResponsive.height(2.0)),
                  child: Divider(height: 0.5, color: AppColors.neutral100.withOpacity(0.7), indent: AppResponsive.width(16), endIndent: AppResponsive.width(16), thickness: 0.5,),
                );
              },
            ),
          ),
          _buildApplyButton(),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodTile(PaymentMethodItem method) {
    bool isSelected = method.id == _selectedPaymentMethodId;
    String displayName = method.name;

    // Asosiy ikonka har doim method.iconAssetPath bo'ladi,
    // chunki _paymentMethods ro'yxatida kredit kartalar uchun ham
    // iconAssetPath ga brend ikonkasini yozdik.
    String displayIconPath = method.iconAssetPath;

    return Container(
      margin: EdgeInsets.only(bottom: AppResponsive.height(10)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppResponsive.height(12)),
        boxShadow: [
          BoxShadow(
            color: isSelected ? AppColors.primary100.withOpacity(0.6) : AppColors.neutral100.withOpacity(0.8),
            spreadRadius: isSelected ? 1.2 : 0.8,
            blurRadius: isSelected ? 3.5 : 2.0,
            offset: const Offset(0, 1),
          ),
        ],
        border: isSelected
            ? Border.all(color: AppColors.primary300, width: 1.5)
            : Border.all(color: AppColors.neutral200, width: 1.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onPaymentMethodSelected(method.id),
          borderRadius: BorderRadius.circular(AppResponsive.height(12)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16), vertical: AppResponsive.height(16)),
            child: Row(
              children: [
                Image.asset(
                  displayIconPath, // Har doim shu yo'ldan oladi
                  width: AppResponsive.width(36),
                  height: AppResponsive.width(24),
                  fit: BoxFit.contain,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    print('Error loading asset: $displayIconPath');
                    return Icon(Icons.error_outline, color: AppColors.primary500, size: AppResponsive.width(32));
                  },
                ),
                SizedBox(width: AppResponsive.width(16)),
                Expanded(
                  child: Text(
                    displayName,
                    style: _textStyles.medium(
                      color: isSelected ? AppColors.primary500 : AppColors.textPrimary,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Radio<String>(
                  value: method.id,
                  groupValue: _selectedPaymentMethodId,
                  onChanged: (String? value) {
                    if (value != null) {
                      _onPaymentMethodSelected(value);
                    }
                  },
                  activeColor: AppColors.primary500,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddNewCardButton() {
    return Padding(
      padding: EdgeInsets.only(top: AppResponsive.height(16.0)),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primary50.withOpacity(0.8),
          padding: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppResponsive.height(12)),
            side: BorderSide(
              color: AppColors.primary100.withOpacity(0.7),
              width: 1.0,
            ),
          ),
          alignment: Alignment.center,
        ),
        icon: const Icon(
          Icons.add_circle_outline_rounded,
          color: AppColors.primary500,
          size: 22,
        ),
        label: Text(
          AppStrings.addNewCard,
          style: _textStyles.semiBold(fontSize: 14, color: AppColors.primary500),
        ),
        onPressed: _navigateToAddCard,
      ),
    );
  }

  Widget _buildApplyButton() {
    return Container(
      padding: EdgeInsets.only(
        left: AppResponsive.width(24),
        right: AppResponsive.width(24),
        top: AppResponsive.height(16),
        bottom: AppResponsive.height(24) + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), spreadRadius: 0, blurRadius: 10, offset: const Offset(0, -2),),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary500,
            padding: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(28)),),
          ),
          onPressed: _applyPaymentMethod,
          child: Text(
            AppStrings.apply,
            style: _textStyles.semiBold(color: AppColors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}