// import 'package:food_delivery/features/orders/domain/entities/orders_entity.dart';
//
// class OrdersModel extends OrderEntity {
//   OrdersModel({
//     required super.created_at,
//     required super.delivered_at,
//     required super.id,
//     required super.status,
//     required super.total_price,
//     required super.user_id,
//   });
//
//   factory OrdersModel.fromJson(Map<String, dynamic> json) {
//     return OrdersModel(
//       created_at: json["created_at"],
//       delivered_at: json["delivered_at"],
//       id: json["id"],
//       status: json["status"],
//       total_price: json["total_price"],
//       user_id: json["user_id"],
//     );
//   }
// }





import '../../domain/entities/orders_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.id,
    required super.userId,
    required super.status,
    required super.createdAt,
    super.deliveredAt,
    required super.totalPrice,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      deliveredAt: json['delivered_at'] != null
          ? DateTime.parse(json['delivered_at'])
          : null,
      totalPrice: (json['total_price'] as num).toDouble(),
    );
  }
}
