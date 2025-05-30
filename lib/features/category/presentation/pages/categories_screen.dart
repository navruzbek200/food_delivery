import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/category/presentation/bloc/categories/categories_bloc.dart';
import 'package:food_delivery/features/category/presentation/bloc/category_event.dart';
import 'package:food_delivery/features/category/presentation/bloc/singleCategory/single_category_bloc.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';
import 'category_items_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key, required List allCategoriesData}) : super(key: key);

  static final List<Map<String, String>> _allActualCategoriesData = [
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
    {'name': "Ice Cream", 'imagePath': 'assets/images/categories/ice cream.png'},
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
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CategoriesBloc>().add(CategoriesEvent());
  }
  @override
  Widget build(BuildContext context) {
    final categoriesToShow = CategoriesScreen._allActualCategoriesData;

    print("CategoriesScreen: Number of categories to show: ${categoriesToShow.length}");
    if (categoriesToShow.isEmpty) {
      print("CategoriesScreen: _allActualCategoriesData is empty or filtered to empty!");
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        shadowColor: AppColors.neutral100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppStrings.categories,
          style: CategoriesScreen._textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: categoriesToShow.isEmpty
          ? Center(
        child: Text(
          "No categories available at the moment.",
          style: CategoriesScreen._textStyles.regular(color: AppColors.neutral500, fontSize: 16),
        ),
      )
          : GridView.builder(
        padding: EdgeInsets.all(AppResponsive.width(24)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: AppResponsive.width(16),
          mainAxisSpacing: AppResponsive.height(20),
          childAspectRatio: 0.80,
        ),
        itemCount: categoriesToShow.length,
        itemBuilder: (context, index) {
          final category = categoriesToShow[index];
          final String categoryName = category['name'] ?? "N/A";
          final String categoryIconPath = category['imagePath'] ?? "assets/images/placeholder.png";
          categoryIconPath.toLowerCase().endsWith('.svg');
          return GestureDetector(
            onTap: () {
              context.read<SingleCategoryBloc>().add(SingleCategoryEvent(id: index+1));
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
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: AppResponsive.width(64),
                  height: AppResponsive.height(64),
                  padding: EdgeInsets.all(AppResponsive.width(14)),
                  decoration: BoxDecoration(
                    color: AppColors.neutral50,
                    borderRadius: BorderRadius.circular(AppResponsive.height(16)),
                  ),
                  child: Image.asset(
                    categoryIconPath,
                    fit: BoxFit.contain,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      print("Error loading category icon: $categoryIconPath");
                      return const Icon(Icons.image_not_supported_outlined, color: AppColors.neutral300, size: 30);
                    },
                  ),
                ),
                SizedBox(height: AppResponsive.height(8)),
                Text(
                  categoryName,
                  style: CategoriesScreen._textStyles.medium(fontSize: 12, color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}