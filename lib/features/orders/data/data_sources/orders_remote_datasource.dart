import 'package:dio/dio.dart';
import 'package:food_delivery/core/common/constants/api_url.dart';
import 'package:food_delivery/features/orders/data/models/orders_model.dart';
import 'package:food_delivery/features/orders/data/models/update_order_model.dart';
import 'package:food_delivery/features/orders/domain/entities/orders_entity.dart';
import 'package:food_delivery/features/orders/domain/entities/update_order_entity.dart';
import 'package:logger/logger.dart';

abstract class OrdersRemoteDatasource {
  Future<OrderEntity>get_all_orders();
  Future<OrderEntity>get_active_orders();
  Future<OrderEntity>get_completed_orders();
  // Future<CreateOrderEntity>create_order({required int count,required int food_id});
  Future<UpdateOrderEntity> update_order({required int id});
}


class OrdersRemoteDatasourceImpl implements OrdersRemoteDatasource{
  final Dio dio;
  var logger = Logger();
  OrdersRemoteDatasourceImpl({required this.dio});

  @override
  Future<OrderEntity> get_all_orders()async {
    logger.w("shu yergacha ishlayapti| ${ApiUrls.ordersAll}");
    final response = await dio.get(ApiUrls.ordersAll);
    if(response.statusCode == 200 || response.statusCode == 201){
      logger.i("GET ALL ORDERS RESPONSE:${response.data}");
      return OrdersModel.fromJson(response.data);
    }else {throw Exception("Error");}
  }

  @override
  Future<OrderEntity> get_active_orders() async{
    logger.w("shu yergacha ishlayapti| ${ApiUrls.ordersActive}");
    final response = await dio.get(ApiUrls.ordersActive);
    if(response.statusCode == 200 || response.statusCode == 201){
      logger.i("GET ALL ACTIVE RESPONSE:${response.data}");
      return OrdersModel.fromJson(response.data);
    }else {throw Exception("Error");}
  }

  @override
  Future<OrderEntity> get_completed_orders()async {
    logger.w("shu yergacha ishlayapti| ${ApiUrls.ordersCompleted}");
    final response = await dio.get(ApiUrls.ordersCompleted);
    if(response.statusCode == 200 || response.statusCode == 201){
      logger.i("GET ALL COMPLETED RESPONSE:${response.data}");
      return OrdersModel.fromJson(response.data);
    }else {throw Exception("Error");}
  }

  @override
  Future<UpdateOrderEntity> update_order({required int id})async {
    logger.w("shu yergacha ishlayapti| ${ApiUrls.orderId}");
    final response = await dio.get(
        "${ApiUrls.orderId}id",
    );
    if(response.statusCode == 200 || response.statusCode == 201){
      logger.i("UPDATE ORDER RESPONSE:${response.data}");
      return UpdateOrderModel.fromJson(response.data);
    }else {throw Exception("Error");}
  }

}