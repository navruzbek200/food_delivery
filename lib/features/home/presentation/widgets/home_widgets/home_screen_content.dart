import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/home/presentation/widgets/home_widgets/top_bar_widget.dart';
import 'package:food_delivery/features/home/presentation/widgets/home_widgets/promo_banners_widget.dart';
import 'package:food_delivery/features/home/presentation/widgets/home_widgets/category_grid_widget.dart';
import 'package:food_delivery/features/home/presentation/widgets/home_widgets/special_offers_preview_widget.dart';
import 'package:food_delivery/features/home/presentation/widgets/home_widgets/search_bar_widget.dart';

class HomeScreenContent extends StatelessWidget {
  final List<Map<String, dynamic>> promoBannersData;
  final List<Map<String, dynamic>> categoriesData;
  final List<Map<String, String>> specialOffersData;
  final Function(int, bool) onLikeToggleInDataSource;

  const HomeScreenContent({
    Key? key,
    required this.promoBannersData,
    required this.categoriesData,
    required this.specialOffersData,
    required this.onLikeToggleInDataSource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: CustomScrollView(
        slivers: <Widget>[
          const SliverToBoxAdapter(child: TopBarWidget()),
          SliverToBoxAdapter(child: PromoBannersWidget(promoBannersData: promoBannersData)),
          SliverToBoxAdapter(child: SizedBox(height: AppResponsive.height(24))),
          const SliverToBoxAdapter(child: HomeSearchBarWidget()),
          SliverToBoxAdapter(child: SizedBox(height: AppResponsive.height(24))),
          SliverToBoxAdapter(child: CategoryGridWidget(categoriesData: categoriesData)),
          SliverToBoxAdapter(child: SizedBox(height: AppResponsive.height(24))),
          SliverToBoxAdapter(
            child: SpecialOffersPreviewWidget(
              offersData: specialOffersData,
              onLikeToggleInDataSource: onLikeToggleInDataSource,
              onItemTap: (Map<String, String> offerData) {
                print("Tapped on ${offerData['name']} from HomeScreenContent preview");
              },
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: AppResponsive.height(24))),
          SliverFillRemaining(hasScrollBody: false, child: const SizedBox(height: 1)),
        ],
      ),
    );
  }
}