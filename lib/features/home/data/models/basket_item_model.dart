import 'product_model.dart';
import 'addon_model.dart';

class BasketItemModel {
  final ProductModel product;
  int quantity;
  List<AddonModel> selectedAddons;

  BasketItemModel({
    required this.product,
    this.quantity = 1,
    List<AddonModel>? selectedAddons,
  }) : this.selectedAddons = selectedAddons ?? [];

  double get itemSubtotal {
    double addonsPrice = selectedAddons.fold(0, (sum, addon) => sum + addon.price);
    return (product.discountedPrice + addonsPrice) * quantity;
  }
}