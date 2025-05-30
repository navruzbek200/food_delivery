import 'package:food_delivery/features/orders/domain/entities/orders_entity.dart';

import '../entities/update_order_entity.dart';

abstract class OrdersRepository {

  Future<List<OrderEntity>>getAllOrders({required String status});

  Future<List<OrderEntity>>getActiveOrders({required String status});

  Future<List<OrderEntity>>getCompletedOrders({required String status});

  Future<UpdateOrderEntity> updateOrder({required int order_id});
}

