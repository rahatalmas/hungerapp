import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:hunger/dataModels/user.dart';

class UserAuthProvider with ChangeNotifier{
  UserAuth authData = UserAuth();
  bool isLoading = false;
  int statusCode = 0;
  registerUser(
    String userName, 
    String userEmail,
    String userPassword,
    String userContact,
    String userPicture,
    String userLocation
    )async{
    isLoading = true;
    notifyListeners();
    
    final Map<String,dynamic> registrationData = {
      "user_name":userName.trim(),
      "user_email":userEmail.trim(),
      "user_password":userPassword.trim(),
      "user_contact":userContact.trim(),
      "user_picture":userPicture.trim(),
      "user_location":userLocation.trim()
    };

    //register
    return await post(
      Uri.parse("http://192.168.0.106:5000/user/register"),
      body: jsonEncode(registrationData),
      headers: {
          'Content-Type': 'application/json',
        }
      ).then(onValue).catchError(onError);
  }
  
  loginUser(String userName, String password) async{
    isLoading = true;
    ChangeNotifier();
    //notifyListeners();

    final Map<String,dynamic> loginData = {
      "user_name":userName.trim(),
      "user_password":password.trim()
    };
    
    //login
    return await post(
      Uri.parse("http://192.168.0.106:5000/user/login"),
      body:jsonEncode(loginData),
      headers: {
        'content-Type' : 'application/json'
      }
    ).then(onValue).catchError(onError);
  }

  Future<FutureOr>onValue(Response response)async{
    String? result;
    final Map<String,dynamic> responseData = json.decode(response.body);
    authData = UserAuth.formjson(responseData);
    statusCode = response.statusCode;
    if(response.statusCode == 200){
       isLoading = false;
    }else{
      result = authData.message;
      isLoading = false;
    }
    notifyListeners();
    return result;
  }

  onError(error)async{
     return error;
  }
  
  void logOut(){
    authData.token = null;
    authData.message = "";
    statusCode = 0;
    notifyListeners();
  }

}