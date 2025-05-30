import 'package:dio/dio.dart';
import 'package:food_delivery/core/network/dio_client.dart';
import 'package:logger/logger.dart';
import '../../../../core/common/constants/api_url.dart';
import '../../domain/entities/create_order_entity.dart';
import '../models/create_order_model.dart';
import 'home_remote_data_source.dart';

class HomeRemoteDatasourceImpl implements HomeRemoteDataSource{
  final DioClient dioClient;
  var logger = Logger();
  HomeRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<CreateOrderEntity> createOrder({required int count, required int food_id,required String token,
  }) async{
    logger.w("request| url:${ApiUrls.orders},count: $count,food_id: $food_id");
    final response = await dioClient.post(
        ApiUrls.orders,
        data: {
          "items":[{
            "count": count,
            "food_id": food_id
          }]
        },
        options:Options(headers: {
    "Authorization": "Bearer $token",
    })
    );
    if(response.statusCode == 200 || response.statusCode == 201){
      logger.i("CREATE ORDER RESPONSE:${response.data}");
      return CreateOrderModel.fromJson(response.data);
    }else {throw Exception("Error");}
  }
}