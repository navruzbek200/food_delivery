import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';
import 'home_widgets/offer_card_widget.dart';

class SearchBarInternalWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSubmitted;
  final Function(String) onChanged;
  final VoidCallback onClear;
  final VoidCallback onFilterTapped;

  const SearchBarInternalWidget({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
    required this.onChanged,
    required this.onClear,
    required this.onFilterTapped,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
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
          Icon(Icons.search, color: AppColors.neutral500, size: AppResponsive.height(22)),
          SizedBox(width: AppResponsive.width(12)),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: false,
              style: _textStyles.regular(color: AppColors.neutral800, fontSize: 14),
              decoration: InputDecoration(
                hintText: AppStrings.search,
                hintStyle: _textStyles.regular(color: AppColors.neutral400, fontSize: 14),
                border: InputBorder.none, focusedBorder: InputBorder.none, enabledBorder: InputBorder.none, errorBorder: InputBorder.none, disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(15)),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                  key: const ValueKey('clear_button'),
                  icon: Icon(Icons.clear, color: AppColors.neutral500, size: AppResponsive.height(20)),
                  onPressed: onClear,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                )
                    : null,
              ),
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              textInputAction: TextInputAction.search,
            ),
          ),
          SizedBox(width: AppResponsive.width(12)),
          InkWell(
            key: const ValueKey('filter_button'),
            onTap: onFilterTapped,
            child: Icon(Icons.tune_outlined, color: AppColors.primary500, size: AppResponsive.height(22)),
          ),
        ],
      ),
    );
  }
}

class RecentSearchesWidget extends StatelessWidget {
  final List<String> recentSearches;
  final VoidCallback onClearAll;
  final Function(String) onRemoveSearchTerm;
  final Function(String) onTapSearchTerm;

  const RecentSearchesWidget({
    Key? key,
    required this.recentSearches,
    required this.onClearAll,
    required this.onRemoveSearchTerm,
    required this.onTapSearchTerm,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.recent, style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18)),
            if (recentSearches.isNotEmpty)
              TextButton(
                onPressed: onClearAll,
                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 30), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                child: Text(AppStrings.clearAll, style: _textStyles.medium(color: AppColors.primary500, fontSize: 14)),
              ),
          ],
        ),
        SizedBox(height: AppResponsive.height(8)),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentSearches.length,
          itemBuilder: (context, index) {
            final searchTerm = recentSearches[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(searchTerm, style: _textStyles.regular(color: AppColors.neutral700, fontSize: 16)),
              trailing: IconButton(
                icon: Icon(Icons.close, color: AppColors.neutral400, size: AppResponsive.height(20)),
                onPressed: () => onRemoveSearchTerm(searchTerm),
              ),
              onTap: () => onTapSearchTerm(searchTerm),
            );
          },
        ),
      ],
    );
  }
}

class SearchResultsGridWidget extends StatelessWidget {
  final List<Map<String, String>> searchResults;
  final Function(int indexInFilteredList, Map<String, String> itemData) onLikeResultItem;
  final Function(Map<String, String> itemData) onTapResultItem;


  const SearchResultsGridWidget({
    Key? key,
    required this.searchResults,
    required this.onLikeResultItem,
    required this.onTapResultItem,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(top: AppResponsive.height(10), bottom: AppResponsive.height(16)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppResponsive.width(16),
        mainAxisSpacing: AppResponsive.height(16),
        childAspectRatio: 0.65,
      ),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final item = searchResults[index];
        bool isLiked = (item['isLiked']?.toLowerCase() == 'true');

        return OfferCardWidget(
          imagePath: item['imagePath']!,
          name: item['name']!,
          price: item['price']!,
          oldPrice: item['oldPrice'],
          rating: item['rating'],
          isLiked: isLiked,
          onLikePressed: () => onLikeResultItem(index, item),
          onTap: () => onTapResultItem(item),
        );
      },
    );
  }
}

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({Key? key}) : super(key: key);
  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_outlined, size: AppResponsive.height(80), color: AppColors.neutral300),
          SizedBox(height: AppResponsive.height(16)),
          Text(AppStrings.notFound, style: _textStyles.semiBold(color: AppColors.neutral700, fontSize: 18)),
          SizedBox(height: AppResponsive.height(8)),
          Text(AppStrings.trySearchingDifferentKeywords, textAlign: TextAlign.center, style: _textStyles.regular(color: AppColors.neutral500, fontSize: 14)),
        ],
      ),
    );
  }
}

class InitialEmptyStateWidget extends StatelessWidget {
  const InitialEmptyStateWidget({Key? key}) : super(key: key);
  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Start searching for food, restaurants, etc.",
        style: _textStyles.regular(color: AppColors.neutral500, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}