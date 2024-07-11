import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:hunger/dataModels/hotelModel.dart';

Future<List<Hotel>> getHotels() async{
  String url = "http://192.168.0.116:5000/hotel";
  final response = await http.get(Uri.parse(url));
  if(response.statusCode == 200){
    List<dynamic> jsonList = jsonDecode(response.body);
    List<Hotel> hotelList = jsonList.map((json)=>Hotel.fromJson(json)).toList();
    return hotelList;
  }else{
    return throw Exception('response failed');
  }
}