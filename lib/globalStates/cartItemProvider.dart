import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:hunger/dataModels/cartItemModel.dart';

class CartItemProvider extends ChangeNotifier{

  final List<CartItemModel> cartItems = [];

  UnmodifiableListView<CartItemModel> get cartList => UnmodifiableListView(cartItems);
  int get cartLength => cartItems.length;

  void addCartItem(CartItemModel item){
    
    bool found = false;
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].food_model.foodName == item.food_model.foodName && cartItems[i].food_model.foodProviderId == item.food_model.foodProviderId) {
        cartItems[i].quantity += item.quantity;
        found = true;
        break;
      }
    }
    if(!found){
       cartItems.add(item);
    }
    notifyListeners();
  }
  void addQuantity(int index){
    cartItems[index].quantity+=1;
    notifyListeners();
  }
  void subQuantity(int index){
    if(cartItems[index].quantity>1) {
      cartItems[index].quantity -= 1;
    }
    notifyListeners();
  }
  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      totalPrice += item.quantity * item.food_model.foodPrice;
    }
    return totalPrice;
  }
  int totalItem(){
     int totalItems = 0;
    for (var item in cartItems) {
      totalItems += item.quantity;
    }
    return totalItems;
  }
  void clearList(){
    cartItems.clear();
    notifyListeners();
  }
  void removeSpecific(int index){
     cartItems.removeAt(index);
     notifyListeners();
  }
}