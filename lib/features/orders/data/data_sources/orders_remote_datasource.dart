import 'package:dio/dio.dart';
import 'package:food_delivery/core/common/constants/api_url.dart';
import 'package:food_delivery/features/orders/data/models/orders_model.dart';
import 'package:food_delivery/features/orders/data/models/update_order_model.dart';
import 'package:food_delivery/features/orders/domain/entities/orders_entity.dart';
import 'package:food_delivery/features/orders/domain/entities/update_order_entity.dart';
import 'package:logger/logger.dart';

abstract class OrdersRemoteDatasource {

  Future<List<OrderEntity>>getAllOrders({required String status, required String token});

  Future<List<OrderEntity>>getActiveOrders({required String status, required String token});

  Future<List<OrderEntity>>getCompletedOrders({required String status, required String token});

  Future<UpdateOrderEntity> updateOrder({required int order_id, required String token});

}




