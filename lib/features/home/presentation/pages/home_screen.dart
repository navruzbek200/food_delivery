import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/features/home/presentation/pages/search.dart';
import 'package:food_delivery/features/home/presentation/pages/special_offers.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textStyles = RobotoTextStyles();
  final TextEditingController _searchController = TextEditingController();
  int _currentBottomNavIndex = 0;

  final List<Map<String, dynamic>> _promoBannersData = [
    {'image': 'assets/images/promos/banner1.png', 'line1': AppStrings.iceCreamDay, 'line2': AppStrings.getYourSweetIceCream, 'line3': AppStrings.fortyPercentOff, 'bgColor': '#FFE8C9', 'line1Color': AppColors.neutral700, 'line2Color': AppColors.primary600, 'line3Color': AppColors.neutral800,},
    {'image': 'assets/images/promos/banner2.png', 'line1': AppStrings.greenDay, 'line2': AppStrings.upToSixtyPercentOff, 'line3': AppStrings.saladCategory, 'bgColor': '#D6F2E3', 'line1Color': AppColors.green700, 'line2Color': AppColors.white, 'line3Color': AppColors.green800,},
    {'image': 'assets/images/promos/banner3.png', 'line1': AppStrings.couplesDeal, 'line2': AppStrings.doubleHappiness, 'line3': AppStrings.happyValentinesDay, 'bgColor': '#303030', 'line1Color': AppColors.neutral200, 'line2Color': AppColors.primary300, 'line3Color': AppColors.white,},
  ];

  final List<Map<String, dynamic>> _categoriesData = [
    {'name': 'Burger', 'imagePath': 'assets/images/categories/burger.png'}, {'name': 'Taco', 'imagePath': 'assets/images/categories/taco.png'}, {'name': 'Burrito', 'imagePath': 'assets/images/categories/burrito.png'}, {'name': 'Drink', 'imagePath': 'assets/images/categories/drink.png'}, {'name': 'Pizza', 'imagePath': 'assets/images/categories/pizza.png'}, {'name': 'Donut', 'imagePath': 'assets/images/categories/donut.png'}, {'name': 'Salad', 'imagePath': 'assets/images/categories/salad.png'}, {'name': 'Noodles', 'imagePath': 'assets/images/categories/noodles.png'}, {'name': 'Sandwich', 'imagePath': 'assets/images/categories/sandwich.png'}, {'name': 'Pasta', 'imagePath': 'assets/images/categories/pasta.png'}, {'name': 'Ice Cream', 'imagePath': 'assets/images/categories/ice cream.png'}, {'name': 'More', 'imagePath': 'assets/images/categories/more.png'},
  ];

  final List<Map<String, String>> _specialOffersData = [
    {'image': 'assets/images/offers/offer8.png', 'name': 'Chicken Burger', 'price': '£6.00', 'oldPrice': '£10.00', 'rating': '4.9', 'isLiked': 'false'},
    {'image': 'assets/images/offers/offer2.png', 'name': 'Beef Burger', 'price': '£10.00', 'oldPrice': '£12.00', 'rating': '4.9', 'isLiked': 'true'},
    {'image': 'assets/images/offers/offer3.png', 'name': 'Ramen Noodles', 'price': '£15.00', 'oldPrice': '£22.00', 'rating': '4.9', 'isLiked': 'false'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    setState(() { _currentBottomNavIndex = index;});
  }

  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {

    double statusBarHeight = MediaQuery.of(context).padding.top;
    double desiredTopSpaceFromSafeArea = AppResponsive.height(54) - statusBarHeight;
    double topPaddingForContent = desiredTopSpaceFromSafeArea > 0 ? desiredTopSpaceFromSafeArea : AppResponsive.height(10);


    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(height: topPaddingForContent),
            ),
            SliverToBoxAdapter(child: _buildTopBar(context)),
            SliverToBoxAdapter(child: _buildPromoBanners(context)),
            SliverToBoxAdapter(child: SizedBox(height: AppResponsive.height(24))),
            SliverToBoxAdapter(child: _buildSearchBar(context)),
            SliverToBoxAdapter(child: SizedBox(height: AppResponsive.height(24))),
            SliverToBoxAdapter(child: _buildCategoryGrid(context)),
            SliverToBoxAdapter(child: SizedBox(height: AppResponsive.height(24))),
            SliverToBoxAdapter(child: _buildSpecialOffersSection(context)),
            SliverToBoxAdapter(child: SizedBox(height: AppResponsive.height(24))),
            SliverFillRemaining( hasScrollBody: false, child: const SizedBox(),),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar( currentIndex: _currentBottomNavIndex, onTap: _onBottomNavTapped, type: BottomNavigationBarType.fixed, backgroundColor: AppColors.white, selectedItemColor: AppColors.primary500, unselectedItemColor: AppColors.neutral500, selectedLabelStyle: _textStyles.medium(color: AppColors.primary500, fontSize: 12), unselectedLabelStyle: _textStyles.regular(color: AppColors.neutral500, fontSize: 12), items: [ BottomNavigationBarItem( icon: const Icon(Icons.home_outlined), activeIcon: const Icon(Icons.home), label: AppStrings.home,), BottomNavigationBarItem( icon: const Icon(Icons.list_alt_outlined), activeIcon: const Icon(Icons.list_alt), label: AppStrings.orders,), BottomNavigationBarItem( icon: const Icon(Icons.favorite_border_outlined), activeIcon: const Icon(Icons.favorite), label: AppStrings.liked,), BottomNavigationBarItem( icon: const Icon(Icons.notifications_none_outlined), activeIcon: const Icon(Icons.notifications), label: AppStrings.notify,), BottomNavigationBarItem( icon: const Icon(Icons.person_outline), activeIcon: const Icon(Icons.person), label: AppStrings.profile,),],),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)),
      child: SizedBox(
        height: AppResponsive.height(51),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppStrings.deliverTo, style: _textStyles.regular(color: AppColors.neutral600, fontSize: 14)),
                SizedBox(height: AppResponsive.height(4)),
                InkWell(
                  onTap: () { print("Select location tapped"); },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(AppStrings.selectYourLocation, style: _textStyles.semiBold(color: AppColors.primary500, fontSize: 16)),
                      SizedBox(width: AppResponsive.width(4)),
                      Icon(Icons.keyboard_arrow_down, color: AppColors.primary500, size: AppResponsive.height(20)),
                    ],
                  ),
                )
              ],
            ),
            IconButton(
              icon: Icon(Icons.shopping_bag_outlined, color: AppColors.neutral800, size: AppResponsive.height(28)),
              onPressed: () { print("Cart icon tapped"); },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanners(BuildContext context) {
    double cardWidth = AppResponsive.width(320); double cardHeight = AppResponsive.height(163);
    return Container( height: cardHeight, margin: EdgeInsets.symmetric(vertical: AppResponsive.height(10)), child: ListView.builder( scrollDirection: Axis.horizontal, itemCount: _promoBannersData.length, padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16)), itemBuilder: (context, index) { final banner = _promoBannersData[index]; final Color line1Color = banner['line1Color'] as Color? ?? AppColors.neutral700; final Color line2Color = banner['line2Color'] as Color? ?? AppColors.primary500; final Color line3Color = banner['line3Color'] as Color? ?? AppColors.neutral800; final Color bgColor = banner['bgColor'] != null ? _hexToColor(banner['bgColor'] as String) : AppColors.neutral100; return Container( width: cardWidth, margin: EdgeInsets.symmetric(horizontal: AppResponsive.width(8)), decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(AppResponsive.height(16)), image: DecorationImage(image: AssetImage(banner['image'] as String), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.15), BlendMode.darken))), child: Padding( padding: EdgeInsets.all(AppResponsive.width(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [ Text(banner['line1'] as String, style: _textStyles.regular(color: line1Color, fontSize: 12)), SizedBox(height: AppResponsive.height(6)), Text(banner['line2'] as String, style: _textStyles.bold(color: line2Color, fontSize: 20).copyWith(letterSpacing: -0.5, height: 1.2), maxLines: 2, overflow: TextOverflow.ellipsis), SizedBox(height: AppResponsive.height(4)), Text(banner['line3'] as String, style: _textStyles.semiBold(color: line3Color, fontSize: 16))])));}));
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding( padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)), child: GestureDetector( onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen())); }, child: AbsorbPointer( child: Container( width: AppResponsive.width(345), height: AppResponsive.height(56), decoration: BoxDecoration(color: AppColors.neutral100.withOpacity(0.8), borderRadius: BorderRadius.circular(AppResponsive.height(12))), padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16.0)), child: Row(children: [ Icon(Icons.search, color: AppColors.neutral500, size: AppResponsive.height(22)), SizedBox(width: AppResponsive.width(12)), Expanded( child: TextField( controller: _searchController, enabled: false, style: _textStyles.regular(color: AppColors.neutral800, fontSize: 14), decoration: InputDecoration(hintText: AppStrings.search, hintStyle: _textStyles.regular(color: AppColors.neutral400, fontSize: 14), border: InputBorder.none, focusedBorder: InputBorder.none, enabledBorder: InputBorder.none, errorBorder: InputBorder.none, disabledBorder: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(0))),),), SizedBox(width: AppResponsive.width(12)), InkWell(onTap: () {}, child: Icon(Icons.tune_outlined, color: AppColors.primary500, size: AppResponsive.height(22))),])))));
  }

  Widget _buildCategoryGrid(BuildContext context) {
    const int crossAxisCount = 4; final double itemSpacing = AppResponsive.width(24.0); final double containerWidth = AppResponsive.width(345); final double itemWidth = (containerWidth - (itemSpacing * (crossAxisCount -1))) / crossAxisCount;
    return Padding( padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)), child: GridView.builder( shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: _categoriesData.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: crossAxisCount, crossAxisSpacing: itemSpacing, mainAxisSpacing: itemSpacing, childAspectRatio: itemWidth / (AppResponsive.height(56 + 8 + 15 + 5)),), itemBuilder: (context, index) { final category = _categoriesData[index]; return InkWell( onTap: () { print("Category tapped: ${category['name']}"); }, borderRadius: BorderRadius.circular(AppResponsive.height(8)), child: Column( mainAxisAlignment: MainAxisAlignment.center, children: [ Container( width: AppResponsive.width(56), height: AppResponsive.height(56), padding: EdgeInsets.all(AppResponsive.width(12)), decoration: BoxDecoration( color: AppColors.primary100.withOpacity(0.6), shape: BoxShape.circle,), child: Image.asset( category['imagePath'] as String, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) { return Icon(Icons.fastfood, color: AppColors.primary500, size: AppResponsive.height(24));},),), SizedBox(height: AppResponsive.height(8)), Text( category['name'] as String, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: _textStyles.regular(color: AppColors.neutral700, fontSize: 12),)]));}));
  }

  Widget _buildSpecialOffersSection(BuildContext context) {
    const int previewItemCount = 3; final List<Map<String, String>> previewOffers = _specialOffersData.take(previewItemCount).toList();
    return Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Padding( padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)), child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ Text( AppStrings.specialOffers, style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18)), TextButton( onPressed: () { Navigator.push( context, MaterialPageRoute(builder: (context) => const SpecialOffersPage()),);}, style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50,30)), child: Row( mainAxisSize: MainAxisSize.min, children: [ Text( AppStrings.viewAll, style: _textStyles.medium(color: AppColors.primary500, fontSize: 14),), SizedBox(width: AppResponsive.width(4)), Icon(Icons.arrow_forward_ios, color: AppColors.primary500, size: AppResponsive.height(14)),]))])), SizedBox(height: AppResponsive.height(16)), Container(height: AppResponsive.height(190), child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: previewOffers.length, padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16)), itemBuilder: (context, index) { final offer = previewOffers[index]; bool isLiked = (offer['isLiked']?.toLowerCase() == 'true'); return _buildSpecialOfferItemCard( imagePath: offer['image']!, name: offer['name']!, price: offer['price']!, oldPrice: offer['oldPrice'], rating: offer['rating'], isLiked: isLiked, onLikePressed: () { setState(() { int originalIndex = _specialOffersData.indexWhere((o) => o['name'] == offer['name']); if(originalIndex != -1) { bool currentLikeState = (_specialOffersData[originalIndex]['isLiked']?.toLowerCase() == 'true'); _specialOffersData[originalIndex]['isLiked'] = (!currentLikeState).toString();}});}, onTap: () { print("Tapped on ${offer['name']} from HomeScreen preview"); });}))]);
  }

  Widget _buildSpecialOfferItemCard({ required String imagePath, required String name, required String price, String? oldPrice, String? rating, required bool isLiked, required VoidCallback onLikePressed, required VoidCallback onTap,}) {
    return InkWell( onTap: onTap, borderRadius: BorderRadius.circular(AppResponsive.height(12)), child: Container( width: AppResponsive.width(160.5), margin: EdgeInsets.symmetric(horizontal: AppResponsive.width(8)), child: Card( elevation: 1.5, clipBehavior: Clip.antiAlias, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12))), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Expanded( flex: 3, child: Stack( children: [ Container( decoration: BoxDecoration( image: DecorationImage( image: AssetImage(imagePath), fit: BoxFit.cover, onError: (e, s)=>print("Error loading image $imagePath: $e"),),),), Positioned( top: AppResponsive.height(6), right: AppResponsive.width(6), child: InkWell( onTap: onLikePressed, child: Container( padding: EdgeInsets.all(AppResponsive.width(4)), decoration: BoxDecoration(color: AppColors.black.withOpacity(0.3), shape: BoxShape.circle,), child: Icon( isLiked ? Icons.favorite : Icons.favorite_border, color: isLiked ? AppColors.primary500 : AppColors.white, size: AppResponsive.height(18),),),),), ],),), Padding( padding: EdgeInsets.all(AppResponsive.width(10)), child: Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [ Text( name, style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis,), SizedBox(height: AppResponsive.height(4)), if (rating != null) Row(children: [ Icon(Icons.star, color: Colors.amber, size: AppResponsive.height(14)), SizedBox(width: AppResponsive.width(4)), Text( rating, style: _textStyles.regular(color: AppColors.neutral700, fontSize: 12))]), SizedBox(height: AppResponsive.height(6)), Row(children: [ Text( price, style: _textStyles.semiBold(color: AppColors.primary500, fontSize: 14)), SizedBox(width: AppResponsive.width(8)), if (oldPrice != null && oldPrice.isNotEmpty) Text( oldPrice, style: _textStyles.regular( color: AppColors.neutral400, fontSize: 12, decoration: TextDecoration.lineThrough),),]), ],),)]))));
  }
}