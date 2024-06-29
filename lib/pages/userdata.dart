import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/getUser.dart';
import 'package:hunger/globalStates/LoginInfoProvider.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class UserData extends StatefulWidget{
  UserData({super.key,required this.child});
  Widget child;
  @override  
  State<UserData> createState()=>_UserData();
}

class _UserData extends State<UserData>{
  @override  
  Widget build(BuildContext context){
    return Consumer<LoginInfoProvider>(
              builder: (context,user,child){
                return FutureBuilder(
                    future:user.loginInfo,
                    builder:(context,snapshot){
                      if(snapshot.hasData){
                        Map<String,dynamic> token = JwtDecoder.decode(snapshot.data!.accessToken);
                        return FutureBuilder(
                            future: getUser(snapshot.data!.accessToken, token["user_id"]),
                            builder: (context,snapshot){
                              print(snapshot.hasData);
                              if(snapshot.hasData){
                                return widget.child;
                              }
                              return Text("Invalid");

                            }
                        );
                      }
                      return Text("Invalid");

                    }
                );
              }
);          
  }
}


