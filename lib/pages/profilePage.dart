import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/getUser.dart';
import 'package:hunger/globalStates/LoginInfoProvider.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Colors.orange[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<LoginInfoProvider>(
              builder: (context,user,child){
                return FutureBuilder(
                    future:user.loginInfo,
                    builder:(context,snapshot){
                      if(snapshot.hasData){
                        Map<String,dynamic> token = JwtDecoder.decode(snapshot.data!.accessToken);
                        print(token);
                        return FutureBuilder(
                            future: getUser(snapshot.data!.accessToken, token["user_id"]),
                            builder: (context,snapshot){
                              print(snapshot.hasData);
                              if(snapshot.hasData){
                                return Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.orange[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset(
                                            "assets/anya.jpg",
                                            height: 125,
                                            width: 125,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshot.data!.user_name),
                                            Text(snapshot.data!.user_email),
                                            Row(
                                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text("Received"),
                                                    Text("15")
                                                  ],
                                                ),
                                                SizedBox(width: 12,),
                                                Column(
                                                  children: [
                                                    Text("Pending"),
                                                    Text("5")
                                                  ],
                                                ),
                                                SizedBox(width: 12,),
                                                Column(
                                                  children: [
                                                    Text("Canceled"),
                                                    Text("2")
                                                  ],
                                                )
                                              ],
                                            ),
                                            InkWell(
                                              onTap: (){
                                                user.unsetLoginInfo();
                                                print(snapshot.hasData);
                                              },
                                              child: Text("Logout"),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                );
                              }else{
                                return Text("no data");
                              }
                            });
                      }else{
                        return Text("No accesstoken");
                      }
                    });
              },
            ),
          ],
        ),
      )
    );
  }
}