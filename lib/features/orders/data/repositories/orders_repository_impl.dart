import 'package:food_delivery/features/orders/data/data_sources/orders_remote_datasource.dart';
import 'package:food_delivery/features/home/domain/entities/create_order_entity.dart';
import 'package:food_delivery/features/orders/domain/entities/orders_entity.dart';
import 'package:food_delivery/features/orders/domain/entities/update_order_entity.dart';
import '../../domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDatasource ordersRemoteDatasource;
  OrdersRepositoryImpl({required this.ordersRemoteDatasource});

  @override
  Future<OrderEntity> get_all_orders() {
    return ordersRemoteDatasource.get_all_orders();
  }

  @override
  Future<OrderEntity> get_active_orders() {
    return ordersRemoteDatasource.get_active_orders();
  }

  @override
  Future<OrderEntity> get_completed_orders() {
    return ordersRemoteDatasource.get_completed_orders();
  }

  @override
  Future<UpdateOrderEntity> updare_order({required int id}) {
    return ordersRemoteDatasource.update_order(id: id);
  }

  // @override
  // Future<CreateOrderEntity> create_order({required int count, required int food_id}) {
  //   return ordersRemoteDatasource.create_order(count: count, food_id: food_id);
  // }

}