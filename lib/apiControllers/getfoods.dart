import 'package:http/http.dart' as http;
//import 'dart:async';
import 'dart:convert';
import 'package:hunger/dataModels/foodModel.dart';

Future<List<FoodModel>> getFoods() async{
  String url = "http://192.168.243.213:5000/food/allfoods";
  final response = await http.get(Uri.parse(url));
  //List<FoodModel> foodList = [];
  if(response.statusCode == 200){
    List<dynamic> jsonList = jsonDecode(response.body);
    List<FoodModel> foodList = jsonList.map((json)=>FoodModel.fromJson(json)).toList();
    return foodList;
  }else{
    return throw Exception('response failed');
  }
}



