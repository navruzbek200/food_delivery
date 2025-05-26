import 'package:food_delivery/features/category/domain/entities/categories_entity.dart';

class CategoriesState{}

class CategoriesInitial extends CategoriesState{}

class CategoriesLoading extends CategoriesState{}

class CategoriesLoaded extends CategoriesState{
  final List<CategoriesEntity> categoriesEntity;

  CategoriesLoaded({required this.categoriesEntity});
}

class CategoriesError extends CategoriesState{
  final String message;

  CategoriesError({required this.message});
}

