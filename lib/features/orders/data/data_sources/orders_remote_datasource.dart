import 'package:dio/dio.dart';
import 'package:food_delivery/core/common/constants/api_url.dart';
import 'package:food_delivery/features/home/data/models/create_order_model.dart';
import 'package:food_delivery/features/orders/data/models/orders_model.dart';
import 'package:food_delivery/features/orders/data/models/update_order_model.dart';
import 'package:food_delivery/features/orders/domain/entities/orders_entity.dart';
import 'package:food_delivery/features/orders/domain/entities/update_order_entity.dart';
import 'package:logger/logger.dart';
import '../../../home/domain/entities/create_order_entity.dart';

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
    logger.w("shu yergacha ishlayapti| ${ApiUrl.ordersAll}");
    final response = await dio.get(ApiUrl.ordersAll);
    if(response.statusCode == 200 || response.statusCode == 201){
      logger.i("GET ALL ORDERS RESPONSE:${response.data}");
      return OrdersModel.fromJson(response.data);
    }else {throw Exception("Error");}
  }

  @override
  Future<OrderEntity> get_active_orders() async{
    logger.w("shu yergacha ishlayapti| ${ApiUrl.ordersActive}");
    final response = await dio.get(ApiUrl.ordersActive);
    if(response.statusCode == 200 || response.statusCode == 201){
      logger.i("GET ALL ACTIVE RESPONSE:${response.data}");
      return OrdersModel.fromJson(response.data);
    }else {throw Exception("Error");}
  }

  @override
  Future<OrderEntity> get_completed_orders()async {
    logger.w("shu yergacha ishlayapti| ${ApiUrl.ordersCompleted}");
    final response = await dio.get(ApiUrl.ordersCompleted);
    if(response.statusCode == 200 || response.statusCode == 201){
      logger.i("GET ALL COMPLETED RESPONSE:${response.data}");
      return OrdersModel.fromJson(response.data);
    }else {throw Exception("Error");}
  }

  @override
  Future<UpdateOrderEntity> update_order({required int id})async {
    logger.w("shu yergacha ishlayapti| ${ApiUrl.orderId}");
    final response = await dio.get(
        "${ApiUrl.orderId}id",
    );
    if(response.statusCode == 200 || response.statusCode == 201){
      logger.i("UPDATE ORDER RESPONSE:${response.data}");
      return UpdateOrderModel.fromJson(response.data);
    }else {throw Exception("Error");}
  }

  // @override
  // Future<CreateOrderEntity> create_order({required int count, required int food_id}) async{
  //   logger.w("request| url:${ApiUrl.orders},count: $count,food_id: $food_id");
  //   final response = await dio.post(
  //       ApiUrl.orders,
  //     data: {}
  //   );
  //   if(response.statusCode == 200 || response.statusCode == 201){
  //     logger.i("CREATE ORDER RESPONSE:${response.data}");
  //     return CreateOrderModel.fromJson(response.data);
  //   }else {throw Exception("Error");}
  // }
}