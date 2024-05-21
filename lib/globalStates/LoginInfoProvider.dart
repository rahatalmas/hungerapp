import 'package:flutter/cupertino.dart';
import 'package:hunger/dataModels/userModel.dart';

class LoginInfoProvider extends ChangeNotifier{
  Future <UserLoginInfoModel>? loginInfo;
  //get userloginInfo => loginInfo;
  void setLoginInfo(Future <UserLoginInfoModel> info){
    this.loginInfo = info;
    notifyListeners();
  }
  get userLoginInfo => this.loginInfo;
  void check(){
    print(loginInfo);
  }
}