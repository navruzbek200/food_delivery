abstract class OrderEvent {
  const OrderEvent();

}

class AllOrderEvent extends OrderEvent{
  final String status;

  AllOrderEvent({required this.status});
}

class ActiveOrderEvent extends OrderEvent{
  final String status;

  ActiveOrderEvent({required this.status});
}

class CompletedOrderEvent extends OrderEvent{
  final String status;

  CompletedOrderEvent({required this.status});
}

class UpdateOrderEvent extends OrderEvent{
  final int order_id;

  UpdateOrderEvent({required this.order_id});
}