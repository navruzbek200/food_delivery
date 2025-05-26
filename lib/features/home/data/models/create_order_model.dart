import 'package:food_delivery/features/home/domain/entities/create_order_entity.dart';

class CreateOrderModel extends CreateOrderEntity{
  CreateOrderModel({required super.additionalProp1});

  factory CreateOrderModel.fromJson(Map<String,dynamic> json){
    return CreateOrderModel(additionalProp1: json["additionalProp1"]);
  }
}