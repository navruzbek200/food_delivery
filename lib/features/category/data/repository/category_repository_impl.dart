import 'package:food_delivery/features/category/data/data_source/category_remote_data_source.dart';
import 'package:food_delivery/features/category/domain/entities/categories_entity.dart';
import 'package:food_delivery/features/category/domain/entities/category_foods_entity.dart';
import 'package:food_delivery/features/category/domain/entities/single_category_entity.dart';
import 'package:food_delivery/features/category/domain/repository/category_repository.dart';

import '../../../../core/utils/token_storage.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl({required this.categoryRemoteDataSource});

  @override
  Future<List<CategoriesEntity>> getCategories() async{
    final token = await TokenStorage().getToken();
    if (token == null) {
      throw Exception('Token topilmadi');
    }
    return categoryRemoteDataSource.getCategories(token: token);
  }

  @override
  Future<SingleCategoryEntity> getSingleCategory({required int id}) async{
    final token = await TokenStorage().getToken();
    if (token == null) {
      throw Exception('Token topilmadi');
    }
    return categoryRemoteDataSource.getSingleCategory(id: id, token: token);
  }

  @override
  Future<List<CategoryFoodsEntity>> getFoodCategory({required int id}) async{
    final token = await TokenStorage().getToken();
    if (token == null) {
      throw Exception('Token topilmadi');
    }
    return categoryRemoteDataSource.getFoodsCategory(id: id, token: token);
  }

}