import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hunger/dataModels/userModel.dart';
import 'package:hunger/url.dart';

Future<UserModel> getUser(String accessToken,int userId) async{
  String id = userId.toString();
  String url = "http://$baseUrl/user/find/$id";
  final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader : accessToken
      }
  );
  if(response.statusCode == 200){
    UserModel user = UserModel.fromJson(jsonDecode(response.body));
    return user;
  }else{
    throw Exception("fail to get user");
  }
}
