import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  static final List<Map<String, dynamic>> _allCategoriesData = [
    {'name': "Burger", 'imagePath': 'assets/images/categories/burger.png'},
    {'name': "Taco", 'imagePath': 'assets/images/categories/taco.png'},
    {'name': "Burrito", 'imagePath': 'assets/images/categories/burrito.png'},
    {'name': "Drink", 'imagePath': 'assets/images/categories/drink.png'},
    {'name': "Pizza", 'imagePath': 'assets/images/categories/pizza.png'},
    {'name': "Donut", 'imagePath': 'assets/images/categories/donut.png'},
    {'name': "Salad", 'imagePath': 'assets/images/categories/salad.png'},
    {'name': "Noodles", 'imagePath': 'assets/images/categories/noodles.png'},
    {'name': "Sandwich", 'imagePath': 'assets/images/categories/sandwich.png'},
    {'name': "Pasta", 'imagePath': 'assets/images/categories/pasta.png'},
    {
      'name': "Ice Cream",
      'imagePath': 'assets/images/categories/ice cream.png',
    },
    {'name': "Rice", 'imagePath': 'assets/images/categories/rice.png'},
    {'name': "Takoyaki", 'imagePath': 'assets/images/categories/takoyaki.png'},
    {'name': "Fruit", 'imagePath': 'assets/images/categories/fruits.png'},
    {'name': "Sausage", 'imagePath': 'assets/images/categories/sausage.png'},
    {'name': "Goi Cuon", 'imagePath': 'assets/images/categories/goi cuon.png'},
    {'name': "Cookie", 'imagePath': 'assets/images/categories/cookie.png'},
    {'name': "Pudding", 'imagePath': 'assets/images/categories/pudding.png'},
    {'name': "Banh Mi", 'imagePath': 'assets/images/categories/banh mi.png'},
    {'name': "Dumpling", 'imagePath': 'assets/images/categories/dumpling.png'},
  ];

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    const int crossAxisCount = 4;
    final double itemSpacing = AppResponsive.width(24.0);
    final double containerWidth = AppResponsive.width(345);
    final double itemWidth =
        (containerWidth - (itemSpacing * (crossAxisCount - 1))) /
        crossAxisCount;

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
          AppStrings.categories,
          style: _textStyles.semiBold(
            color: AppColors.neutral900,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.width(24.0),
          vertical: AppResponsive.height(20.0),
        ),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _allCategoriesData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: itemSpacing,
            mainAxisSpacing: itemSpacing,
            childAspectRatio:
                itemWidth / (AppResponsive.height(56 + 8 + 15 + 5)),
          ),
          itemBuilder: (context, index) {
            final category = _allCategoriesData[index];
            return InkWell(
              onTap: () {
                print(
                  "Category tapped from All Categories: ${category['name']}",
                );
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
                        return Icon(
                          Icons.fastfood,
                          color: AppColors.primary500,
                          size: AppResponsive.height(24),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: AppResponsive.height(8)),
                  Text(
                    category['name'] as String,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _textStyles.regular(
                      color: AppColors.neutral700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
