import '../../domain/entities/create_order_entity.dart';

abstract class HomeRemoteDataSource {
  Future<CreateOrderEntity>createOrder({required int count,required int food_id,required String token,});
}

