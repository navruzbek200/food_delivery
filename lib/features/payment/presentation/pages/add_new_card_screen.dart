import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/payment/domain/entities/credit_card_info.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class AddNewCardScreen extends StatefulWidget {
  final VoidCallback? onAppBarBackPressed;

  const AddNewCardScreen({Key? key, this.onAppBarBackPressed}) : super(key: key);

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  final _textStyles = RobotoTextStyles();
  final _formKey = GlobalKey<FormState>();

  final _cardNumberController = TextEditingController();
  final _cardHolderNameController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  CreditCardInfo _cardInfo = CreditCardInfo();
  bool _isCardNumberFocused = false;
  bool _isCardHolderFocused = false;
  bool _isExpiryDateFocused = false;
  bool _isCvvFocused = false;

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_updateCardPreview);
    _cardHolderNameController.addListener(_updateCardPreview);
    _expiryDateController.addListener(_updateCardPreview);
    _cvvController.addListener(_updateCardPreview);
  }

  void _updateCardPreview() {
    if(mounted){
      setState(() {
        _cardInfo = CreditCardInfo(
          cardNumber: _cardNumberController.text,
          cardHolderName: _cardHolderNameController.text,
          expiryDate: _expiryDateController.text,
          cvv: _cvvController.text,
          cardType: CreditCardInfo.detectCardType(_cardNumberController.text),
        );
      });
    }
  }

  @override
  void dispose() {
    _cardNumberController.removeListener(_updateCardPreview);
    _cardHolderNameController.removeListener(_updateCardPreview);
    _expiryDateController.removeListener(_updateCardPreview);
    _cvvController.removeListener(_updateCardPreview);
    _cardNumberController.dispose();
    _cardHolderNameController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _onSaveCard() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      _showPaymentSuccessfulDialog();
    }
  }

  void _showPaymentSuccessfulDialog() {
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
              Image.asset(
                'assets/images/payment_successful.png',
                height: AppResponsive.height(120),
              ),
              SizedBox(height: AppResponsive.height(24)),
              Text(
                AppStrings.paymentSuccessful,
                style: _textStyles.bold(fontSize: 20, color: AppColors.textPrimary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppResponsive.height(8)),
              Text(
                AppStrings.paymentProcessedSuccessfully,
                style: _textStyles.regular(fontSize: 14, color: AppColors.textSecondary),
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
                  child: Text(AppStrings.okGreat, style: _textStyles.semiBold(color: AppColors.white, fontSize: 16)),
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
          AppStrings.addNewCard,
          style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppResponsive.width(24)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCreditCardPreview(),
                SizedBox(height: AppResponsive.height(32)),
                _buildCardNumberField(),
                SizedBox(height: AppResponsive.height(20)),
                _buildCardHolderNameField(),
                SizedBox(height: AppResponsive.height(20)),
                Row(
                  children: [
                    Expanded(child: _buildExpiryDateField()),
                    SizedBox(width: AppResponsive.width(16)),
                    Expanded(child: _buildCvvField()),
                  ],
                ),
                SizedBox(height: AppResponsive.height(40)),
                _buildSaveButton(),
                SizedBox(height: AppResponsive.height(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCardPreview() {
    String displayCardNumber = _cardInfo.cardNumber.padRight(19, ' ');
    if (_cardInfo.cardNumber.replaceAll(' ', '').length > 4) {
      displayCardNumber = "**** **** **** ${_cardInfo.cardNumber.replaceAll(' ', '').substring(_cardInfo.cardNumber.replaceAll(' ', '').length - 4)}";
    } else if (_cardInfo.cardNumber.isNotEmpty) {
      String tempNum = _cardInfo.cardNumber.replaceAll(' ', '');
      if (tempNum.length <= 16) {
        displayCardNumber = tempNum.padRight(16, '*').replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
      } else {
        displayCardNumber = tempNum.substring(0,16).replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
      }
    } else {
      displayCardNumber = "**** **** **** ****";
    }

    String displayExpiry = _cardInfo.expiryDate.isEmpty ? "--/--" : _cardInfo.expiryDate;
    String displayHolder = _cardInfo.cardHolderName.isEmpty ? AppStrings.cardholderNamePlaceholder : _cardInfo.cardHolderName;

    String? cardBrandAssetPath;
    switch (_cardInfo.cardType) {
      case CardType.visa: cardBrandAssetPath = 'assets/icons/payment_methods/visa_icon.png'; break;
      case CardType.mastercard: cardBrandAssetPath = 'assets/icons/payment_methods/mastercard_icon.png'; break;
      case CardType.jcb: cardBrandAssetPath = 'assets/icons/payment_methods/jcb_icon.png'; break;
      case CardType.amex: cardBrandAssetPath = 'assets/icons/payment_methods/amex_icon.png'; break;
      case CardType.discover: cardBrandAssetPath = 'assets/icons/payment_methods/discover_icon.png'; break;
      default: cardBrandAssetPath = null;
    }

    return Container(
      padding: EdgeInsets.all(AppResponsive.width(20)),
      height: AppResponsive.height(190),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFF7E61), Color(0xFFFF6247)], begin: Alignment.topLeft, end: Alignment.bottomRight,),
        borderRadius: BorderRadius.circular(AppResponsive.height(16)),
        boxShadow: [BoxShadow(color: AppColors.primary300.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 4)),],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: cardBrandAssetPath != null
                ? Image.asset(cardBrandAssetPath, height: AppResponsive.height(30))
                : SizedBox(height: AppResponsive.height(30)),
          ),
          Text(
            displayCardNumber.trim(),
            style: _textStyles.semiBold(color: AppColors.white, fontSize: 22,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.cardHolderName.toUpperCase(), style: _textStyles.regular(color: AppColors.white.withOpacity(0.7), fontSize: 10, ),),
                    SizedBox(height: AppResponsive.height(4)),
                    Text(displayHolder, style: _textStyles.medium(color: AppColors.white, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(AppStrings.expiryDateShort.toUpperCase(), style: _textStyles.regular(color: AppColors.white.withOpacity(0.7), fontSize: 10, ),),
                    SizedBox(height: AppResponsive.height(4)),
                    Text(displayExpiry, style: _textStyles.medium(color: AppColors.white, fontSize: 14),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardNumberField() {
    return Focus(
      onFocusChange: (hasFocus) => setState(() => _isCardNumberFocused = hasFocus),
      child: TextFormField(
        controller: _cardNumberController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(16), CardNumberInputFormatter(),],
        decoration: _inputDecoration(labelText: AppStrings.cardNumber, hintText: AppStrings.enterCardNumber, isFocused: _isCardNumberFocused,),
        validator: (value) {
          if (value == null || value.replaceAll(' ', '').length < 16) return AppStrings.validateCardNumber;
          return null;
        },
      ),
    );
  }

  Widget _buildCardHolderNameField() {
    return Focus(
      onFocusChange: (hasFocus) => setState(() => _isCardHolderFocused = hasFocus),
      child: TextFormField(
        controller: _cardHolderNameController,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        decoration: _inputDecoration(labelText: AppStrings.cardHolderName, hintText: AppStrings.enterCardholderName, isFocused: _isCardHolderFocused,),
        validator: (value) {
          if (value == null || value.isEmpty) return AppStrings.validateCardHolderName;
          return null;
        },
      ),
    );
  }

  Widget _buildExpiryDateField() {
    return Focus(
      onFocusChange: (hasFocus) => setState(() => _isExpiryDateFocused = hasFocus),
      child: TextFormField(
        controller: _expiryDateController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4), ExpiryDateInputFormatter(),],
        decoration: _inputDecoration(labelText: AppStrings.expiryDate, hintText: AppStrings.mmYY, isFocused: _isExpiryDateFocused, suffixIcon: Icon(Icons.calendar_today_outlined, size: 20, color: _isExpiryDateFocused ? AppColors.primary500 : AppColors.neutral400)),
        validator: (value) {
          if (value == null || value.length < 5) return AppStrings.validateExpiryDate;
          return null;
        },
      ),
    );
  }

  Widget _buildCvvField() {
    return Focus(
      onFocusChange: (hasFocus) => setState(() => _isCvvFocused = hasFocus),
      child: TextFormField(
        controller: _cvvController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3),],
        obscureText: true,
        decoration: _inputDecoration(labelText: AppStrings.cvvCvc, hintText: AppStrings.enterCvv, isFocused: _isCvvFocused,),
        validator: (value) {
          if (value == null || value.length < 3) return AppStrings.validateCvv;
          return null;
        },
      ),
    );
  }

  InputDecoration _inputDecoration({required String labelText, required String hintText, bool isFocused = false, Widget? suffixIcon}) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: _textStyles.regular(color: AppColors.neutral400, fontSize: 14),
      labelStyle: _textStyles.regular(color: isFocused ? AppColors.primary500 : AppColors.neutral600, fontSize: 14),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16), vertical: AppResponsive.height(16)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: BorderSide(color: AppColors.neutral200, width: 1)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: BorderSide(color: AppColors.neutral200, width: 1)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: BorderSide(color: AppColors.primary500, width: 1.5)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: BorderSide(color: AppColors.primary500, width: 1)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: BorderSide(color: AppColors.primary500, width: 1.5)),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary500,
          padding: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppResponsive.height(25)),
          ),
        ),
        onPressed: _onSaveCard,
        child: Text(
          AppStrings.save,
          style: _textStyles.semiBold(color: AppColors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(' ', '');
    if (text.length > 16) text = text.substring(0, 16);
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  ');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length && nonZeroIndex < 4) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}