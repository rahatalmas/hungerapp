import 'package:flutter/material.dart';

class OrderToken extends StatelessWidget {
  OrderToken({super.key,required this.userName,required this.totalItem, required this.uniqueItem, required this.totalPrice});
  // ${cartList.cartLength}
  //${cartList.totalItem()}
  // ${cartList.getTotalPrice()}
  // username
  String userName;
  int totalItem;
  int uniqueItem;
  int totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.orange[200], borderRadius: BorderRadius.circular(10)),
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
                "Selected Item: ${uniqueItem}",
                style: TextStyle(
                    fontSize: 17, color: Colors.brown[800], letterSpacing: 1),
              ),
              Text(
                "Total Items : ${totalItem}",
                style: TextStyle(
                    fontSize: 17, color: Colors.brown[800], letterSpacing: 1),
              ),
              Text(
                "Total Price:${totalPrice}",
                style: TextStyle(
                    fontSize: 17, color: Colors.brown[800], letterSpacing: 1),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  print("order to proceed");
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.brown[500],
                    borderRadius: BorderRadius.circular(15),
                    //border: Border.all(width: 3,color: Colors.black)
                  ),
                  child: const Text(
                    "Place Order",
                    style: TextStyle(
                        color: Colors.white, letterSpacing: 2, fontSize: 16),
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
              Text(userName)
            ],
          )
        ],
      ),
    );
  }
}







/**
 * Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.orange[200],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          "Selected Item: ${cartList.cartLength}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.brown[800],
                                              letterSpacing: 1),
                                        ),
                                        Text(
                                          "Total Items : ${cartList.totalItem()}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.brown[800],
                                              letterSpacing: 1),
                                        ),
                                        Text(
                                          "Total Price: ${cartList.getTotalPrice()}",
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
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                        Text(snapshot.data!.user_name)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                             
 */