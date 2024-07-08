import 'package:hunger/dataModels/foodModel.dart';

class OrderPost {
  int orderedUserId;
  int orderedFoodId;
  int quantity;
  String deliveryLocation;
  DateTime time;

  OrderPost({
    required this.orderedUserId,
    required this.orderedFoodId,
    required this.quantity,
    required this.deliveryLocation,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        'ordered_user_id': orderedUserId,
        'ordered_food_id': orderedFoodId,
        'quantity': quantity,
        'delivery_location':deliveryLocation,
        'order_time': time.toIso8601String(),
      };
}

class Order {
  final int orderId;
  final int orderedUserId;
  final int orderedFoodId;
  final int quantity;
  final String deliveryLocation;
  final bool orderStatus;
  final DateTime orderTime;
  final FoodModel food;

  Order({
    required this.orderId,
    required this.orderedUserId,
    required this.orderedFoodId,
    required this.quantity,
    required this.deliveryLocation,
    required this.orderStatus,
    required this.orderTime,
    required this.food,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'] as int,
      orderedUserId: json['ordered_user_id'] as int,
      orderedFoodId: json['ordered_food_id'] as int,
      quantity: json['quantity'] as int,
      deliveryLocation: json['delivery_location'] as String,
      orderStatus: json['order_status'] as bool,
      orderTime: DateTime.parse(json['order_time'] as String),
      food: FoodModel.fromJson(json['food_info'] as Map<String, dynamic>),
    );
  }
}
