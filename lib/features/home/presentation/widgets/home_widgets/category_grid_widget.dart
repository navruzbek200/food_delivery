import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/category/presentation/pages/category_items_screen.dart';
import 'package:food_delivery/features/category/presentation/pages/categories_screen.dart';

import '../../../../../core/common/constants/colors/app_colors.dart';
import '../../../../../core/common/constants/strings/app_string.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';

class CategoryGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> categoriesToDisplayInHome;

  const CategoryGridWidget({
    Key? key,
    required this.categoriesToDisplayInHome, required List<Map<String, dynamic>> categoriesData,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24)),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categoriesToDisplayInHome.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: AppResponsive.width(16),
        mainAxisSpacing: AppResponsive.height(16),
        childAspectRatio: 0.80,
      ),
      itemBuilder: (context, index) {
        final category = categoriesToDisplayInHome[index];
        final String categoryName = category['name'] as String? ?? "N/A";
        final String categoryIconPath = category['imagePath'] as String? ?? "assets/images/placeholder.png";
        bool isSvg = categoryIconPath.toLowerCase().endsWith('.svg');
        bool isMoreButton = categoryName == AppStrings.more;

        return GestureDetector(
          onTap: () {
            if (isMoreButton) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoriesScreen(allCategoriesData: [],),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryItemsScreen(
                    category_id: index + 1,
                    categoryName: categoryName,
                    categoryIconPath: categoryIconPath,
                  ),
                ),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: AppResponsive.width(64),
                height: AppResponsive.height(64),
                padding: EdgeInsets.all(AppResponsive.width(isMoreButton ? 18 : 14)),
                decoration: BoxDecoration(
                  color: AppColors.neutral50,
                  borderRadius: BorderRadius.circular(AppResponsive.height(16)),
                ),
                child: isSvg
                    ? Image.asset(categoryIconPath)
                    : Image.asset(categoryIconPath),
              ),
              SizedBox(height: AppResponsive.height(8)),
              Text(
                categoryName,
                style: _textStyles.medium(fontSize: 12, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}