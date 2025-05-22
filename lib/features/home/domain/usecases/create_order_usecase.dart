import 'package:food_delivery/features/home/domain/entities/create_order_entity.dart';
import 'package:food_delivery/features/home/domain/repositories/home_repository.dart';

class CreateOrderUseCase{
  final HomeRepository homeRepository;

  CreateOrderUseCase({required this.homeRepository});

  Future<CreateOrderEntity> call ({required int count,required int food_id}){
    return homeRepository.create_order(count: count, food_id: food_id);
  }
}