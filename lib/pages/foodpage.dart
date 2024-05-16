import 'package:flutter/material.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});
  @override
  State<FoodPage> createState() => _FoodPage();
}

class _FoodPage extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[100],
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.orange[200],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Food Happy Life",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.brown[800]),
                            ),
                            Text(
                              "Food Order N Delivery Solution",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.brown[800]),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.brown[500],
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Text(
                                  "Try Custom Order",
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 2,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        "assets/kikki.png",
                        width: 110,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "All Foods",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.brown[700],
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.restaurant_menu_outlined)
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Filter",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.brown[700],
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.arrow_drop_down_outlined),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.all(10),
                    //decoration: BoxDecoration(color: Colors.orange[200]),
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.7,
                      children: List.generate(10, (index) {
                        return Column(
                          children: [
                            Expanded(
                              flex:1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange[100]
                                ),
                              ),
                            ),
                            Expanded(
                              flex:3,
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                  Flex(direction: Axis.vertical
                                      ,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding:EdgeInsets.all(15),
                                          width:MediaQuery.of(context).size.width,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.orange[200],
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text("Dal And Luchi",style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 22,
                                                  color: Colors.brown[700]
                                              ),),
                                              Text("Price: 85 Tk",style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.brown[700]
                                              ),),
                                              SizedBox(height: 10,),
                                              InkWell(
                                                child: Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        color: Colors.brown[700],
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("Add To Cart",style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 18,
                                                            color: Colors.white
                                                        ),),
                                                        Icon(Icons.add_shopping_cart,color: Colors.white,)
                                                      ],
                                                    )
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: -90,
                                    child:Image.asset("assets/head.png",width: 170,height:170),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ))
              ],
            )
          ],
        ));
  }
}
