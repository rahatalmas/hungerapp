import 'package:flutter/material.dart';
import 'package:hunger/globalStates/LoginInfoProvider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget{
  ProfilePage({super.key});
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
                print(user.loginInfo);
                return FutureBuilder(
                    future:
                    user.loginInfo,
                    builder:(context,snapshot){
                      return Text(snapshot.data?.accessToken ?? 'Access Token Not Available');
                    });
              },
            ),
            Container(
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Anya Forger"),
                      Text("Daffodil International University"),
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
                      )
                    ],
                  )
                ],
              )
            ),

          ],
        ),
      )
    );
  }
}