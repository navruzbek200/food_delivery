import 'package:food_delivery/features/home/domain/entities/create_order_entity.dart';

abstract class HomeRepository {
  Future<CreateOrderEntity>createOrder({required int count,required int food_id});

}