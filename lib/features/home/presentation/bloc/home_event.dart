abstract class HomeEvent{
  HomeEvent();
}

class CreateOrderEvent extends HomeEvent{
  final int count;
  final int food_id;

  CreateOrderEvent({required this.count,required this.food_id});
}