import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hunger')
    );
  }
}

//const MyHomePage(title: 'Hunger'),

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPage();
}
class _LoginPage extends State<LoginPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.orange[200],
      body:SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  //borderRadius: BorderRadius.circular(10.0),
                  //borderSide: const BorderSide(width: 15,style: BorderStyle.solid,color: Colors.lightBlue)
                ),

              ),
            )
          ],
        ),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.orange[100],
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          leading: Icon(Icons.menu),
          title: Row(
            children: [
              Image.asset("assets/logo.png",scale: 8.5,),
              SizedBox(width: 10),
              Text("Hunger",style: TextStyle(color: Colors.brown[900],fontSize: 30,fontWeight: FontWeight.bold),)
            ],
          ),
          actions: [
            Icon(Icons.search),
            SizedBox(
              width: 15,
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.orange[300],
          onTap: (int index){print("hello tabbar");},
          unselectedLabelStyle: TextStyle(color: Colors.white),
          selectedLabelStyle:  TextStyle(color: Colors.white),
          items: [
            BottomNavigationBarItem(
                icon:Icon(Icons.home,color: Colors.brown[900],),
                label: "home"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank),
                label: "Foods"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: "hotels"
            ),
          ],
        ),
        body:ListView(
          children: [
            Column(
              children: [
                Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical:10.0),
                        decoration: BoxDecoration(
                          color: Colors.orange[200],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          // border: Border.all(color: Colors.brown,width: 5)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex:2,
                                      child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Order n Relax",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.brown[700]
                                            ),
                                          ),
                                          const Text(
                                            "Foods for your ultimate hunger.",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.brown
                                            ),
                                          ),
                                          const Text(
                                            "Daily food partner",
                                            style: TextStyle(
                                                fontSize: 14.5,
                                                color: Colors.brown
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          InkWell(
                                            onTap: (){print("cutom order");},
                                            child: Container(
                                              padding: EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                color: Colors.brown[500],
                                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                                border: Border.all(width: 2,color: Colors.brown)
                                              ),
                                              child: Text(
                                                "Custom Order",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Image.asset("assets/chicken.png",scale: 1,),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Chicken Curry")
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 100,
                child:ListView.builder(
                  scrollDirection:Axis.horizontal,
                  itemBuilder: (BuildContext context,int index){
                    return Container(
                      height: 100,
                      width: 100,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.orange[200],
                      ),
                    );
                  },
                  itemCount: 5,
                ),
              ),
            ),
            Padding(
              padding:EdgeInsets.all(10),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap:true,
                crossAxisCount: 2,
                children: List.generate(6, (index) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.orange[200],
                    ),
                  );
                }),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child:ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context,int index){
                    return Container(
                      height: 140,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.orange[200],
                      ),
                    );
                  },
                  itemCount: 5,
                ),
            )
          ]
        ),
      );
  }
}

/*              CarouselSlider(
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