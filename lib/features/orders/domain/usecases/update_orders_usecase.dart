import 'package:food_delivery/features/orders/domain/entities/update_order_entity.dart';
import 'package:food_delivery/features/orders/domain/repositories/orders_repository.dart';

class UpdateOrdersUsecase{
  final OrdersRepository ordersRepository;

  UpdateOrdersUsecase({required this.ordersRepository});

  Future<UpdateOrderEntity> call ({required int id}){
    return ordersRepository.updare_order(id: id);
  }
}