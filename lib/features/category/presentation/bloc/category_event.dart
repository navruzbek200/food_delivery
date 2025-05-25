abstract class CategoryEvent{
  CategoryEvent();
}

class CategoriesEvent extends CategoryEvent{
  CategoriesEvent();
}

class SingleCategoryEvent extends CategoryEvent{
  final int id;
  SingleCategoryEvent({required this.id});
}


class CategoryFoodsEvent extends CategoryEvent{
  final int id;
  CategoryFoodsEvent({required this.id});
}