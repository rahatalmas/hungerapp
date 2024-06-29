//import 'package:hunger/dataModels/foodModel.dart';
class FoodModel {
  final int foodId;
  final String foodName;
  final double foodPrice;
  final String foodCategory;
  final bool foodInStock;
  final String foodDescription;
  final String foodPicture;
  final int? foodReview;
  final int foodProviderId;

  FoodModel({
    required this.foodId,
    required this.foodName,
    required this.foodPrice,
    required this.foodCategory,
    required this.foodInStock,
    required this.foodDescription,
    required this.foodPicture,
    required this.foodReview,
    required this.foodProviderId,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      foodId: json['food_id'] as int,
      foodName: json['food_name'] as String,
      foodPrice: double.parse(json['food_price'] as String),
      foodCategory: json['food_category'] as String,
      foodInStock: json['food_instock'] as bool,
      foodDescription: json['food_description'] as String,
      foodPicture: json['food_picture'] as String,
      foodReview: json['food_review'] as int?,
      foodProviderId: json['food_provider_id'] as int,
    );
  }
}




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
  final int orderId;
  final int orderedUserId;
  final int orderedFoodId;
  final int quantity;
  final bool orderStatus;
  final DateTime orderTime;
  final FoodModel food;

  Order({
    required this.orderId,
    required this.orderedUserId,
    required this.orderedFoodId,
    required this.quantity,
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
      orderStatus: json['order_status'] as bool,
      orderTime: DateTime.parse(json['order_time'] as String),
      food: FoodModel.fromJson(json['food_info'] as Map<String, dynamic>),
    );
  }
}
