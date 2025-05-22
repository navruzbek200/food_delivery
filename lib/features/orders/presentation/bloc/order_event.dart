abstract class OrderEvent {
  OrderEvent();

}

class AllOrderEvent extends OrderEvent{
  AllOrderEvent();
}

class ActiveOrderEvent extends OrderEvent{
  ActiveOrderEvent();
}

class CompletedOrderEvent extends OrderEvent{
  CompletedOrderEvent();
}

class UpdateOrderEvent extends OrderEvent{
  final int id;
  UpdateOrderEvent({required this.id});
}