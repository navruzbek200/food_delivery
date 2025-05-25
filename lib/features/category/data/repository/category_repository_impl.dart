import 'package:food_delivery/features/category/data/data_source/category_remote_data_source.dart';
import 'package:food_delivery/features/category/domain/entities/categories_entity.dart';
import 'package:food_delivery/features/category/domain/entities/category_foods_entity.dart';
import 'package:food_delivery/features/category/domain/entities/single_category_entity.dart';
import 'package:food_delivery/features/category/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl({required this.categoryRemoteDataSource});

  @override
  Future<List<CategoriesEntity>> getCategories() {
    return categoryRemoteDataSource.getCategories();
  }

  @override
  Future<SingleCategoryEntity> getSingleCategory({required int id}) {
    return categoryRemoteDataSource.getSingleCategory(id: id);
  }

  @override
  Future<List<CategoryFoodsEntity>> getFoodCategory({required int id}) {
    return categoryRemoteDataSource.getFoodsCategory(id: id);
  }

}