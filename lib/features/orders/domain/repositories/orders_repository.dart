import 'package:food_delivery/features/orders/domain/entities/orders_entity.dart';
import 'package:food_delivery/features/orders/domain/entities/update_order_entity.dart';

abstract class OrdersRepository {
  Future<OrderEntity>get_all_orders();
  Future<OrderEntity>get_active_orders();
  Future<OrderEntity>get_completed_orders();
  Future<UpdateOrderEntity> updare_order({required int id});
}