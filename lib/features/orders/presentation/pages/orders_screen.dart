import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import '../widgets/order_search_bar_widget.dart';
import '../widgets/order_filter_tabs_widget.dart';
import '../widgets/order_item_card_widget.dart';

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
      'itemImageUrls': [
        'assets/images/orders/order_item1.png', 'assets/images/orders/order_item2.png', 'assets/images/orders/order_item3.png',
      ]
    },
    {
      'id': 'SP 0023512', 'price': '£ 40.00', 'status': AppStrings.completed, 'rating': 5.0,
      'itemImageUrls': [ 'assets/images/orders/order_item4.png', 'assets/images/orders/order_item5.png',]
    },
    {
      'id': 'SP 0023502', 'price': '£ 85.00', 'status': AppStrings.completed, 'rating': 4.5,
      'itemImageUrls': [
        'assets/images/orders/order_item6.png', 'assets/images/orders/order_item1.png',
        'assets/images/orders/order_item3.png', 'assets/images/orders/order_item5.png',
      ]
    },
    {
      'id': 'SP 0023450', 'price': '£ 20.50', 'status': AppStrings.cancelled, 'rating': 0.0,
      'itemImageUrls': [ 'assets/images/orders/order_item2.png', 'assets/images/orders/order_item4.png',]
    },
    {
      'id': 'SP 0023901', 'price': '£ 30.10', 'status': AppStrings.active, 'rating': 0.0,
      'itemImageUrls': [ 'assets/images/orders/order_item5.png', ]
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
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800),
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
            onFilterPressed: () {
              print("Order filter options tapped (from OrdersScreen)");
            },
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
          top: AppResponsive.height(8),
          bottom: AppResponsive.height(16)
      ),
      itemCount: _filteredOrders.length,
      itemBuilder: (context, index) {
        final orderData = _filteredOrders[index];
        return OrderItemCardWidget(
          orderData: orderData,
          onTap: () {
            print("Order ${orderData['id']} tapped from card widget");
          },
        );
      },
    );
  }
}