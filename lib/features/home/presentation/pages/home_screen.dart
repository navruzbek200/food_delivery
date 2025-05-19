import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import '../widgets/home_widgets/home_screen_content.dart';
import 'package:food_delivery/features/orders/presentation/pages/orders_screen.dart';
import 'package:food_delivery/features/likes/presentation/pages/liked_screen.dart';
import 'package:food_delivery/features/notifications/presentation/pages/notification_screen.dart';
import 'package:food_delivery/features/profile/presentation/pages/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBottomNavIndex = 0;
  late PageController _pageController;

  final List<Map<String, dynamic>> _promoBannersData = [
    {'image': 'assets/images/promos/banner1.png', 'line1': AppStrings.iceCreamDay, 'line2': AppStrings.getYourSweetIceCream, 'line3': AppStrings.fortyPercentOff, 'bgColor': '#FAB53C', 'line1Color': AppColors.white, 'line2Color': AppColors.white, 'line3Color': AppColors.white,},
    {'image': 'assets/images/promos/banner2.png', 'line1': AppStrings.greenDay, 'line2': AppStrings.upToSixtyPercentOff, 'line3': AppStrings.saladCategory, 'bgColor': '#095C47', 'line1Color': AppColors.white, 'line2Color': AppColors.green200, 'line3Color': AppColors.white,},
    {'image': 'assets/images/promos/banner3.png', 'line1': AppStrings.couplesDeal, 'line2': AppStrings.doubleHappiness, 'line3': AppStrings.happyValentinesDay, 'bgColor': '#000000', 'line1Color': AppColors.white, 'line2Color': AppColors.primary200, 'line3Color': AppColors.white,},
  ];

  final List<Map<String, dynamic>> _homeScreenCategoriesData = [
    {'name': "Burger", 'imagePath': 'assets/images/categories/burger.png'},
    {'name': "Taco", 'imagePath': 'assets/images/categories/taco.png'},
    {'name': "Burrito", 'imagePath': 'assets/images/categories/burrito.png'},
    {'name': "Drink", 'imagePath': 'assets/images/categories/drink.png'},
    {'name': "Pizza", 'imagePath': 'assets/images/categories/pizza.png'},
    {'name': "Donut", 'imagePath': 'assets/images/categories/donut.png'},
    {'name': "Salad", 'imagePath': 'assets/images/categories/salad.png'},
    {'name': "Noodles", 'imagePath': 'assets/images/categories/noodles.png'},
    {'name': "Sandwich", 'imagePath': 'assets/images/categories/sandwich.png'},
    {'name': "Pasta", 'imagePath': 'assets/images/categories/pasta.png'},
    {'name': "Ice Cream", 'imagePath': 'assets/images/categories/ice cream.png'},
    {'name': AppStrings.more, 'imagePath': 'assets/images/categories/more.png'},
  ];

  final List<Map<String, String>> _specialOffersData = [
    {'id': '1', 'image': 'assets/images/offers/offer1.png', 'name': 'Chicken Burger', 'price': '£6.00', 'oldPrice': '£10.00', 'rating': '4.9', 'isLiked': 'true'},
    {'id': '2', 'image': 'assets/images/offers/offer2.png', 'name': 'Beef Burger', 'price': '£10.00', 'oldPrice': '£12.00', 'rating': '4.9', 'isLiked': 'true'},
    {'id': '3', 'image': 'assets/images/offers/offer3.png', 'name': 'Ramen Noodles', 'price': '£15.00', 'oldPrice': '£22.00', 'rating': '4.9', 'isLiked': 'ture'},
    {'id': '4', 'image': 'assets/images/offers/offer4.png', 'name': 'Pork Burger', 'price': '£10.00', 'oldPrice': '£12.00', 'rating': '4.9', 'isLiked': 'true'},
    {'id': '5', 'image': 'assets/images/offers/offer5.png', 'name': 'Vegetarian Burger', 'price': '£5.00', 'oldPrice': '£10.00', 'rating': '4.9', 'isLiked': 'true'},
    {'id': '6', 'image': 'assets/images/offers/offer6.png', 'name': 'Pepperoni Special', 'price': '£9.50', 'oldPrice': '£12.00', 'rating': '4.8', 'isLiked': 'true'},
    {'id': '7', 'image': 'assets/images/offers/offer7.png', 'name': 'Greek Salad Bowl', 'price': '£6.50', 'oldPrice': '', 'rating': '4.6', 'isLiked': 'true'},
    {'id': '8', 'image': 'assets/images/offers/offer8.png', 'name': 'Fresh Fruit', 'price': '£6.50', 'oldPrice': '', 'rating': '4.7', 'isLiked': 'true'},

  ];

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentBottomNavIndex);
    _buildScreensList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToHomeTab() {
    if (_pageController.hasClients && _pageController.page?.round() != 0) {
      _pageController.jumpToPage(0);
    }
  }

  void _buildScreensList() {
    _screens = [
      HomeScreenContent(
        promoBannersData: _promoBannersData,
        categoriesData: _homeScreenCategoriesData,
        specialOffersData: _specialOffersData,
        onLikeToggleInDataSource: _handleLikeToggleFromHome,
      ),
      OrdersScreen(onAppBarBackPressed: _navigateToHomeTab),
      LikedScreen(
        allOffersDataRef: _specialOffersData,
        onAppBarBackPressed: _navigateToHomeTab,
      ),
      NotificationScreen(onAppBarBackPressed: _navigateToHomeTab),
      ProfileScreen(onAppBarBackPressed: _navigateToHomeTab),
    ];
  }

  void _onBottomNavTapped(int index) {
    if (mounted) {
      setState(() {
        _currentBottomNavIndex = index;
      });
      _pageController.jumpToPage(index);
    }
  }

  void _handleLikeToggleFromHome(int originalIndexInSpecialOffers, bool newLikeState) {
    if (mounted && originalIndexInSpecialOffers >= 0 && originalIndexInSpecialOffers < _specialOffersData.length) {
      setState(() {
        _specialOffersData[originalIndexInSpecialOffers]['isLiked'] = newLikeState.toString();
        _buildScreensList();
      });
    }
  }

  BottomNavigationBarItem _buildBottomNavItem({
    required int index,
    required String inactiveIconPath,
    required String activeIconPath,
    required String label,
  }) {
    bool isActive = _currentBottomNavIndex == index;
    double inactiveIconSize = AppResponsive.height(24);
    double activeIconInCircleSize = AppResponsive.height(22);
    double activeCircleDiameter = AppResponsive.height(42);
    Widget iconWidget;
    if (isActive) {
      iconWidget = Container(
        width: activeCircleDiameter,
        height: activeCircleDiameter,
        decoration: const BoxDecoration(
          color: AppColors.primary500,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            activeIconPath,
            width: activeIconInCircleSize,
            height: activeIconInCircleSize,
            colorFilter: const ColorFilter.mode(
              AppColors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      );
    } else {
      iconWidget = SvgPicture.asset(
        inactiveIconPath,
        width: inactiveIconSize,
        height: inactiveIconSize,
        colorFilter: const ColorFilter.mode(
          AppColors.neutral500,
          BlendMode.srcIn,
        ),
      );
    }
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(
          top: AppResponsive.height(isActive ? 6 : 8),
          bottom: AppResponsive.height(isActive ? 2 : 4),
        ),
        child: iconWidget,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = RobotoTextStyles();
    return WillPopScope(
      onWillPop: () async {
        if (_pageController.hasClients && _pageController.page?.round() != 0) {
          _pageController.jumpToPage(0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            if (mounted) {
              setState(() {
                _currentBottomNavIndex = index;
              });
            }
          },
          physics: const NeverScrollableScrollPhysics(),
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentBottomNavIndex,
          onTap: _onBottomNavTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primary500,
          unselectedItemColor: AppColors.neutral500,
          selectedLabelStyle: textStyles.medium(
            color: AppColors.primary500,
            fontSize: 12,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 8.0,
          items: [
            _buildBottomNavItem(index: 0, inactiveIconPath: 'assets/icons/bottom_nav/home_icon_inactive.svg', activeIconPath: 'assets/icons/bottom_nav/home_icon_active.svg', label: AppStrings.home,),
            _buildBottomNavItem(index: 1, inactiveIconPath: 'assets/icons/bottom_nav/orders_icon_inactive.svg', activeIconPath: 'assets/icons/bottom_nav/orders_icon_active.svg', label: AppStrings.orders,),
            _buildBottomNavItem(index: 2, inactiveIconPath: 'assets/icons/bottom_nav/liked_icon_inactive.svg', activeIconPath: 'assets/icons/bottom_nav/liked_icon_active.svg', label: AppStrings.liked,),
            _buildBottomNavItem(index: 3, inactiveIconPath: 'assets/icons/bottom_nav/notification_icon_inactive.svg', activeIconPath: 'assets/icons/bottom_nav/notification_icon_active.svg', label: AppStrings.notify,),
            _buildBottomNavItem(index: 4, inactiveIconPath: 'assets/icons/bottom_nav/profile_icon_inactive.svg', activeIconPath: 'assets/icons/bottom_nav/profile_icon_active.svg', label: AppStrings.profile,),
          ],
        ),
      ),
    );
  }
}