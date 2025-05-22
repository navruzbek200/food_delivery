import 'addon_model.dart';

class ProductModel {
  final String id;
  final String name;
  final String imagePath;
  final double originalPrice;
  final double discountedPrice;
  final List<AddonModel> availableAddons;

  ProductModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.originalPrice,
    required this.discountedPrice,
    this.availableAddons = const [],
  });
}