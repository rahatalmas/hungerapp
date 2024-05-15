import 'package:flutter/material.dart';
import 'package:hunger/pages/homepage.dart';

void main() {
  runApp(const MyApp());
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
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange[300],
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            title: Row(
              children: [
                Image.asset(
                  "assets/logo.png",
                  scale: 8.5,
                ),
                SizedBox(width: 10),
                Text(
                  "Hunger",
                  style: TextStyle(
                      color: Colors.brown[900],
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            actions: [
              Icon(Icons.search),
              SizedBox(
                width: 15,
              )
            ],
          ),
          drawer:Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.orange[200],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            radius: 35,
                            backgroundImage:AssetImage("assets/prettypretty.jpg"),
                          ),
                          Builder(
                            builder: (context) {
                              return IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Scaffold.of(context).closeDrawer();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 7,),
                      Text("Pretty Dey"),
                      Text("Daffodil International University"),
                    ],
                  ),
                ),
                ListTile(
                  title: const Row(
                    children: [
                      Icon(Icons.info),
                      SizedBox(width: 10,),
                      Text("About")
                    ],
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 10,),
                      Text("settings")
                    ],
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Row(
                    children: [
                      Icon(Icons.privacy_tip),
                      SizedBox(width: 10,),
                      Text("Privacy")
                    ],
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Row(
                    children: [
                      Icon(Icons.developer_board),
                      SizedBox(width: 10,),
                      Text("Developers")
                    ],
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.orange[300],
            onTap: (int index) {
              print("hello tabbar");
            },
            unselectedLabelStyle: TextStyle(color: Colors.white),
            selectedLabelStyle: TextStyle(color: Colors.white),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.brown[900],
                  ),
                  label: "home"),
              BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: "Foods"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant), label: "hotels"),
            ],
          ),
          body: const MyHomePage(title: 'Hunger'),
        )
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

