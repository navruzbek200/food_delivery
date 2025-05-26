import 'package:food_delivery/features/orders/domain/entities/orders_entity.dart';
import 'package:food_delivery/features/orders/domain/repositories/orders_repository.dart';

class CompletedOrdersUseCase{
  final OrdersRepository ordersRepository;

  CompletedOrdersUseCase({required this.ordersRepository});

  Future<OrderEntity> call(){
    return ordersRepository.get_completed_orders();
  }
}