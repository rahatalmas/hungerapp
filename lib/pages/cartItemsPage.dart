import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItems extends StatefulWidget {
  CartItems({super.key});
  @override
  State<CartItems> createState() => _CartItems();
}

class _CartItems extends State<CartItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: SingleChildScrollView(
        child: Column(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Token",
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.brown[800],
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      Text(
                        "Selected Item: 5",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.brown[800],
                            letterSpacing: 1),
                      ),
                      Text(
                        "Total Items : 7",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.brown[800],
                            letterSpacing: 1),
                      ),
                      Text(
                        "Total Price: 450",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.brown[800],
                            letterSpacing: 1),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.brown[500],
                            borderRadius: BorderRadius.circular(15),
                            //border: Border.all(width: 3,color: Colors.black)
                          ),
                          child: const Text(
                            "Place Order",
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "assets/anya.jpg",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Anya Forger",
                        style: TextStyle(
                            color: Colors.brown[800],
                            letterSpacing: 2,
                            fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.orange[200],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset("assets/head.png",
                                    height: 75,
                                    width: 75,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dal and Luchi",
                                    style: TextStyle(
                                        color: Colors.brown[700],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text("Dhaka Hotel",
                                      style: TextStyle(
                                          color: Colors.brown[700],
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13))
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange[100]),
                                child: Icon(
                                  Icons.remove,
                                  size: 25,
                                  weight: 500,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("1",
                                  style: TextStyle(
                                      color: Colors.brown[700],
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25)),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange[100]),
                                child: Icon(
                                  Icons.add,
                                  size: 25,
                                  weight: 500,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Price",
                                style: TextStyle(
                                    color: Colors.brown[700],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                              Text(
                                "85 x 1",
                                style: TextStyle(
                                    color: Colors.brown[700],
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15),
                              ),
                              Text(
                                "85",
                                style: TextStyle(
                                    color: Colors.brown[700],
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      ));
                }),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 17),
                decoration: BoxDecoration(
                  color: Colors.brown[500],
                  borderRadius: BorderRadius.circular(15),
                  //border: Border.all(width: 3,color: Colors.black)
                ),
                child: const Text(
                  "Place Order",
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),//list
          ],
        ),
      ),
    );
  }
}
