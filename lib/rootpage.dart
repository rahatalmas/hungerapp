import 'package:flutter/material.dart';
import 'package:hunger/pages/homepage.dart';
import 'package:hunger/pages/foodpage.dart';
import 'package:hunger/pages/cartItemsPage.dart';
import 'package:hunger/pages/profilePage.dart';

class Root extends StatefulWidget {
  Root({super.key});
  @override
  State<Root> createState() => _Root();
}

class _Root extends State<Root> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const MyHomePage(title: 'Hunger'),
    const FoodPage(),
    Text(
      'yo',
    ),
    CartItems(),
    ProfilePage(),
  ];
  changeIndex(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(width: 10),
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
      drawer: Drawer(
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
                        backgroundImage: AssetImage("assets/anya.jpg"),
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
                  SizedBox(
                    height: 7,
                  ),
                  Text("Pretty Dey"),
                  Text("Daffodil International University"),
                ],
              ),
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.info),
                  SizedBox(
                    width: 10,
                  ),
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
                  SizedBox(
                    width: 10,
                  ),
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
                  SizedBox(
                    width: 10,
                  ),
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
                  SizedBox(
                    width: 10,
                  ),
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
        selectedLabelStyle: TextStyle(
          color: Colors.brown
        ),
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.orange[300],
              icon: Icon(Icons.home),
              label: "Home"),
          BottomNavigationBarItem(
              backgroundColor: Colors.orange[300],
              icon: Icon(Icons.food_bank),
              label: "Foods"),
          BottomNavigationBarItem(
              backgroundColor: Colors.orange[300],
              icon: Icon(Icons.dashboard_customize_outlined), label: "custom"),
          BottomNavigationBarItem(
              backgroundColor: Colors.orange[300],
              icon: Icon(Icons.shopping_cart), label: "Basket"),
          BottomNavigationBarItem(
              backgroundColor: Colors.orange[300],
              icon: Icon(Icons.person), label: "profile")
        ],
        selectedItemColor: Colors.brown[900],
        unselectedItemColor: Colors.brown[500],
        backgroundColor: Colors.purple,
        currentIndex: _selectedIndex,
        onTap: changeIndex,
      ),
      body: _widgetOptions[_selectedIndex]
    );
  }
}
