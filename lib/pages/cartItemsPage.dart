import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/postorder.dart';
import 'package:hunger/globalStates/LoginInfoProvider.dart';
import 'package:hunger/globalStates/cartItemProvider.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:hunger/apiControllers/getUser.dart';
import 'package:hunger/dataModels/orderModel.dart';

class CartItems extends StatefulWidget {
  CartItems({super.key});
  @override
  State<CartItems> createState() => _CartItems();
}

class _CartItems extends State<CartItems> {
  int? itemQuantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: SingleChildScrollView(
        child: Consumer<CartItemProvider>(builder: (context, cartList, child) {
          return Column(
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
                        Consumer<LoginInfoProvider>(
                            builder: (context, user, child) {
                          return FutureBuilder(
                              future: user.loginInfo,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Map<String, dynamic> token =
                                      JwtDecoder.decode(
                                          snapshot.data!.accessToken);
                                  return FutureBuilder(
                                      future: getUser(
                                          snapshot.data!.accessToken,
                                          token["user_id"]),
                                      builder: (context, snapshot) {
                                        print(snapshot.hasData);
                                        if (snapshot.hasData) {
                                          return Text(snapshot.data!.user_name);
                                        }
                                        return Text("Invalid");
                                      });
                                }
                                return Text("Invalid");
                              });
                        })
                      ],
                    )
                  ],
                ),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cartList.cartLength,
                  itemBuilder: (context, index) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.orange[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                      '${cartList.cartItems[index].food_model.foodPicture}',
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
                                      cartList
                                          .cartItems[index].food_model.foodName,
                                      style: TextStyle(
                                          color: Colors.brown[700],
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    Text(
                                        cartList.cartItems[index].food_model
                                            .foodProvider.hotelName,
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
                                InkWell(
                                  onTap: () {
                                    cartList.subQuantity(index);
                                  },
                                  child: Container(
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
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('${cartList.cartItems[index].quantity}',
                                    style: TextStyle(
                                        color: Colors.brown[700],
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25)),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    cartList.addQuantity(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.orange[100]),
                                    child: Icon(
                                      Icons.add,
                                      size: 25,
                                      weight: 500,
                                    ),
                                  ),
                                ),
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
                                  '${cartList.cartItems[index].food_model.foodPrice}x${cartList.cartItems[index].quantity}',
                                  style: TextStyle(
                                      color: Colors.brown[700],
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                                Text(
                                  '${cartList.cartItems[index].food_model.foodPrice * cartList.cartItems[index].quantity}',
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 17),
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
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  for(int i=0;i<cartList.cartLength;i++){
                     OrderPost order = OrderPost(                   
                      orderedUserId: cartList.cartItems[i].userId, 
                      orderedFoodId: cartList.cartItems[i].food_model.foodId, 
                      quantity: cartList.cartItems[i].quantity,
                      time: cartList.cartItems[i].date
                      );
                      postOrder(order);
                  }
                },
              ), //list
            ],
          );
        }),
      ),
    );
  }
}
