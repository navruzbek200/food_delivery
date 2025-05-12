import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';

import '../../../../core/common/text_styles/name_textstyles.dart';

class SpecialOffersPage extends StatefulWidget {
  const SpecialOffersPage({Key? key}) : super(key: key);

  @override
  State<SpecialOffersPage> createState() => _SpecialOffersPageState();
}

class _SpecialOffersPageState extends State<SpecialOffersPage> {
  final _textStyles = RobotoTextStyles();
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _allSpecialOffers = [
    {'image': 'assets/images/offers/offer1.png', 'name': 'Chicken Burger', 'price': '£6.00', 'oldPrice': '£10.00', 'rating': '4.9', 'isLiked': 'false'},
    {'image': 'assets/images/offers/offer2.png', 'name': 'Beef Burger', 'price': '£10.00', 'oldPrice': '£12.00', 'rating': '4.9', 'isLiked': 'true'},
    {'image': 'assets/images/offers/offer3.png', 'name': 'Ramen Noodles', 'price': '£15.00', 'oldPrice': '£22.00', 'rating': '4.9', 'isLiked': 'false'},
    {'image': 'assets/images/offers/offer4.png', 'name': 'Pho Noodles', 'price': '£20.00', 'oldPrice': '£24.00', 'rating': '4.9', 'isLiked': 'false'},
    {'image': 'assets/images/offers/offer5.png', 'name': 'Fresh Fruit Donuts', 'price': '£5.00', 'oldPrice': '£6.00', 'rating': '4.9', 'isLiked': 'true'},
    {'image': 'assets/images/offers/offer6.png', 'name': 'Rotini Pasta', 'price': '£18.00', 'oldPrice': '£20.00', 'rating': '4.9', 'isLiked': 'false'},
    {'image': 'assets/images/offers/offer7.png', 'name': 'Spicy Chicken Burger', 'price': '£6.50', 'oldPrice': '£10.50', 'rating': '4.8', 'isLiked': 'false'},
    {'image': 'assets/images/offers/offer8.png', 'name': 'Double Beef Burger', 'price': '£11.00', 'oldPrice': '£13.00', 'rating': '4.7', 'isLiked': 'false'},
  ];

  List<Map<String, String>> _filteredOffers = [];

  @override
  void initState() {
    super.initState();
    _filteredOffers = _allSpecialOffers;
    _searchController.addListener(() {
      _filterOffers(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterOffers(String query) {
    if (!mounted) return;
    final lowerCaseQuery = query.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredOffers = _allSpecialOffers;
      } else {
        _filteredOffers = _allSpecialOffers.where((offer) {
          return offer['name']!.toLowerCase().contains(lowerCaseQuery);
        }).toList();
      }
    });
  }

  Widget _buildSearchBarInternal() {
    return Container(
      width: AppResponsive.width(345), height: AppResponsive.height(56),
      margin: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
      decoration: BoxDecoration( color: AppColors.neutral100.withOpacity(0.8), borderRadius: BorderRadius.circular(AppResponsive.height(12)),),
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16.0)),
      child: Row(children: [ Icon(Icons.search, color: AppColors.neutral500, size: AppResponsive.height(22)), SizedBox(width: AppResponsive.width(12)), Expanded( child: TextField( controller: _searchController, style: _textStyles.regular(color: AppColors.neutral800, fontSize: 14), decoration: InputDecoration( hintText: "${AppStrings.search} ${AppStrings.specialOffers.toLowerCase()}", hintStyle: _textStyles.regular(color: AppColors.neutral400, fontSize: 14), border: InputBorder.none, focusedBorder: InputBorder.none, enabledBorder: InputBorder.none, errorBorder: InputBorder.none, disabledBorder: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(2)), suffixIcon: _searchController.text.isNotEmpty ? IconButton( icon: Icon(Icons.clear, color: AppColors.neutral500, size: AppResponsive.height(20)), onPressed: () { _searchController.clear(); _filterOffers(''); }, padding: EdgeInsets.zero, constraints: const BoxConstraints(),) : null,), onChanged: _filterOffers,),), SizedBox(width: AppResponsive.width(12)), InkWell( onTap: () { print("Filter special offers tapped"); }, child: Icon(Icons.tune_outlined, color: AppColors.primary500, size: AppResponsive.height(22)),), ],),);
  }

  Widget _buildNotFound() {
    return Center( child: Column( mainAxisAlignment: MainAxisAlignment.center, children: [ Icon(Icons.sentiment_dissatisfied_outlined, size: AppResponsive.height(80), color: AppColors.neutral300), SizedBox(height: AppResponsive.height(16)), Text( AppStrings.notFound, style: _textStyles.semiBold(color: AppColors.neutral700, fontSize: 18),), SizedBox(height: AppResponsive.height(8)), Text( AppStrings.tryDifferentKeywordsOrFilters, textAlign: TextAlign.center, style: _textStyles.regular(color: AppColors.neutral500, fontSize: 14),),],),);
  }

  Widget _buildSpecialOfferItemCard({ required String imagePath, required String name, required String price, String? oldPrice, String? rating, required bool isLiked, required VoidCallback onLikePressed, required VoidCallback onTap,}) {
    return InkWell( onTap: onTap, borderRadius: BorderRadius.circular(AppResponsive.height(12)), child: Card( elevation: 1.5, clipBehavior: Clip.antiAlias, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12))), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Expanded( flex: 3, child: Stack( children: [ Container( decoration: BoxDecoration( image: DecorationImage( image: AssetImage(imagePath), fit: BoxFit.cover, onError: (e, s)=>print("Error loading image $imagePath: $e"),),),), Positioned( top: AppResponsive.height(6), right: AppResponsive.width(6), child: InkWell( onTap: onLikePressed, child: Container( padding: EdgeInsets.all(AppResponsive.width(4)), decoration: BoxDecoration(color: AppColors.black.withOpacity(0.3), shape: BoxShape.circle,), child: Icon( isLiked ? Icons.favorite : Icons.favorite_border, color: isLiked ? AppColors.primary500 : AppColors.white, size: AppResponsive.height(18),),),),), ],),), Padding( padding: EdgeInsets.all(AppResponsive.width(10)), child: Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [ Text( name, style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis,), SizedBox(height: AppResponsive.height(4)), if (rating != null) Row(children: [ Icon(Icons.star, color: Colors.amber, size: AppResponsive.height(14)), SizedBox(width: AppResponsive.width(4)), Text( rating, style: _textStyles.regular(color: AppColors.neutral700, fontSize: 12))]), SizedBox(height: AppResponsive.height(6)), Row(children: [ Text( price, style: _textStyles.semiBold(color: AppColors.primary500, fontSize: 14)), SizedBox(width: AppResponsive.width(8)), if (oldPrice != null && oldPrice.isNotEmpty) Text( oldPrice, style: _textStyles.regular( color: AppColors.neutral400, fontSize: 12, decoration: TextDecoration.lineThrough),),]), ],),)])));
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text( AppStrings.specialOffers, style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding( padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24)), child: _buildSearchBarInternal(),),
          Expanded(
            child: _filteredOffers.isEmpty && _searchController.text.isNotEmpty // Show not found only if searched and no results
                ? _buildNotFound()
                : GridView.builder(
              padding: EdgeInsets.all(AppResponsive.width(24.0)).copyWith(top: AppResponsive.height(8)),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppResponsive.width(16),
                mainAxisSpacing: AppResponsive.height(16),
                childAspectRatio: 0.65,
              ),
              itemCount: _filteredOffers.isEmpty && _searchController.text.isEmpty ? _allSpecialOffers.length : _filteredOffers.length, // Show all if search is empty
              itemBuilder: (context, index) {
                final offer = _filteredOffers.isEmpty && _searchController.text.isEmpty ? _allSpecialOffers[index] : _filteredOffers[index];
                bool isLiked = (offer['isLiked']?.toLowerCase() == 'true');
                return _buildSpecialOfferItemCard(
                    imagePath: offer['image']!, name: offer['name']!, price: offer['price']!,
                    oldPrice: offer['oldPrice'], rating: offer['rating'], isLiked: isLiked,
                    onLikePressed: () { setState(() {
                      final listToUpdate = _filteredOffers.isEmpty && _searchController.text.isEmpty ? _allSpecialOffers : _filteredOffers;
                      bool currentLikeState = (listToUpdate[index]['isLiked']?.toLowerCase() == 'true');
                      listToUpdate[index]['isLiked'] = (!currentLikeState).toString();
                    });},
                    onTap: () { print("Tapped ${offer['name']}"); }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}