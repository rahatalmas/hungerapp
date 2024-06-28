import 'package:hunger/dataModels/foodModel.dart';

class CartItemModel{
  final FoodModel food_model;
  final int userId;
  int quantity;
  String? category;
  DateTime date;
  CartItemModel({
    required this.food_model,
    required this.userId,
    required this.quantity,
    required this.category,
    required this.date,
  });
}
