import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:hunger/dataModels/cartItemModel.dart';

class MealItemProvider extends ChangeNotifier{

  final List<CartItemModel> mealItems = [];

  UnmodifiableListView<CartItemModel> get cartList => UnmodifiableListView(mealItems);
  int get mealItemsLength => mealItems.length;

  void addCartItem(CartItemModel item){
    mealItems.add(item);
    notifyListeners();
  }

    void addQuantity(int index){
    mealItems[index].quantity+=1;
    notifyListeners();
  }
  void subQuantity(int index){
    if(mealItems[index].quantity>1) {
      mealItems[index].quantity -= 1;
    }
    notifyListeners();
  }
  int numOfUniqueDays() {
    Set<int> uniqueDays = {};
    for (var item in mealItems) {
      uniqueDays.add(item.date.day);
    }
    return uniqueDays.length;
  }
   double getTotalPrice() {
    double totalPrice = 0.0;
    for (var item in mealItems) {
      totalPrice += item.quantity * item.food_model.foodPrice;
    }
    return totalPrice;
  }
  void resetList(){
    mealItems.clear();
    notifyListeners();
  }

}