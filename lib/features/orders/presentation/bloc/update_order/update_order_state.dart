import 'package:food_delivery/features/orders/domain/entities/update_order_entity.dart';

class UpdateOrderState {}

class UpdateOrderInitial extends UpdateOrderState{}

class UpdateOrderLoading extends UpdateOrderState{}

class UpdateOrderLoaded extends UpdateOrderState{
  final UpdateOrderEntity updateOrderEntity;
  UpdateOrderLoaded({required this.updateOrderEntity});
}

class UpdateOrderError extends UpdateOrderState{
  String message;
  UpdateOrderError({required this.message});
}