import 'package:dio/dio.dart';
import 'package:food_delivery/core/common/constants/api_url.dart';
import 'package:food_delivery/core/network/dio_client.dart';
import 'package:food_delivery/features/category/data/models/categories_model.dart';
import 'package:food_delivery/features/category/data/models/category_foods_model.dart';
import 'package:food_delivery/features/category/data/models/single_category_model.dart';
import 'package:food_delivery/features/category/domain/entities/category_foods_entity.dart';
import 'package:food_delivery/features/category/domain/entities/single_category_entity.dart';
import 'package:logger/logger.dart';
import '../../domain/entities/categories_entity.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoriesEntity>> getCategories({required String token});

  Future<SingleCategoryEntity> getSingleCategory({
    required int id,
    required String token,
  });

  Future<List<CategoryFoodsEntity>> getFoodsCategory({
    required int id,
    required String token,
  });
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final DioClient dioClient;
  var logger = Logger();

  CategoryRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<CategoriesEntity>> getCategories({required String token}) async {
    final response = await dioClient.get(
      ApiUrls.categories,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i("GET CATEGORIES | response: $response");
      return categoriesFromJson(response.data);
    } else {
      throw Exception("ERROR");
    }
  }

  @override
  Future<SingleCategoryEntity> getSingleCategory({
    required int id,
    required String token,
  }) async {
    final response = await dioClient.get(
      "${ApiUrls.categoriesId}$id",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i("GET SINGLE CATEGORIES | response: $response");
      return SingleCategoryModel.fromJson(response.data);
    } else {
      throw Exception("ERROR");
    }
  }

  @override
  Future<List<CategoryFoodsEntity>> getFoodsCategory({
    required int id,
    required String token,
  }) async {
    final response = await dioClient.get(
      "${ApiUrls.categoriesIdFoods}$id/foods",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i("GET FOOD CATEGORIES | response: $response");
      final data = response.data;
      if (data == null || (data is List && data.isEmpty)) {
        return [];
      }
      return getfoodcategoriesFromJson(response.data);
    } else {
      throw Exception("ERROR");
    }
  }
}
