import 'package:food_delivery/features/orders/domain/repositories/orders_repository.dart';
import '../entities/orders_entity.dart';

class OrdersUsecase {
  final OrdersRepository ordersRepository;

  OrdersUsecase({required this.ordersRepository});

  Future<List<OrderEntity>> call({required String status}) {
    return ordersRepository.getAllOrders(status: status);
  }
}
