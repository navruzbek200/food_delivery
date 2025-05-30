import 'package:food_delivery/features/orders/domain/entities/orders_entity.dart';

class AllOrderState {

}

class AllOrderInital extends AllOrderState{}

class AllOrderLoading extends AllOrderState{}

class AllOrderLoaded extends AllOrderState{
  final List<OrderEntity> orderEntity;
  AllOrderLoaded({required this.orderEntity});

}

class AllOrderError extends AllOrderState{
  String message;
  AllOrderError({required this.message});
}