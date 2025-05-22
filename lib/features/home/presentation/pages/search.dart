import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/features/home/presentation/widgets/search_screen_widgets.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

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
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      List<Map<String, String>> results = [];
      if (trimmedQuery.toLowerCase().contains("noodle")) {
        results = [
          {
            'name': 'Ramen Noodles',
            'imagePath': 'assets/images/offers/offer1.png',
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
            'imagePath': 'assets/images/offers/offer1.png',
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
            SearchBarInternalWidget(
              controller: _searchController,
              focusNode: _searchFocusNode,
              onSubmitted: _performSearch,
              onChanged: (value) {
                setState(() {});
              },
              onClear: _clearSearch,
              onFilterTapped: () {
                print("Filter tapped on SearchScreen (from widget)");
              },
            ),
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
                          ? SearchResultsGridWidget(
                            searchResults: _searchResults,
                            onLikeResultItem: (index, itemData) {
                              print("Like toggled for: ${itemData['name']}");
                              if (mounted) {
                                setState(() {
                                  bool currentLike =
                                      (_searchResults[index]['isLiked']
                                              ?.toLowerCase() ==
                                          'true');
                                  _searchResults[index]['isLiked'] =
                                      (!currentLike).toString();
                                });
                              }
                            },
                            onTapResultItem: (itemData) {
                              print(
                                "Tapped on search result: ${itemData['name']}",
                              );
                            },
                          )
                          : const NotFoundWidget()
                      : _recentSearches.isNotEmpty
                      ? RecentSearchesWidget(
                        recentSearches: _recentSearches,
                        onClearAll: _clearAllRecent,
                        onRemoveSearchTerm: _removeRecentSearch,
                        onTapSearchTerm: (term) {
                          _searchController.text = term;
                          _searchController
                              .selection = TextSelection.fromPosition(
                            TextPosition(offset: term.length),
                          );
                          _performSearch(term);
                        },
                      )
                      : const InitialEmptyStateWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
