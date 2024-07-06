import 'package:flutter/material.dart';
import 'package:hunger/globalStates/foodDataProvider.dart';
import 'package:hunger/globalStates/hotelProvider.dart';
import 'package:hunger/globalStates/mealprovider.dart';
import 'package:hunger/globalStates/userAuthProvider.dart';
import 'package:hunger/rootpage.dart';
import 'package:hunger/pages/loginpage.dart';
import 'package:hunger/globalStates/cartItemProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
     MultiProvider(
         providers:[
           ChangeNotifierProvider(create: (context)=>UserAuthProvider()),
           ChangeNotifierProvider(create: (context)=>FoodListProvider()),
           ChangeNotifierProvider(create: (context)=>hotelListProvider()),
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
    //final MediaQueryData data = MediaQuery.of(context);
    final userAuth = Provider.of<UserAuthProvider>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hunger',
        theme: ThemeData(
      
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        
        home: userAuth.authData.token == null ? 
         const LoginPage()
           :
         Root(),
        );
  }
}


/*
MediaQuery(
          data: data.copyWith(textScaler: TextScaler.linear(1)),
          
         )


version 1 protection

Consumer<LoginInfoProvider>(
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

