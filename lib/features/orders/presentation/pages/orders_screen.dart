import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import '../widgets/order_search_bar_widget.dart';
import '../widgets/order_filter_tabs_widget.dart';
import '../widgets/order_item_card_widget.dart';
import 'order_detail_screen.dart';

class OrdersScreen extends StatefulWidget {
  final VoidCallback? onAppBarBackPressed;

  const OrdersScreen({Key? key, this.onAppBarBackPressed}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final _textStyles = RobotoTextStyles();
  String _searchText = "";
  late String _selectedStatusFilter;

  final List<Map<String, dynamic>> _allOrders = [
    {
      'id': 'SP 0023900', 'price': '£ 25.20', 'status': AppStrings.active, 'rating': 4.0,
      'itemImageUrls': ['assets/images/orders/order_item1.png', 'assets/images/orders/order_item2.png', 'assets/images/orders/order_item3.png',],
      'orderDate': DateTime.now().subtract(const Duration(days: 1)),
      'deliveryAddressLabel': 'Home',
      'deliveryAddressFull': '221B Baker Street, London, United Kingdom',
      'paymentMethod': 'Cash',
      'promotionsApplied': [{'name': 'FREE SHIPPING', 'discount': '20%'}],
      'subtotal': '£ 31.50',
      'deliveryFee': AppStrings.free,
      'discountValue': '£ 6.30',
      'orderedItems': [
        {'name': 'Chicken Burger', 'price': '£ 6.00', 'originalPrice': '£ 10.00', 'imagePath': 'assets/images/offers/offer1.png', 'addons': ['Add Cheese £0.50', 'Add Meat (Extra Patty) £2.00'], 'quantity': 1},
        {'name': 'Ramen Noodles', 'price': '£ 15.00', 'originalPrice': '£ 22.00', 'imagePath': 'assets/images/offers/offer3.png', 'addons': [], 'quantity': 1},
      ]
    },
    {
      'id': 'SP 0023512', 'price': '£ 40.00', 'status': AppStrings.completed, 'rating': 5.0,
      'itemImageUrls': [ 'assets/images/orders/order_item4.png', 'assets/images/orders/order_item5.png',],
      'orderDate': DateTime.now().subtract(const Duration(days: 2)),
      'deliveryAddressLabel': 'Office',
      'deliveryAddressFull': '1 Infinite Loop, Cupertino, CA',
      'paymentMethod': 'Credit Card **** 1234',
      'promotionsApplied': [],
      'subtotal': '£ 40.00',
      'deliveryFee': '£ 0.00',
      'discountValue': '£ 0.00',
      'orderedItems': [
        {'name': 'Beef Burger', 'price': '£ 10.00', 'originalPrice': '£ 12.00', 'imagePath': 'assets/images/offers/offer2.png', 'addons': [], 'quantity': 2},
        {'name': 'Cola Drink', 'price': '£ 1.50', 'originalPrice': '', 'imagePath': 'assets/images/categories/drink.png', 'addons': [], 'quantity': 4},
      ],
      'userReview': "Excellent service and food!",
      'userRating': 5.0,
    },
    {
      'id': 'SP 0023450', 'price': '£ 20.50', 'status': AppStrings.cancelled, 'rating': 0.0,
      'itemImageUrls': [ 'assets/images/orders/order_item2.png', 'assets/images/orders/order_item4.png',],
      'orderDate': DateTime.now().subtract(const Duration(days: 3)),
      'deliveryAddressLabel': 'Work',
      'deliveryAddressFull': '789 Business Park, Suite 101, Big City, USA',
      'paymentMethod': 'PayPal',
      'promotionsApplied': [{'name': 'WEEKENDDEAL', 'discount': '10%'}],
      'subtotal': '£ 22.78',
      'deliveryFee': AppStrings.free,
      'discountValue': '£ 2.28',
      'orderedItems': [
        {'name': 'Pork Burger', 'price': '£ 10.00', 'originalPrice': '£ 12.00', 'imagePath': 'assets/images/offers/offer4.png', 'addons': [], 'quantity': 1},
        {'name': 'Vegetarian Burger', 'price': '£ 5.00', 'originalPrice': '£ 10.00', 'imagePath': 'assets/images/offers/offer5.png', 'addons': ['Extra sauce £0.50'], 'quantity': 1},
      ],
      'cancellationReason': 'Duplicate order by mistake.',
    },
  ];
  List<Map<String, dynamic>> _filteredOrders = [];
  late List<String> _filterStatuses;

  @override
  void initState() {
    super.initState();
    _filterStatuses = [AppStrings.all, AppStrings.active, AppStrings.completed, AppStrings.cancelled];
    _selectedStatusFilter = _filterStatuses[0];
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      List<Map<String, dynamic>> tempOrders = List.from(_allOrders);
      if (_selectedStatusFilter != AppStrings.all) {
        tempOrders = tempOrders.where((order) => order['status'] == _selectedStatusFilter).toList();
      }
      if (_searchText.isNotEmpty) {
        tempOrders = tempOrders.where((order) {
          final idMatch = order['id']?.toLowerCase().contains(_searchText.toLowerCase()) ?? false;
          return idMatch;
        }).toList();
      }
      _filteredOrders = tempOrders;
    });
  }

  void _onSearchChanged(String query) {
    _searchText = query;
    _applyFilters();
  }

  void _onFilterTabSelected(String status) {
    _selectedStatusFilter = status;
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800, size: 20),
          onPressed: widget.onAppBarBackPressed ?? () => Navigator.maybePop(context),
        ),
        title: Text(
          AppStrings.orders,
          style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          OrderSearchBarWidget(
            onChanged: _onSearchChanged,
            onFilterPressed: () {},
          ),
          OrderFilterTabsWidget(
            selectedStatusFilter: _selectedStatusFilter,
            onFilterTabSelected: _onFilterTabSelected,
            statuses: _filterStatuses,
          ),
          Expanded(
            child: _buildOrdersList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList() {
    if (_filteredOrders.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppResponsive.width(20)),
          child: Text(
            _searchText.isNotEmpty ? AppStrings.notFoundOrders : AppStrings.noOrdersInThisCategory,
            style: _textStyles.semiBold(color: AppColors.neutral500, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(
          left: AppResponsive.width(24),
          right: AppResponsive.width(24),
          top: AppResponsive.height(16),
          bottom: AppResponsive.height(16)
      ),
      itemCount: _filteredOrders.length,
      itemBuilder: (context, index) {
        final orderDataMap = _filteredOrders[index];
        return OrderItemCardWidget(
          orderData: orderDataMap,
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailScreen(
                  initialOrderData: orderDataMap,
                  onAppBarBackPressed: widget.onAppBarBackPressed,
                ),
              ),
            );
            if (result == true && mounted) {
              _applyFilters();
            }
          },
        );
      },
    );
  }
}