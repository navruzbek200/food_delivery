import 'package:dio/dio.dart';
import 'package:food_delivery/core/network/dio_client.dart';
import 'package:food_delivery/features/orders/data/models/orders_model.dart';
import 'package:food_delivery/features/orders/domain/entities/orders_entity.dart';
import 'package:logger/logger.dart';
import '../../../../core/common/constants/api_url.dart';
import '../../domain/entities/update_order_entity.dart';
import '../models/update_order_model.dart';
import 'orders_remote_datasource.dart';

class OrdersRemoteDatasourceImpl implements OrdersRemoteDatasource {
  final DioClient dioClient;
  var logger = Logger();

  OrdersRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<List<OrderEntity>> getAllOrders({
    required String token,
    required String status,
  }) async {
    logger.w("status $status,token $token");
    try {
      final response = await dioClient.get(
        ApiUrls.ordersAll,
        queryParameters: {'status': status},
        options: Options(headers: {"Authorization": "Bearer $token"}),
        //   options: Options(
        //   headers: {
        //     'Authorization': 'Bearer YOUR_TOKEN_HERE',
        //     'accept': 'application/json',
        //   },
        // ),
      );
      logger.w("getAllOrders response: ${response.data}");

      final data = response.data as List;
      return data.map((e) => OrderModel.fromJson(e)).toList();
      // if (data is Map && data['orders'] is List ){
      //   return (data['orders'] as List)
      //       .map((json) => OrderModel.fromJson(json))
      //       .toList();
      // }else {
      //   throw Exception('Unexpected response format: $data');
      // }
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => OrderModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load all orders: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting all orders: $e');
    }
  }

  @override
  Future<List<OrderEntity>> getActiveOrders({
    required String token,
    required String status,
  }) async {
    logger.w("status $status,token $token");
    try {
      final response = await dioClient.get(
        ApiUrls.ordersActive,
        queryParameters: {'status': status},
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      logger.w("getActiveOrders response: ${response.data}");

      final data = response.data as List;
      return data.map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Error getting all orders: $e');
    }
  }

  @override
  Future<List<OrderEntity>> getCompletedOrders({
    required String token,
    required String status,
  }) async {
    logger.w("status $status,token $token");
    try {
      final response = await dioClient.get(
        ApiUrls.ordersCompleted,
        queryParameters: {'status': status},
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      logger.w("ordersCompleted response: ${response.data}");

      final data = response.data as List;
      return data.map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Error getting all orders: $e');
    }
  }

  @override
  Future<UpdateOrderEntity> updateOrder({required int order_id, required String token}) async {
    logger.w("shu yergacha ishlayapti| ${ApiUrls.orderId}");

    final response = await dioClient.put("${ApiUrls.orderId}$order_id",options: Options(headers: {"Authorization": "Bearer $token"}),);
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i("UPDATE ORDER RESPONSE:${response.data}");
      return UpdateOrderModel.fromJson(response.data);
    } else {
      throw Exception("Error");
    }
  }
}
