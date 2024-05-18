import 'package:hunger/dataModels/foodModel.dart';

class CartItemModel{
  final FoodModel food_model;
  final int userId;
  int quantity;
  final String category;
  CartItemModel({
    required this.food_model,
    required this.userId,
    required this.quantity,
    required this.category
  });
}

CartItemModel cartItem = CartItemModel(
    food_model: FoodModel(
        foodId: 3,
        foodName: "Chicken Dominator",
        foodPrice: 450.0,
        foodInStock: true,
        foodDescription: "Best in Dominos.",
        foodPicture: "assets/pizza.png",
        foodReview: 4,
        foodProviderId: 3,
        foodProvider: FoodProvider(
          hotelName: "Dominos"
        )
    ),
    userId: 3,
    quantity: 2,
    category: "Fast Food"
);