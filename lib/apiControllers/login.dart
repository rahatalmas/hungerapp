import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hunger/dataModels/userModel.dart';

Future<UserLoginInfoModel> userLogin(user_name,user_password) async{
  String url = "http://192.168.189.175:5000/user/login";
  final response = await http.post(
      Uri.parse(url),
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(<String,String>{
        "user_name":user_name,
        "user_password":user_password
      })
  );
  if(response.statusCode == 200){
    return UserLoginInfoModel.formJson(jsonDecode(response.body));
  }
  throw Exception('login failed');
}