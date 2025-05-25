
import 'package:food_delivery/features/category/domain/entities/category_foods_entity.dart';

class CategoryFoodsState{}

class CategoryFoodsInitial extends CategoryFoodsState{}

class CategoryFoodsLoading extends CategoryFoodsState{}

class CategoryFoodsLoaded extends CategoryFoodsState{
  final List<CategoryFoodsEntity> category;

  CategoryFoodsLoaded({required this.category});
}

class CategoryFoodsError extends CategoryFoodsState{
  final String message;

  CategoryFoodsError({required this.message});
}

