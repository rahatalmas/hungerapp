import 'package:hunger/dataModels/foodModel.dart';

class CartItemModel{
  final FoodModel food_model;
  int quantity;
  DateTime date;
  CartItemModel({
    required this.food_model,
    required this.quantity,
    required this.date,
  });
}
