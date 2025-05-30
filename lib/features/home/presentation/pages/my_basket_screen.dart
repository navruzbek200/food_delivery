import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/home/presentation/bloc/create_order/create_order_bloc.dart';
import 'package:food_delivery/features/home/presentation/bloc/home_event.dart';
import 'package:food_delivery/features/orders/presentation/pages/orders_screen.dart';
import 'dart:math';

import 'package:food_delivery/features/payment/presentation/pages/payment_methods_screen.dart';
import 'package:food_delivery/features/profile/presentation/pages/promotion_information_screen.dart';

class MyBasketScreen extends StatefulWidget {
  const MyBasketScreen({Key? key}) : super(key: key);

  static List<Map<String, dynamic>> _globalBasketItems = [];

  static void addFoodItemToGlobalBasket(Map<String, dynamic> newItemDataFromFoodDetail) {
    String productId = newItemDataFromFoodDetail['productId'] as String;
    List<Map<String, dynamic>> selectedOptions =
    List<Map<String, dynamic>>.from(newItemDataFromFoodDetail['selectedOptionsDetails'] ?? []);
    int quantityToAdd = newItemDataFromFoodDetail['quantityToAdd'] as int? ?? 1;

    String generateOptionsKey(List<Map<String, dynamic>> options) {
      if (options.isEmpty) return "";
      List<String> optionNames = options.map((opt) => opt['name'] as String).toList();
      optionNames.sort();
      return optionNames.join(',');
    }

    String newOptionsKey = generateOptionsKey(selectedOptions);
    int existingItemIndex = -1;

    for (int i = 0; i < _globalBasketItems.length; i++) {
      var basketItem = _globalBasketItems[i];
      if (basketItem['productId'] == productId &&
          generateOptionsKey(List<Map<String, dynamic>>.from(basketItem['options'] ?? [])) == newOptionsKey) {
        existingItemIndex = i;
        break;
      }
    }

    if (existingItemIndex != -1) {
      _globalBasketItems[existingItemIndex]['quantity'] =
          (_globalBasketItems[existingItemIndex]['quantity'] as int) + quantityToAdd;
    } else {
      _globalBasketItems.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString() + Random().nextInt(1000).toString(),
        'productId': productId,
        'name': newItemDataFromFoodDetail['name'],
        'image': newItemDataFromFoodDetail['image'],
        'currentPrice': newItemDataFromFoodDetail['currentPrice'],
        'oldPrice': newItemDataFromFoodDetail['oldPrice'],
        'quantity': quantityToAdd,
        'options': selectedOptions,
      });
    }
  }

  @override
  State<MyBasketScreen> createState() => _MyBasketScreenState();
}

class _MyBasketScreenState extends State<MyBasketScreen> {
  final _textStyles = RobotoTextStyles();

  String _selectedPaymentMethod = "Cash";
  List<String> _appliedPromotions = ["FREE SHIPPING", "20%"];

  @override
  void initState() {
    super.initState();
  }

  void _updateQuantity(String itemId, int change) {
    setState(() {
      int itemIndex = MyBasketScreen._globalBasketItems.indexWhere((item) => item['id'] == itemId);
      if (itemIndex != -1) {
        int newQuantity = MyBasketScreen._globalBasketItems[itemIndex]['quantity'] + change;
        if (newQuantity >= 1) {
          MyBasketScreen._globalBasketItems[itemIndex]['quantity'] = newQuantity;
        } else if (newQuantity <= 0) {
          _removeItem(itemId);
        }
      }
    });
  }

  void _removeItem(String itemId) {
    String itemName = 'Mahsulot';
    int itemIndex = MyBasketScreen._globalBasketItems.indexWhere((item) => item['id'] == itemId);
    if(itemIndex != -1) {
      itemName = MyBasketScreen._globalBasketItems[itemIndex]['name'] as String;
    }

    setState(() {
      MyBasketScreen._globalBasketItems.removeWhere((item) => item['id'] == itemId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$itemName savatdan o\'chirildi.'),
        backgroundColor: AppColors.primary500,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _editItem(Map<String, dynamic> itemToEdit) {
    print("Tahrirlash: ${itemToEdit['name']}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tahrirlash funksiyasi ${itemToEdit['name']} uchun hozircha mavjud emas.')),
    );
  }

  void _navigateToAddItems() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _navigateToPaymentMethods() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => PaymentMethodsScreen()));
    print("To'lov usullari sahifasiga o'tish");
  }

  void _navigateToPromotions() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => PromotionInformationScreen()));
    print("Promokodlar sahifasiga o'tish");
  }


  double _parsePrice(String? priceString) {
    if (priceString == null || priceString.isEmpty) return 0.0;
    return double.tryParse(priceString.replaceAll('£', '').replaceAll('+', '').trim()) ?? 0.0;
  }

  double get _subtotal {
    double total = 0;
    for (var item in MyBasketScreen._globalBasketItems) {
      double itemPrice = _parsePrice(item['currentPrice'] as String?);
      double optionsTotal = 0;
      if (item['options'] != null) {
        for (var option in item['options'] as List<Map<String,dynamic>>) {
          optionsTotal += _parsePrice(option['price'] as String?);
        }
      }
      total += (itemPrice + optionsTotal) * (item['quantity'] as int);
    }
    return total;
  }

  double get _discountAmount {
    if (_appliedPromotions.contains("20%")) {
      return _subtotal * 0.20;
    }
    return 0.0;
  }

  double get _shippingCost {
    if(_appliedPromotions.contains("FREE SHIPPING")){
      return 0.0;
    }
    return MyBasketScreen._globalBasketItems.isNotEmpty ? 2.50 : 0.0;
  }


  double get _finalTotal {
    return _subtotal - _discountAmount + _shippingCost;
  }

  void _placeOrder() {
    if (MyBasketScreen._globalBasketItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Savat bo\'sh! Avval mahsulot qo\'shing.')),
      );
      return;
    }

      context.read<CreateOrderBloc>().add(CreateOrderEvent(count: 3, food_id: 2));

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => const OrdersScreen(),
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral50,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        shadowColor: AppColors.neutral300.withOpacity(0.5),
        leading: Padding(
          padding: EdgeInsets.all(AppResponsive.width(8.0)),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            borderRadius: BorderRadius.circular(AppResponsive.width(12)),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.neutral100,
                borderRadius: BorderRadius.circular(AppResponsive.width(12)),
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: AppColors.neutral800, size: 20),
            ),
          ),
        ),
        title: Text(
          'My Basket',
          style: _textStyles.semiBold(
            color: AppColors.neutral900,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: MyBasketScreen._globalBasketItems.isEmpty
                ? _buildEmptyBasketMessage()
                : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16), vertical: AppResponsive.height(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOrderSummaryHeader(),
                  SizedBox(height: AppResponsive.height(16)),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: MyBasketScreen._globalBasketItems.length,
                    itemBuilder: (context, index) {
                      return _buildBasketItemCard(MyBasketScreen._globalBasketItems[index]);
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: AppResponsive.height(16)),
                  ),
                  SizedBox(height: AppResponsive.height(24)),
                  _buildPaymentMethodSection(),
                  SizedBox(height: AppResponsive.height(16)),
                  _buildPromotionsSection(),
                  SizedBox(height: AppResponsive.height(24)),
                ],
              ),
            ),
          ),
          if (MyBasketScreen._globalBasketItems.isNotEmpty) _buildTotalsAndPlaceOrderButton(),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryHeader() {
    return Padding(
      padding: EdgeInsets.only(bottom: AppResponsive.height(8.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Order Summary',
            style: _textStyles.semiBold(
              color: AppColors.neutral900,
              fontSize: 18,
            ),
          ),
          TextButton(
            onPressed: _navigateToAddItems, // BU METOD ENDI MAVJUD
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(12), vertical: AppResponsive.height(5)),
              backgroundColor: AppColors.white,
              side: const BorderSide(color: AppColors.primary500, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppResponsive.width(20)),
              ),
              visualDensity: VisualDensity.compact,
            ),
            child: Text(
              'Add Items',
              style: _textStyles.medium(
                color: AppColors.primary500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyBasketMessage() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(30), vertical: AppResponsive.height(50)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_checkout_outlined, size: AppResponsive.width(70), color: AppColors.neutral400),
            SizedBox(height: AppResponsive.height(20)),
            Text(
              'Your Basket is Empty',
              style: _textStyles.semiBold(color: AppColors.neutral700, fontSize: 20),
            ),
            SizedBox(height: AppResponsive.height(10)),
            Text(
              'Looks like you haven\'t added anything to your basket yet. Start shopping to fill it up!',
              textAlign: TextAlign.center,
              style: _textStyles.regular(color: AppColors.neutral600, fontSize: 15,),
            ),
            SizedBox(height: AppResponsive.height(30)),
            ElevatedButton(
                onPressed: _navigateToAddItems, // BU METOD ENDI MAVJUD
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary500,
                  padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(40), vertical: AppResponsive.height(14)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.width(25))),
                ),
                child: Text('Start Shopping', style: _textStyles.semiBold(color: AppColors.white, fontSize: 16))
            )
          ],
        ),
      ),
    );
  }


  Widget _buildBasketItemCard(Map<String, dynamic> item) {
    List<Map<String, dynamic>> options = List<Map<String, dynamic>>.from(item['options'] ?? []);

    return Container(
      // ... (Bu qism o'zgarmagan)
      padding: EdgeInsets.all(AppResponsive.width(12)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppResponsive.width(12)),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral200.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppResponsive.width(8)),
                child: Image.asset(
                  item['image'] as String,
                  width: AppResponsive.width(65),
                  height: AppResponsive.width(65),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: AppResponsive.width(65),
                    height: AppResponsive.width(65),
                    color: AppColors.neutral200,
                    child: const Icon(Icons.fastfood_outlined, color: AppColors.neutral400, size: 28),
                  ),
                ),
              ),
              SizedBox(width: AppResponsive.width(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] as String,
                      style: _textStyles.semiBold(
                          color: AppColors.neutral900, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppResponsive.height(4)),
                    Row(
                      children: [
                        if (item['oldPrice'] != null && (item['oldPrice'] as String).isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(right: AppResponsive.width(6)),
                            child: Text(
                              item['oldPrice'] as String,
                              style: _textStyles.regular(
                                color: AppColors.neutral500,
                                fontSize: 13,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                        Text(
                          item['currentPrice'] as String,
                          style: _textStyles.semiBold(
                            color: AppColors.primary500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppResponsive.height(8)),
                    _buildQuantitySelector(item['id'] as String, item['quantity'] as int),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => _editItem(item), // BU METOD ENDI MAVJUD
                    borderRadius: BorderRadius.circular(AppResponsive.width(10)),
                    child: Padding(
                      padding: EdgeInsets.all(AppResponsive.width(4.0)),
                      child: Icon(Icons.edit_outlined, color: AppColors.neutral600, size: AppResponsive.width(19)),
                    ),
                  ),
                  SizedBox(height: AppResponsive.height(8)),
                  InkWell(
                    onTap: () => _removeItem(item['id'] as String), // BU METOD ENDI MAVJUD
                    borderRadius: BorderRadius.circular(AppResponsive.width(10)),
                    child: Padding(
                      padding: EdgeInsets.all(AppResponsive.width(4.0)),
                      child: Icon(Icons.close_rounded, color: AppColors.primary500, size: AppResponsive.width(21)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (options.isNotEmpty) ...[
            Divider(height: AppResponsive.height(20), thickness: 0.5, color: AppColors.neutral200),
            Padding(
              padding: EdgeInsets.only(left: AppResponsive.width(4.0)),
              child: Column(
                children: options.map((opt) => Padding(
                  padding: EdgeInsets.only(bottom: AppResponsive.height(4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        opt['name'] as String,
                        style: _textStyles.regular(
                            color: AppColors.neutral700, fontSize: 13),
                      ),
                      Text(
                        (opt['price'] as String).startsWith('+') ? (opt['price'] as String) : '+ ${(opt['price'] as String)}',
                        style: _textStyles.regular(
                            color: AppColors.neutral700, fontSize: 13),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(String itemId, int quantity) {
    return Container(
      // ... (Bu qism o'zgarmagan)
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(4), vertical: AppResponsive.height(2)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppResponsive.width(20)),
        border: Border.all(color: AppColors.neutral300, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _quantityButton(
            icon: Icons.remove,
            onPressed: () => _updateQuantity(itemId, -1), // BU METOD ENDI MAVJUD
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(10)),
            child: Text(
              '$quantity',
              style: _textStyles.semiBold(
                color: AppColors.neutral900,
                fontSize: 15,
              ),
            ),
          ),
          _quantityButton(
            icon: Icons.add,
            onPressed: () => _updateQuantity(itemId, 1), // BU METOD ENDI MAVJUD
          ),
        ],
      ),
    );
  }

  Widget _quantityButton({required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      // ... (Bu qism o'zgarmagan)
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppResponsive.width(12)),
      child: Padding(
        padding: EdgeInsets.all(AppResponsive.width(5.0)),
        child: Icon(icon, color: AppColors.primary500, size: AppResponsive.width(17)),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required Widget child,
    required VoidCallback onTap,
  }) {
    return InkWell(
      // ... (Bu qism o'zgarmagan)
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppResponsive.width(12)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16), vertical: AppResponsive.height(14)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppResponsive.width(12)),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral200.withOpacity(0.5),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppResponsive.width(8)),
              decoration: BoxDecoration(
                  color: AppColors.primary100.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppResponsive.width(8))
              ),
              child: Icon(icon, color: AppColors.primary500, size: AppResponsive.width(22)),
            ),
            SizedBox(width: AppResponsive.width(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: _textStyles.medium(color: AppColors.neutral800, fontSize: 16)),
                  SizedBox(height: AppResponsive.height(4)),
                  child,
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: AppColors.neutral500, size: AppResponsive.width(16)),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return _buildSectionCard(
      icon: Icons.account_balance_wallet_outlined,
      title: 'Payment method',
      onTap: _navigateToPaymentMethods,
      child: Text(
        _selectedPaymentMethod,
        style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 15),
      ),
    );
  }

  Widget _buildPromotionsSection() {
    return _buildSectionCard(
      icon: Icons.local_offer_outlined,
      title: 'Promotions',
      onTap: _navigateToPromotions,
      child: _appliedPromotions.isEmpty
          ? Text('No promotions applied', style: _textStyles.regular(color: AppColors.neutral600, fontSize: 14))
          : Wrap(
        spacing: AppResponsive.width(8),
        runSpacing: AppResponsive.height(6),
        children: _appliedPromotions.map((promo) {
          Color bgColor = (promo == "FREE SHIPPING") ? AppColors.successGreen : AppColors.successGreen;
          Color textColor = AppColors.white;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(10), vertical: AppResponsive.height(4)),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(AppResponsive.width(6)),
            ),
            child: Text(
              promo,
              style: _textStyles.medium(
                  color: textColor,
                  fontSize: 12),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTotalsAndPlaceOrderButton() {
    return Container(
      // ... (Bu qism o'zgarmagan)
      padding: EdgeInsets.only(
        left: AppResponsive.width(20),
        right: AppResponsive.width(20),
        top: AppResponsive.height(16),
        bottom: AppResponsive.height(16) + MediaQuery.of(context).padding.bottom / 1.5 ,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, -5),
          )
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal', style: _textStyles.regular(color: AppColors.neutral700, fontSize: 15)),
              Text('£${_subtotal.toStringAsFixed(2)}', style: _textStyles.medium(color: AppColors.neutral800, fontSize: 15)),
            ],
          ),
          if(_shippingCost > 0) ...[
            SizedBox(height: AppResponsive.height(6)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping', style: _textStyles.regular(color: AppColors.neutral700, fontSize: 15)),
                Text('£${_shippingCost.toStringAsFixed(2)}', style: _textStyles.medium(color: AppColors.neutral800, fontSize: 15)),
              ],
            ),
          ],
          if (_discountAmount > 0) ...[
            SizedBox(height: AppResponsive.height(6)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Discount (20%)', style: _textStyles.regular(color: AppColors.successGreen, fontSize: 15)),
                Text('- £${_discountAmount.toStringAsFixed(2)}', style: _textStyles.medium(color: AppColors.successGreen, fontSize: 15)),
              ],
            ),
          ],
          SizedBox(height: AppResponsive.height(12)),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total', style: _textStyles.regular(color: AppColors.neutral700, fontSize: 13)),
                    Text(
                      '£${_finalTotal.toStringAsFixed(2)}',
                      style: _textStyles.bold(color: AppColors.neutral900, fontSize: 22),
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppResponsive.width(16)),
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: MyBasketScreen._globalBasketItems.isEmpty ? null : _placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary500,
                    disabledBackgroundColor: AppColors.neutral300,
                    padding: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppResponsive.width(30)),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Place Order',
                    style: _textStyles.semiBold(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}