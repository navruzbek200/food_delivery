import 'package:food_delivery/features/orders/domain/entities/orders_entity.dart';

class CompletedOrderState {}

class CompletedOrderInitial extends CompletedOrderState{}

class CompletedOrderLoading extends CompletedOrderState{}

class CompletedOrderLoaded extends CompletedOrderState{
  final OrderEntity orderEntity;
  CompletedOrderLoaded({required this.orderEntity});
}

class CompletedOrderError extends CompletedOrderState{
  String message;
  CompletedOrderError({required this.message});
}