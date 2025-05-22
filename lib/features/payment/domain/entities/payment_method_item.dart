import 'payment_method_type.dart';

class PaymentMethodItem {
  final String id;
  final PaymentMethodType type;
  final String name;
  final String iconAssetPath;
  bool isSelected;

  final String? last4Digits;
  final String? cardBrandIconPath;

  PaymentMethodItem({
    required this.id,
    required this.type,
    required this.name,
    required this.iconAssetPath,
    this.isSelected = false,
    this.last4Digits,
    this.cardBrandIconPath,
  });
}