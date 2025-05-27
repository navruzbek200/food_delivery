import 'package:dio/dio.dart';
import 'package:food_delivery/core/common/constants/api_url.dart';
import 'package:logger/logger.dart';

import '../../domain/entities/create_order_entity.dart';
import '../models/create_order_model.dart';

abstract class HomeRemoteDataSource {
  Future<CreateOrderEntity>create_order({required int count,required int food_id});
}

class HomeRemoteDatasourceImpl implements HomeRemoteDataSource{
  final Dio dio;
  var logger = Logger();
  HomeRemoteDatasourceImpl({required this.dio});

  @override
  Future<CreateOrderEntity> create_order({required int count, required int food_id}) async{
    logger.w("request| url:${ApiUrls.orders},count: $count,food_id: $food_id");
    final response = await dio.post(
        ApiUrls.orders,
        data: {
          "items":[{
            "count": count,
            "food_id": food_id
          }]
        }
    );
    if(response.statusCode == 200 || response.statusCode == 201){
      logger.i("CREATE ORDER RESPONSE:${response.data}");
      return CreateOrderModel.fromJson(response.data);
    }else {throw Exception("Error");}
  }
}