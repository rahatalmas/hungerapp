import 'package:flutter/cupertino.dart';
import 'package:hunger/dataModels/userModel.dart';

class LoginInfoProvider extends ChangeNotifier {
  Future<UserLoginInfoModel>? _loginInfo;
  void setLoginInfo(Future<UserLoginInfoModel> info) {
    _loginInfo = info;
    notifyListeners();
  }
  void unsetLoginInfo(){
    _loginInfo = null;
    notifyListeners();
  }
  Future<UserLoginInfoModel>? get loginInfo => _loginInfo;
}