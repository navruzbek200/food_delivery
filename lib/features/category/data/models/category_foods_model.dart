import 'package:food_delivery/features/category/domain/entities/category_foods_entity.dart';
List<CategoryFoodsModel> getfoodcategoriesFromJson(List str) =>
    List<CategoryFoodsModel>.from(str.map((x) => CategoryFoodsModel.fromJson(x)));
class CategoryFoodsModel extends CategoryFoodsEntity {
  CategoryFoodsModel(
      {required super.category_id, required super.count_food, required super.id, required super.img_url, required super.name, required super.price});

  factory CategoryFoodsModel.fromJson(Map<String, dynamic> json){
    return CategoryFoodsModel(
        category_id: json["category_id"],
        count_food: json["count_food"],
        id: json["id"],
        img_url: json["img_url"],
        name: json["name"],
        price: json["price"]
    );
  }

}