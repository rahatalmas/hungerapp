import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:hunger/dataModels/user.dart';
import 'package:hunger/url.dart';

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
    return await post(
      Uri.parse("http://$baseUrl/user/register"),
      body: jsonEncode(registrationData),
      headers: {
          'Content-Type': 'application/json',
        }
      ).then(onValue).catchError(onError);
  }
  
  loginUser(String userEmail, String password) async{
    isLoading = true;
    ChangeNotifier();
    //notifyListeners();

    final Map<String,dynamic> loginData = {
      "user_email":userEmail.trim(),
      "user_password":password.trim()
    };

    return await post(
      Uri.parse("http://$baseUrl/user/login"),
      body:jsonEncode(loginData),
      headers: {
        'content-Type' : 'application/json'
      }
    ).then(onValue).catchError(onError);
  }

  updateUser(
    String userName, 
    String userEmail,
    String userContact,
    String userPicture,
    String userLocation,
    int userId
    )async{
    isLoading = true;
    notifyListeners();
    
    final Map<String,dynamic> updateData = {
      "user_name":userName.trim(),
      "user_email":userEmail.trim(),
      "user_contact":userContact.trim(),
      "user_picture":userPicture.trim(),
      "user_location":userLocation.trim()
    };
    final response = await put(
      Uri.parse("http://$baseUrl/user/update/$userId"),
      body: jsonEncode(updateData),
      headers: {
          'Content-Type': 'application/json',
        }
      );
      if(response.statusCode == 200){
        final Map<String,dynamic> responseData = json.decode(response.body);
        UserAuth updateInfo = UserAuth.formjson(responseData); 
        return updateInfo;
      }else{
        print("update failed");
      }
      //.then(onValue).catchError(onError);
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