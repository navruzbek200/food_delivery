import 'package:food_delivery/features/orders/domain/entities/orders_entity.dart';

class ActiveOrderState {}

class ActiveOrderInitial extends ActiveOrderState{}

class ActiveOrderLoading extends ActiveOrderState{}

class ActiveOrderLoaded extends ActiveOrderState{
  final OrderEntity orderEntity;
  ActiveOrderLoaded({required this.orderEntity});
}

class ActiveOrderError extends ActiveOrderState{
  String message;
  ActiveOrderError({required this.message});
}