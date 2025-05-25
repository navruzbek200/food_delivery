import 'package:food_delivery/features/category/domain/entities/single_category_entity.dart';

class SingleCategoryState{}

class SingleCategoryInitial extends SingleCategoryState{}

class SingleCategoryLoading extends SingleCategoryState{}

class SingleCategoryLoaded extends SingleCategoryState{
  final SingleCategoryEntity singleCategoryEntity;

  SingleCategoryLoaded({required this.singleCategoryEntity});
}

class SingleCategoryError extends SingleCategoryState{
  final String message;

  SingleCategoryError({required this.message});
}