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
  final FoodProvider foodProvider;

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
    required this.foodProvider,
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
      foodProvider: FoodProvider.fromJson(json['food_provider']),
    );
  }
}

class FoodProvider {
  final String hotelName;

  FoodProvider({
    required this.hotelName,
  });

  factory FoodProvider.fromJson(Map<String, dynamic> json) {
    return FoodProvider(
      hotelName: json['hotel_name'] as String,
    );
  }
}