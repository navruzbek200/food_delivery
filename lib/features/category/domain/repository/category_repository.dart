import 'package:food_delivery/features/category/domain/entities/categories_entity.dart';
import 'package:food_delivery/features/category/domain/entities/category_foods_entity.dart';
import '../entities/single_category_entity.dart';

abstract class CategoryRepository{
  Future<List<CategoriesEntity>> getCategories();
  Future<SingleCategoryEntity> getSingleCategory({required int id});
  Future<List<CategoryFoodsEntity>> getFoodCategory({required int id});
}

