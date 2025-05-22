import 'package:food_delivery/features/orders/domain/entities/update_order_entity.dart';

class UpdateOrderModel extends UpdateOrderEntity{
  UpdateOrderModel({required super.additionalProp1});

  factory UpdateOrderModel.fromJson(Map<String,dynamic> json){
    return UpdateOrderModel(additionalProp1: json["additionalProp1"]);
  }
}