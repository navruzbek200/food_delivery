import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import '../widgets/liked_item_card.dart';

class LikedScreen extends StatefulWidget {
  final List<Map<String, String>> allOffersDataRef;
  final VoidCallback? onAppBarBackPressed;

  const LikedScreen({
    Key? key,
    required this.allOffersDataRef,
    this.onAppBarBackPressed,
  }) : super(key: key);

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  final _textStyles = RobotoTextStyles();
  List<Map<String, String>> _displayedLikedItems = [];
  String _searchText = "";
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    _loadAndFilterLikedItems();
  }

  @override
  void didUpdateWidget(covariant LikedScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.allOffersDataRef != oldWidget.allOffersDataRef) {
      _loadAndFilterLikedItems(query: _searchText);
    }
  }

  void _loadAndFilterLikedItems({String query = ""}) {
    setState(() {
      _isLoading = true;
      _searchText = query.toLowerCase();


      // if (_searchText.isEmpty) {
      //   _displayedLikedItems = currentLikedItems;
      // } else {
      //   _displayedLikedItems =
      //       currentLikedItems
      //           .where(
      //             (item) =>
      //                 (item['name']?.toLowerCase() ?? "").contains(_searchText),
      //           )
      //           .toList();
      // }
    });
    Future.delayed(Duration(seconds: 2),(){
      List<Map<String, String>> currentLikedItems =
      widget.allOffersDataRef
          .where((offer) => (offer['isLiked']?.toLowerCase() == 'true'))
          .toList();


      List<Map<String, String>> filtered = [];
      if (_searchText.isEmpty) {
        filtered = currentLikedItems;
      } else {
        filtered = currentLikedItems
            .where(
              (item) =>
              (item['name']?.toLowerCase() ?? "").contains(_searchText),
        )
            .toList();
      }
      setState(() {
        _displayedLikedItems = filtered;
        _isLoading = false; // <<< Yakunda loading o‘chadi
      });
    });

  }

  void _handleUnlike(Map<String, String> itemData) {
    final itemId = itemData['id'];
    if (itemId == null) {
      print("Error: Item ID is null, cannot unlike.");
      return;
    }

    final indexInAllOffers = widget.allOffersDataRef.indexWhere(
      (item) => item['id'] == itemId,
    );
    if (indexInAllOffers != -1) {
      if (widget.allOffersDataRef[indexInAllOffers]['isLiked']?.toLowerCase() ==
          'true') {
        widget.allOffersDataRef[indexInAllOffers]['isLiked'] = 'false';
        print(
          "Item ID '$itemId' marked as unliked in source data (from LikedScreen).",
        );

        _loadAndFilterLikedItems(query: _searchText);
      }
    } else {
      print("Error: Item with ID '$itemId' not found in allOffersDataRef.");
    }
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
          onPressed:
              widget.onAppBarBackPressed ?? () => Navigator.maybePop(context),
        ),
        title: Text(
          AppStrings.liked,
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
            padding: EdgeInsets.all(AppResponsive.width(16.0)),
            child: TextField(
              onChanged: (query) => _loadAndFilterLikedItems(query: query),
              decoration: InputDecoration(
                hintText: AppStrings.search,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.neutral500,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.tune_outlined,
                    color: AppColors.primary500,
                  ),
                  onPressed: () {
                    print("Filter button in LikedScreen tapped");
                  },
                ),
                filled: true,
                fillColor: AppColors.neutral100.withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppResponsive.height(12)),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: AppResponsive.height(14),
                ),
              ),
            ),
          ),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_displayedLikedItems.isEmpty) {
      return Center(
        child: Text(
          _searchText.isNotEmpty ? AppStrings.notFound : AppStrings.empty,
          style: _textStyles.semiBold(
            color: AppColors.neutral500,
            fontSize: 20,
          ),
        ),
      );
    } else {
      return GridView.builder(
        padding: EdgeInsets.all(AppResponsive.width(16.0)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppResponsive.width(12),
          mainAxisSpacing: AppResponsive.height(12),
          childAspectRatio: 0.72,
        ),
        itemCount: _displayedLikedItems.length,
        itemBuilder: (context, index) {
          final itemData = _displayedLikedItems[index];
          return LikedItemCard(
            imagePath: itemData['image'] ?? 'assets/images/placeholder.png',
            name: itemData['name'] ?? 'Unknown Item',
            price: itemData['price'] ?? 'N/A',
            oldPrice: itemData['oldPrice'],
            rating: itemData['rating'],
            isLiked: true,
            onLikePressed: () {
              _handleUnlike(itemData);
            },
            onTap: () {
              print("Tapped on ${itemData['name']} from LikedScreen");
            },
          );
        },
      );
    }
  }
}
