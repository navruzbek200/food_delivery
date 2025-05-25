import 'package:food_delivery/features/category/domain/entities/single_category_entity.dart';

class SingleCategoryModel extends SingleCategoryEntity{
  SingleCategoryModel({required super.id, required super.name});

  factory SingleCategoryModel.fromJson(Map<String, dynamic> json){
    return SingleCategoryModel(
      id: json["id"],
      name: json["name"],
    );
  }
}