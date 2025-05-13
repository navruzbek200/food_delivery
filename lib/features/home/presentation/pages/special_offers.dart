import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/features/home/presentation/widgets/special_offers_widgets.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';
import '../widgets/home_widgets/offer_card_widget.dart';

class SpecialOffersPage extends StatefulWidget {
  const SpecialOffersPage({Key? key}) : super(key: key);

  @override
  State<SpecialOffersPage> createState() => _SpecialOffersPageState();
}

class _SpecialOffersPageState extends State<SpecialOffersPage> {
  final _textStyles = RobotoTextStyles();
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _allSpecialOffers = [
    {
      'image': 'assets/images/offers/offer1.png',
      'name': 'Chicken Burger',
      'price': '£6.00',
      'oldPrice': '£10.00',
      'rating': '4.9',
      'isLiked': 'false',
    },
    {
      'image': 'assets/images/offers/offer2.png',
      'name': 'Beef Burger',
      'price': '£10.00',
      'oldPrice': '£12.00',
      'rating': '4.9',
      'isLiked': 'true',
    },
    {
      'image': 'assets/images/offers/offer3.png',
      'name': 'Ramen Noodles',
      'price': '£15.00',
      'oldPrice': '£22.00',
      'rating': '4.9',
      'isLiked': 'false',
    },
    {
      'image': 'assets/images/offers/offer4.png',
      'name': 'Pho Noodles',
      'price': '£20.00',
      'oldPrice': '£24.00',
      'rating': '4.9',
      'isLiked': 'false',
    },
    {
      'image': 'assets/images/offers/offer5.png',
      'name': 'Fresh Fruit Donuts',
      'price': '£5.00',
      'oldPrice': '£6.00',
      'rating': '4.9',
      'isLiked': 'true',
    },
    {
      'image': 'assets/images/offers/offer6.png',
      'name': 'Rotini Pasta',
      'price': '£18.00',
      'oldPrice': '£20.00',
      'rating': '4.9',
      'isLiked': 'false',
    },
    {
      'image': 'assets/images/offers/offer7.png',
      'name': 'Spicy Chicken Burger',
      'price': '£6.50',
      'oldPrice': '£10.50',
      'rating': '4.8',
      'isLiked': 'false',
    },
    {
      'image': 'assets/images/offers/offer8.png',
      'name': 'Double Beef Burger',
      'price': '£11.00',
      'oldPrice': '£13.00',
      'rating': '4.7',
      'isLiked': 'false',
    },
  ];

  List<Map<String, String>> _filteredOffers = [];

  @override
  void initState() {
    super.initState();
    _filteredOffers = List.from(_allSpecialOffers);
    _searchController.addListener(() {});
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
        _filteredOffers = List.from(_allSpecialOffers);
      } else {
        _filteredOffers =
            _allSpecialOffers.where((offer) {
              return offer['name']!.toLowerCase().contains(lowerCaseQuery);
            }).toList();
      }
    });
  }

  void _clearSearchInPage() {
    _searchController.clear();
    _filterOffers('');
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
        title: Text(
          AppStrings.specialOffers,
          style: _textStyles.semiBold(
            color: AppColors.neutral900,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24)),
            // Use the extracted widget
            child: SpecialOffersSearchBarWidget(
              controller: _searchController,
              onChanged: _filterOffers,
              onClear: _clearSearchInPage,
              onFilterTapped: () {
                print("Filter special offers tapped from Page");
              },
            ),
          ),
          Expanded(
            child:
                _filteredOffers.isEmpty && _searchController.text.isNotEmpty
                    ? const SpecialOffersNotFoundWidget() // Use extracted widget
                    : GridView.builder(
                      padding: EdgeInsets.all(
                        AppResponsive.width(24.0),
                      ).copyWith(top: AppResponsive.height(8)),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppResponsive.width(16),
                        mainAxisSpacing: AppResponsive.height(16),
                        childAspectRatio: 0.65,
                      ),
                      itemCount: _filteredOffers.length,
                      itemBuilder: (context, index) {
                        final offer = _filteredOffers[index];
                        bool isLiked =
                            (offer['isLiked']?.toLowerCase() == 'true');

                        int originalIndex = _allSpecialOffers.indexWhere(
                          (o) =>
                              o['name'] == offer['name'] &&
                              o['price'] == offer['price'],
                        );

                        return OfferCardWidget(
                          imagePath: offer['image']!,
                          name: offer['name']!,
                          price: offer['price']!,
                          oldPrice: offer['oldPrice'],
                          rating: offer['rating'],
                          isLiked: isLiked,
                          onLikePressed: () {
                            if (mounted && originalIndex != -1) {
                              setState(() {
                                bool currentLikeState =
                                    (_allSpecialOffers[originalIndex]['isLiked']
                                            ?.toLowerCase() ==
                                        'true');
                                _allSpecialOffers[originalIndex]['isLiked'] =
                                    (!currentLikeState).toString();
                                if (_searchController.text.isNotEmpty) {
                                  _filterOffers(_searchController.text);
                                } else {
                                  _filteredOffers = List.from(
                                    _allSpecialOffers,
                                  );
                                }
                              });
                            }
                          },
                          onTap: () {
                            print(
                              "Tapped ${offer['name']} from SpecialOffersPage",
                            );
                          },
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
