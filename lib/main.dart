import 'package:flutter/material.dart';
import 'package:hunger/globalStates/LoginInfoProvider.dart';
import 'package:hunger/globalStates/mealprovider.dart';
import 'package:hunger/globalStates/userAuthProvider.dart';
import 'package:hunger/pages/registerPage.dart';
import 'package:hunger/rootpage.dart';
import 'package:hunger/pages/loginpage.dart';
import 'package:hunger/globalStates/cartItemProvider.dart';
import 'package:provider/provider.dart';
import 'package:hunger/pages/foodDetails.dart';

void main() {
  runApp(
     MultiProvider(
         providers:[
           ChangeNotifierProvider(create: (context)=>LoginInfoProvider()),
           ChangeNotifierProvider(create: (context)=>UserAuthProvider()),
           ChangeNotifierProvider(create: (context)=>CartItemProvider()),
           ChangeNotifierProvider(create: (context)=>MealItemProvider()),
         ],
       child: const MyApp(),
     ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hunger',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:Consumer<LoginInfoProvider>(
          builder: (context,user,child){
            print(user.loginInfo);
            if(user.loginInfo != null){
              return FutureBuilder(
                  future: user.loginInfo,
                  builder: (context,snapshot){
                if(snapshot.hasData){
                  return Root();
                }else{
                  return LoginPage();
                }
              });
            }else{
              return LoginPage();
            }
          },
        )

        );
  }
}


/*
version 1 protection



*/


 




/*

FutureBuilder(
                future: user.loginInfo,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                      return Root();
                  }else{
                    return const LoginPage();
                  }
                }

 FutureBuilder(
                future:user.userLoginInfo,
                builder:(context,snapshot){
                  print(snapshot.hasData);
                  if(snapshot.hasData){
                    return Root();
                  }else {
                    return const LoginPage();
                  }
                }
            );

Consumer<LoginInfoProvider>(
          builder: (context,user,child){
              return FutureBuilder(
                  future:user.userLoginInfo ,
                  builder:(context,snapshot){
                    if(snapshot.hasData){
                      return Root();
                    }
                    return const LoginPage();
                  }
              );
            },
            )

       CarouselSlider(
                options: CarouselOptions(
                    height: 200.0,
                ),
                items: [1].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return
                    },
                  );
                }).toList(),


              )*/

