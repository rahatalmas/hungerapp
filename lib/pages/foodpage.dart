import 'package:flutter/material.dart';
import 'package:hunger/pages/components/foodList.dart';
import 'package:hunger/pages/customOrderPage.dart';
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
                              onTap: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
                                          return CustomOrderPage();
                                      }));
                                },
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
                FoodList()
              ],
            )
          ],
        ));
  }
}