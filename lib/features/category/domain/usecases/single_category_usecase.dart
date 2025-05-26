import 'package:food_delivery/features/category/domain/entities/single_category_entity.dart';

import '../repository/category_repository.dart';

class SingleCategoryUsecase{
  final CategoryRepository categoryRepository;

  SingleCategoryUsecase({required this.categoryRepository});

  Future<SingleCategoryEntity>call({required int id}){
    return categoryRepository.getSingleCategory(id: id);
  }
}