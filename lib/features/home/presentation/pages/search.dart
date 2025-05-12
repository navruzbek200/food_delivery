import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';

import '../../../../core/common/text_styles/name_textstyles.dart'; // Verify import path

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _textStyles = RobotoTextStyles();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  List<String> _recentSearches = [
    "Burger",
    "Taco",
    "Pizza",
    "Noodles",
    "Salad",
  ];
  List<Map<String, String>> _searchResults = [];
  bool _isLoading = false;
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
    _searchController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (!mounted) return;
    final trimmedQuery = query.trim();

    FocusScope.of(context).unfocus();

    if (trimmedQuery.isEmpty) {
      setState(() {
        _searchResults = [];
        _hasSearched = false;
        _isLoading = false;
      });
      return;
    }

    if (!_recentSearches.contains(trimmedQuery)) {
      _recentSearches.insert(0, trimmedQuery);
      if (_recentSearches.length > 5) {
        _recentSearches.removeLast();
      }
    }

    setState(() {
      _isLoading = true;
      _hasSearched = true;
      _searchResults = [];
    });

    print("Performing search for: $trimmedQuery");
    // Simulate API call
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      List<Map<String, String>> results = [];
      if (trimmedQuery.toLowerCase().contains("noodle")) {
        results = [
          {
            'name': 'Ramen Noodles',
            'imagePath': 'assets/images/offers/offer8.png',
            'rating': '4.9',
            'price': '£15.00',
            'oldPrice': '£22.00',
          },
          {
            'name': 'Pho Noodles',
            'imagePath': 'assets/images/offers/offer2.png',
            'rating': '4.9',
            'price': '£20.00',
            'oldPrice': '£24.00',
          },
        ];
      } else if (trimmedQuery.toLowerCase().contains("cake")) {
      } else if (trimmedQuery.toLowerCase().contains("burger")) {
        results = [
          {
            'name': 'Classic Burger',
            'imagePath': 'assets/images/offers/offer8.png',
            'rating': '4.5',
            'price': '£8.00',
            'oldPrice': '',
          },
        ];
      }
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _performSearch('');
    FocusScope.of(context).requestFocus(_searchFocusNode);
  }

  void _clearAllRecent() {
    if (mounted) {
      setState(() {
        _recentSearches = [];
      });
    }
  }

  void _removeRecentSearch(String searchTerm) {
    if (mounted) {
      setState(() {
        _recentSearches.remove(searchTerm);
      });
    }
  }

  Widget _buildSearchBarInternal() {
    return Container(
      width: AppResponsive.width(345),
      height: AppResponsive.height(56),
      decoration: BoxDecoration(
        color: AppColors.neutral100.withOpacity(0.8),
        borderRadius: BorderRadius.circular(AppResponsive.height(12)),
      ),
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            color: AppColors.neutral500,
            size: AppResponsive.height(22),
          ),
          SizedBox(width: AppResponsive.width(12)),
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              autofocus: false,
              style: _textStyles.regular(
                color: AppColors.neutral800,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: AppStrings.search,
                hintStyle: _textStyles.regular(
                  color: AppColors.neutral400,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: AppResponsive.height(15),
                ),
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: AppColors.neutral500,
                            size: AppResponsive.height(20),
                          ),
                          onPressed: _clearSearch,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        )
                        : null,
              ),
              onChanged: (value) {
                setState(() {});
              },
              onSubmitted: _performSearch,
              textInputAction: TextInputAction.search,
            ),
          ),
          SizedBox(width: AppResponsive.width(12)),
          InkWell(
            onTap: () {
              print("Filter tapped on SearchScreen");
            },
            child: Icon(
              Icons.tune_outlined,
              color: AppColors.primary500,
              size: AppResponsive.height(22),
            ),
          ),
        ],
      ),
    );
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
          AppStrings.search,
          style: _textStyles.semiBold(
            color: AppColors.neutral900,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)),
        child: Column(
          children: [
            SizedBox(height: AppResponsive.height(16)),
            _buildSearchBarInternal(),
            SizedBox(height: AppResponsive.height(24)),
            Expanded(
              child:
                  _isLoading
                      ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary500,
                        ),
                      )
                      : _hasSearched
                      ? _searchResults.isNotEmpty
                          ? _buildSearchResults()
                          : _buildNotFound()
                      : _recentSearches.isNotEmpty
                      ? _buildRecentSearches()
                      : _buildInitialEmptyState(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.recent,
              style: _textStyles.semiBold(
                color: AppColors.neutral900,
                fontSize: 18,
              ),
            ),
            if (_recentSearches.isNotEmpty)
              TextButton(
                onPressed: _clearAllRecent,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  AppStrings.clearAll,
                  style: _textStyles.medium(
                    color: AppColors.primary500,
                    fontSize: 14,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: AppResponsive.height(8)),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentSearches.length,
          itemBuilder: (context, index) {
            final searchTerm = _recentSearches[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                searchTerm,
                style: _textStyles.regular(
                  color: AppColors.neutral700,
                  fontSize: 16,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.neutral400,
                  size: AppResponsive.height(20),
                ),
                onPressed: () => _removeRecentSearch(searchTerm),
              ),
              onTap: () {
                _searchController.text = searchTerm;
                _searchController.selection = TextSelection.fromPosition(
                  TextPosition(offset: searchTerm.length),
                );
                _performSearch(searchTerm);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return GridView.builder(
      padding: EdgeInsets.only(
        top: AppResponsive.height(10),
        bottom: AppResponsive.height(16),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppResponsive.width(16),
        mainAxisSpacing: AppResponsive.height(16),
        childAspectRatio: 0.65, // Fine-tune this value
      ),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final item = _searchResults[index];
        return Card(
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppResponsive.height(12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  // This Container holds the DecorationImage
                  decoration: BoxDecoration(
                    // Removed borderRadius from here, Card's shape + clipBehavior handles it
                    image: DecorationImage(
                      image: AssetImage(item['imagePath']!),
                      // Ensure this key matches your data
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        print(
                          "Error loading image: ${item['imagePath']} - $exception",
                        );
                      },
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(AppResponsive.width(4)),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border, // TODO: State for liked items
                          color: AppColors.white.withOpacity(0.9),
                          size: AppResponsive.height(20),
                        ),
                        onPressed: () {
                          /* TODO: Handle like action */
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(AppResponsive.width(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item['name']!,
                      style: _textStyles.semiBold(
                        color: AppColors.neutral900,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppResponsive.height(4)),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: AppResponsive.height(14),
                        ),
                        SizedBox(width: AppResponsive.width(4)),
                        Text(
                          item['rating']!,
                          style: _textStyles.regular(
                            color: AppColors.neutral700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppResponsive.height(6)),
                    Row(
                      children: [
                        Text(
                          item['price']!,
                          style: _textStyles.semiBold(
                            color: AppColors.primary500,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: AppResponsive.width(8)),
                        if (item['oldPrice'] != null &&
                            item['oldPrice']!.isNotEmpty)
                          Text(
                            item['oldPrice']!,
                            style: _textStyles.regular(
                              color: AppColors.neutral400,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_outlined,
            size: AppResponsive.height(80),
            color: AppColors.neutral300,
          ),
          SizedBox(height: AppResponsive.height(16)),
          Text(
            AppStrings.notFound,
            style: _textStyles.semiBold(
              color: AppColors.neutral700,
              fontSize: 18,
            ),
          ),
          SizedBox(height: AppResponsive.height(8)),
          Text(
            AppStrings.trySearchingDifferentKeywords,
            textAlign: TextAlign.center,
            style: _textStyles.regular(
              color: AppColors.neutral500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialEmptyState() {
    return Center(
      child: Text(
        "Start searching for food, restaurants, etc.",
        // Using direct string literal
        style: _textStyles.regular(color: AppColors.neutral500, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
