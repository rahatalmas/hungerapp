import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/getfoods.dart';
import 'package:hunger/dataModels/foodModel.dart';

class FoodDataProvider with ChangeNotifier{
  late List<FoodModel> foods;
  List<FoodModel>filterFoods = [];
  bool loading = false;
  allFoods() async{
    loading = true;
    foods = await getFoods();
    loading =false;
    notifyListeners();
  }
  List<FoodModel> filterCategory(String category){
    filterFoods = foods;
    filterFoods = filterFoods.where((food)=>food.foodCategory ==category).toList();
    return filterFoods;
  }
  List<FoodModel> filterHotel(String hotel){
    filterFoods = foods;
    filterFoods = filterFoods.where((food)=>food.foodProvider.hotelName == hotel).toList();
    return filterFoods;
  }

}