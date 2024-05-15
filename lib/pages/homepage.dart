import 'package:flutter/material.dart';
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
      body: ListView(children: [
        Column(
          children: [
            Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
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
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Order n Relax",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown[700]),
                                  ),
                                  const Text(
                                    "Foods for your ultimate hunger.",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.brown),
                                  ),
                                  const Text(
                                    "Daily food partner",
                                    style: TextStyle(
                                        fontSize: 14.5, color: Colors.brown),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.brown[500],
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: const Text("Custom Order",style: TextStyle(
                                          color: Colors.white,letterSpacing: 2,
                                          fontSize: 20
                                      ),),
                                    ),
                                  ),
                                ],
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/chicken.png",
                                    scale: 1,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Chicken Curry")
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Row(
              children: [
                Icon(
                  Icons.restaurant_menu,
                  color: Colors.brown[700],
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Menu",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.brown[700],
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1),
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.orange[200],
                    ),
                    child: Column(
                      //alignment: AlignmentDirectional.topCenter,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/avo.gif",
                          scale: 6,
                        ),
                        Text(
                          "Curry",
                          style: TextStyle(
                              color: Colors.brown[700],
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1),
                        )
                      ],
                    ));
              },
              itemCount: 5,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  color: Colors.brown[700],
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Featured",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.brown[700],
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1),
                ),
              ],
            )),
        //swipable stack
        Padding(
            padding: EdgeInsets.all(15),
            child: SizedBox(
              child: Stack(
                  children:List.generate(5, (index) {
                    final cardOffset = index * 7.0;
                    final cardOffsetX = index * 1.0;
                    final cardScale = 1 - (index / 5.0);
                    return Transform.translate(
                      offset: Offset(cardOffsetX,cardOffset),
                      child: Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width-33,
                          decoration: BoxDecoration(
                              color: Colors.orange[200],
                              border: Border.all(width: 2,color:Colors.black12),
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Column(
                              children:[
                                Image.asset("assets/dal-paratha.png",width:MediaQuery.of(context).size.width,height: 230,fit:BoxFit.cover,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dal Parata ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                        letterSpacing: 1.5,
                                        color: Colors.brown[700],
                                      ),
                                    ),
                                    const Text(
                                      "Healthy breakfast in your table.",
                                      style: TextStyle(
                                          color: Colors.brown,
                                          letterSpacing: 2,
                                          fontSize: 20
                                      ),
                                    ),
                                    const Text(
                                      "Price: 85 Tk",
                                      style: TextStyle(
                                          color: Colors.brown,
                                          letterSpacing: 2,
                                          fontSize: 20
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.brown[500],
                                                borderRadius: BorderRadius.circular(15)
                                            ),
                                            child: const Text("Order Now",style: TextStyle(
                                                color: Colors.white,letterSpacing: 2,
                                                fontSize: 20
                                            ),),
                                          ),
                                        ),
                                        InkWell(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[800],
                                                borderRadius: BorderRadius.circular(15)
                                            ),
                                            child: const Icon(Icons.add_shopping_cart,color: Colors.white,),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ]
                          )
                      ),
                    );
                  }).reversed.toList()
              ),
            )),
        const SizedBox(height: 30,),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  color: Colors.brown[700],
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Hotels",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.brown[700],
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                //height: 150,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.orange[200],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child:ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset("assets/shopimage.png",width:MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                      )
                      //
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Burger Shop",style: TextStyle(
                              fontSize: 25,
                              color: Colors.brown[500],
                              letterSpacing: 1
                          ),),
                          Text("Experience The Ultimate taste of Burger",style: TextStyle(
                              fontSize: 15,
                              color: Colors.brown[400],
                              letterSpacing: 0
                          ),),
                          Text("Ashulia Khagan",style: TextStyle(
                              fontSize: 14,
                              color: Colors.brown[400],
                              letterSpacing: 0
                          ),)
                       ],
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: 3,
          ),
        )
      ]),
    );
  }
}