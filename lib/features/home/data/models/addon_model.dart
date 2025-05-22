class AddonModel {
  final String name;
  final double price;
  bool isSelected;

  AddonModel({
    required this.name,
    required this.price,
    this.isSelected = false,
  });
}