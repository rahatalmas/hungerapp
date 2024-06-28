import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:hunger/dataModels/cartItemModel.dart';

class MealItemProvider extends ChangeNotifier{

  final List<CartItemModel> mealItems = [];

  UnmodifiableListView<CartItemModel> get cartList => UnmodifiableListView(mealItems);
  int get mealItemsLength => mealItems.length;

  void addCartItem(CartItemModel item){
    print(item);
    mealItems.add(item);
    notifyListeners();
  }

    void addQuantity(int index){
    mealItems[index].quantity+=1;
    notifyListeners();
    //print('update');
  }
  void subQuantity(int index){
    if(mealItems[index].quantity>1) {
      mealItems[index].quantity -= 1;
    }
    notifyListeners();
  }
}