import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:hunger/dataModels/cartItemModel.dart';

class CartItemProvider extends ChangeNotifier{

  final List<CartItemModel> cartItems = [];

  UnmodifiableListView<CartItemModel> get cartList => UnmodifiableListView(cartItems);
  int get cartLength => cartItems.length;

  void addCartItem(CartItemModel item){
    cartItems.add(item);
    notifyListeners();
  }
  void addQuantity(int index){
    cartItems[index].quantity+=1;
    notifyListeners();
    //print('update');
  }
  void subQuantity(int index){
    if(cartItems[index].quantity>1) {
      cartItems[index].quantity -= 1;
    }
    notifyListeners();
  }
}