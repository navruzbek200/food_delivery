import 'package:dio/dio.dart';
import 'package:food_delivery/core/common/constants/api_url.dart';
import 'package:food_delivery/features/category/data/models/categories_model.dart';
import 'package:food_delivery/features/category/data/models/category_foods_model.dart';
import 'package:food_delivery/features/category/data/models/single_category_model.dart';
import 'package:food_delivery/features/category/domain/entities/category_foods_entity.dart';
import 'package:food_delivery/features/category/domain/entities/single_category_entity.dart';
import 'package:logger/logger.dart';
import '../../domain/entities/categories_entity.dart';

abstract class CategoryRemoteDataSource{
  Future<List<CategoriesEntity>> getCategories();
  Future<SingleCategoryEntity> getSingleCategory({required int id});
  Future<List<CategoryFoodsEntity>> getFoodsCategory({required int id});
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource{
  final Dio dio;
  var logger = Logger();

  CategoryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CategoriesEntity>> getCategories()async {
    final response = await dio.get(ApiUrl.categories);
    if(response.statusCode == 200 || response.statusCode == 201){
      logger.i("GET CATEGORIES | response: $response");
      return categoriesFromJson(response.data);
    } else{
      throw Exception("ERROR");
    }

  }

  @override
  Future<SingleCategoryEntity> getSingleCategory({required int id}) async {
    final response = await dio.get("${ApiUrl.categoriesId}$id");
    if(response.statusCode == 200 || response.statusCode == 201){
      logger.i("GET SINGLE CATEGORIES | response: $response");
      return SingleCategoryModel.fromJson(response.data);
    } else{
      throw Exception("ERROR");
    }
  }

  @override
  Future<List<CategoryFoodsEntity>> getFoodsCategory({required int id}) async {
    final response = await dio.get("${ApiUrl.categoriesIdFoods}$id/foods");
    if(response.statusCode == 200 || response.statusCode == 201){
      logger.i("GET FOOD CATEGORIES | response: $response");
      return getfoodcategoriesFromJson(response.data);
    } else{
      throw Exception("ERROR");
    }
  }
}








