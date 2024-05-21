import 'package:flutter/material.dart';
import 'package:hunger/globalStates/LoginInfoProvider.dart';
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
           ChangeNotifierProvider(create: (context)=>CartItemProvider()),
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
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Consumer<LoginInfoProvider>(
          builder: (context,user,child){
              return FutureBuilder(
                  future:user.loginInfo ,
                  builder:(context,snapshot){
                    if(snapshot.hasData){
                      return Root();
                    }
                    return const LoginPage();
                  }
              );
            },
          )
        );
      // login?Root():LoginPage()
  }
}



/*

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

