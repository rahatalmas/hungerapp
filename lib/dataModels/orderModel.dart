class OrderPost {
  int orderedUserId;
  int orderedFoodId;
  int quantity;
  DateTime time;

  OrderPost({
    required this.orderedUserId,
    required this.orderedFoodId,
    required this.quantity,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        'ordered_user_id': orderedUserId,
        'ordered_food_id': orderedFoodId,
        'quantity': quantity,
        'order_time': time.toIso8601String(),
      };
}

class Order {
  int orderId;
  int orderedUserId;
  int orderedFoodId;
  int quantity;
  bool orderStatus;
  DateTime time;

  Order({
    required this.orderId,
    required this.orderedUserId,
    required this.orderedFoodId,
    required this.quantity,
    required this.orderStatus,
    required this.time,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json['order_id'],
        orderedUserId: json['ordered_user_id'],
        orderedFoodId: json['ordered_food_id'],
        quantity: json['quantity'],
        orderStatus: json['order_status'],
        time: DateTime.parse(json['order_time']),
      );

  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'ordered_user_id': orderedUserId,
        'ordered_food_id': orderedFoodId,
        'quantity': quantity,
        'order_status': orderStatus,
        'order_time': time.toIso8601String()
      };
}