import 'package:food_delivery/features/home/domain/entities/create_order_entity.dart';

class CreateOrderState {}

class CreateOrderInitial extends CreateOrderState{}

class CreateOrderLoading extends CreateOrderState{}

class CreateOrderLoaded extends CreateOrderState{
  final CreateOrderEntity createOrderEntity;
  CreateOrderLoaded({required this.createOrderEntity});
}

class CreateOrderError extends CreateOrderState{
  String message;
  CreateOrderError({required this.message});
}