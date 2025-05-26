import 'package:food_delivery/features/category/domain/entities/categories_entity.dart';
import 'package:food_delivery/features/category/domain/repository/category_repository.dart';

class CategoriesUseCase{
  final CategoryRepository categoryRepository;

  CategoriesUseCase({required this.categoryRepository});

  Future<List<CategoriesEntity>> call(){
    return categoryRepository.getCategories();
  }
}