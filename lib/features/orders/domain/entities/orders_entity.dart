// class OrderEntity {
//   String created_at;
//   String delivered_at;
//   int id;
//   String status;
//   double total_price;
//   int user_id;
//
//   OrderEntity({required this.created_at, required this.delivered_at, required this.id, required this.status, required this.total_price, required this.user_id});
//
// }

class OrderEntity {
  final int id;
  final int userId;
  final String status;
  final DateTime createdAt;
  final DateTime? deliveredAt;
  final double totalPrice;

  OrderEntity({
    required this.id,
    required this.userId,
    required this.status,
    required this.createdAt,
    this.deliveredAt,
    required this.totalPrice,
  });
}
