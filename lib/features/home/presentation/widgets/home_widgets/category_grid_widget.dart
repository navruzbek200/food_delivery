import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';
import '../../pages/categories.dart';

class CategoryGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> categoriesData;

  const CategoryGridWidget({
    Key? key,
    required this.categoriesData,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    const int crossAxisCount = 4;
    final double itemSpacing = AppResponsive.width(24.0);

    final double availableWidthForGrid = AppResponsive.width(345);
    final double itemWidth = (availableWidthForGrid - (itemSpacing * (crossAxisCount - 1))) / crossAxisCount;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categoriesData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: itemSpacing,
          mainAxisSpacing: itemSpacing,
          childAspectRatio: itemWidth / AppResponsive.height(84),
        ),
        itemBuilder: (context, index) {
          final category = categoriesData[index];
          bool isMoreButton = (category['name'] as String) == AppStrings.more;

          return InkWell(
            onTap: () {
              if (isMoreButton) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoriesScreen()),
                );
                print("More Categories tapped from CategoryGridWidget, navigating...");
              } else {
                print("Category tapped: ${category['name']}");
              }
            },
            borderRadius: BorderRadius.circular(AppResponsive.height(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: AppResponsive.width(56),
                  height: AppResponsive.height(56),
                  padding: EdgeInsets.all(AppResponsive.width(12)),
                  decoration: BoxDecoration(
                    color: AppColors.primary100.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    category['imagePath'] as String,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.fastfood, color: AppColors.primary500, size: AppResponsive.height(24));
                    },
                  ),
                ),
                SizedBox(height: AppResponsive.height(8)),
                Text(
                  category['name'] as String,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _textStyles.regular(color: AppColors.neutral700, fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}