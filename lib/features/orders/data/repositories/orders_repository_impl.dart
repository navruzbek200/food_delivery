import 'package:food_delivery/features/orders/data/data_sources/orders_remote_datasource.dart';
import 'package:food_delivery/features/orders/domain/entities/orders_entity.dart';
import 'package:food_delivery/features/orders/domain/entities/update_order_entity.dart';
import '../../../../core/utils/token_storage.dart';
import '../../domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDatasource ordersRemoteDatasource;

  OrdersRepositoryImpl({required this.ordersRemoteDatasource});

  @override
  Future<List<OrderEntity>> getAllOrders({required String status}) async {
    final token = await TokenStorage().getToken();
    if (token == null) {
      throw Exception('Token topilmadi');
    }
    return ordersRemoteDatasource.getAllOrders(status: status, token: token);
  }

  @override
  Future<List<OrderEntity>> getActiveOrders({required String status}) async{
    final token = await TokenStorage().getToken();
    if (token == null) {
      throw Exception('Token topilmadi');
    }
    return ordersRemoteDatasource.getActiveOrders(status: status, token: token);
  }

  @override
  Future<List<OrderEntity>> getCompletedOrders({required String status}) async{
    final token = await TokenStorage().getToken();
    if (token == null) {
      throw Exception('Token topilmadi');
    }
    return ordersRemoteDatasource.getCompletedOrders(status: status, token: token);
  }

  @override
  Future<UpdateOrderEntity> updateOrder({required int order_id}) async{
    final token = await TokenStorage().getToken();
    if (token == null) {
      throw Exception('Token topilmadi');
    }
    return ordersRemoteDatasource.updateOrder(order_id: order_id, token: token);
  }
}
