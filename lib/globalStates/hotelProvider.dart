import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/gethotels.dart';
import 'package:hunger/dataModels/hotelModel.dart';

class hotelListProvider extends ChangeNotifier {
  List<Hotel> _hotelList = [];
  
  List<Hotel> get allhotels => _hotelList;
  
  void sethotelList(List<Hotel> hotels) {
    _hotelList = hotels;
    notifyListeners();
  }
  void loadAllhotels() async{
    List<Hotel> hotels;
    hotels = await getHotels();
    sethotelList(hotels);
  }

}
