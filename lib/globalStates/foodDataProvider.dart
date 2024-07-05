import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/getfoods.dart';
import 'package:hunger/dataModels/foodModel.dart';

class FoodListProvider extends ChangeNotifier {
  late List<FoodModel> _foodList;
  
  List<FoodModel> get allFoods => _foodList;
  
  void setFoodList(List<FoodModel> foods) {
    _foodList = foods;
    notifyListeners();
  }
  void getAllFoods() async{
    List<FoodModel> allfoods;
    allfoods = await getFoods();
    setFoodList(allfoods);
  }
}
