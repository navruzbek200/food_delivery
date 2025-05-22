import 'package:food_delivery/features/orders/domain/entities/orders_entity.dart';

class OrdersModel extends OrderEntity {
  OrdersModel({
    required super.created_at,
    required super.delivered_at,
    required super.id,
    required super.status,
    required super.total_price,
    required super.user_id,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      created_at: json["created_at"],
      delivered_at: json["delivered_at"],
      id: json["id"],
      status: json["status"],
      total_price: json["total_price"],
      user_id: json["user_id"],
    );
  }
}
