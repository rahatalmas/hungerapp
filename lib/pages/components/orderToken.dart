import 'package:flutter/material.dart';

class OrderToken extends StatelessWidget {
  OrderToken(
    {
      super.key,
      required this.userName,
      required this.userPicture,
      required this.userLocation,
      required this.totalItem,
      required this.uniqueItem,
      required this.totalPrice
    });
  // ${cartList.cartLength}
  //${cartList.totalItem()}
  // ${cartList.getTotalPrice()}
  // username
  String userName;
  String userPicture;
  String userLocation;
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
          Expanded(
            child:           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Token",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.brown[800],
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              Text(
                "Selected Item : $uniqueItem",
                style: TextStyle(
                    fontSize: 15, color: Colors.brown[800],),
              ),
              Text(
                "Total Items : $totalItem",
                style: TextStyle(
                    fontSize: 15, color: Colors.brown[800],),
              ),
              Text(
                "Total Price : $totalPrice",
                style: TextStyle(
                    fontSize: 15, color: Colors.brown[800],),
              ),
              const Text(
                "Cash On Delivery",
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 42, 70, 38),),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        
          ),
            
          Expanded(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  userPicture,
                  width: (MediaQuery.of(context).size.width*100)/100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Text(
                userName,style:TextStyle(
                fontSize: 20,fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color:Colors.brown[800]
              ),),
            ],
          ),     
          ),
          
        ],
      ),
    );
  }
}

/*
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
            
*/









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