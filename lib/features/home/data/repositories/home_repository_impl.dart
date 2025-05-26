import 'package:food_delivery/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:food_delivery/features/home/domain/repositories/home_repository.dart';

import '../../domain/entities/create_order_entity.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDatasource;
  HomeRepositoryImpl({required this.homeRemoteDatasource});

  @override
  Future<CreateOrderEntity> create_order({required int count, required int food_id}) {
    return homeRemoteDatasource.create_order(count: count, food_id: food_id);
  }

}