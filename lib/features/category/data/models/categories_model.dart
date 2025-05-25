import 'package:food_delivery/features/category/domain/entities/categories_entity.dart';
List<CategoriesModel> categoriesFromJson(List str) =>
    List<CategoriesModel>.from(str.map((x) => CategoriesModel.fromJson(x)));
class CategoriesModel extends CategoriesEntity{
  CategoriesModel({required super.id, required super.name});

  factory CategoriesModel.fromJson(Map<String, dynamic> json){
    return CategoriesModel(
        id: json["id"],
        name: json["name"],
    );
  }
}