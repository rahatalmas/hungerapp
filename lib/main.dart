import 'package:flutter/material.dart';
import 'package:hunger/rootpage.dart';
import 'package:hunger/pages/loginpage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    bool login = true;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: login?Root():LoginPage()
    );
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

