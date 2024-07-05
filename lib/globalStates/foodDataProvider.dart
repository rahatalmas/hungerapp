import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/getfoods.dart';
import 'package:hunger/dataModels/foodModel.dart';

class FoodListProvider extends ChangeNotifier {
  List<FoodModel> _foodList = [];
  
  List<FoodModel> get allFoods => _foodList;
  
  void setFoodList(List<FoodModel> foods) {
    _foodList = foods;
    notifyListeners();
  }
  void loadAllFoods() async{
    List<FoodModel> foods;
    foods = await getFoods();
    setFoodList(foods);
  }
  void filterByCategory(String category){
     _foodList = _foodList.where((food)=>food.foodCategory == category).toList();
     notifyListeners();
  }
  void filterByHotelname(String hotel){
    _foodList = _foodList.where((food)=>food.foodProvider.hotelName == hotel).toList();
    notifyListeners();
  }

}
