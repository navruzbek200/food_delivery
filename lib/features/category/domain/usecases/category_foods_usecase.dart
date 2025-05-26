import 'package:food_delivery/features/category/domain/entities/category_foods_entity.dart';
import 'package:food_delivery/features/category/domain/repository/category_repository.dart';

class CategoryFoodsUsecase {
  final CategoryRepository categoryRepository;

  CategoryFoodsUsecase({required this.categoryRepository});

  Future<List<CategoryFoodsEntity>> call({required int id}) {
    return categoryRepository.getFoodCategory(id: id);
  }
}
