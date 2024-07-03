import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/postorder.dart';
import 'package:hunger/dataModels/userModel.dart';
import 'package:hunger/globalStates/LoginInfoProvider.dart';
import 'package:hunger/globalStates/cartItemProvider.dart';
import 'package:hunger/globalStates/userAuthProvider.dart';
import 'package:hunger/pages/components/orderToken.dart';
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
  UserModel? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  
  Future<void> fetchData() async {
    try {
      final loginInfoProvider = Provider.of<UserAuthProvider>(context, listen: false);
      final loginInfo = loginInfoProvider.authData.token;
      if (loginInfo != null) {
        Map<String, dynamic> token = JwtDecoder.decode(loginInfo);
        UserModel user = await getUser(loginInfo, token["user_id"]);
        setState(() {
          _userData = user;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[100],
        body: _isLoading
          ?
        Center(
          child: CircularProgressIndicator(color: Colors.orange,),
        ) 
          :
        _userData == null 
          ?
          Center(
            child:Text("No Valid User Data")
          )
          :
          SingleChildScrollView(
          child: Consumer<CartItemProvider>(
                      builder: (context, cartList, child) {
                      return Column(children: [
                              OrderToken(
                                userName: _userData!.user_name,
                                totalItem: cartList.cartLength,
                                uniqueItem: cartList.totalItem(),
                                totalPrice: cartList.getTotalPrice().toInt(),
                              ),

                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cartList.cartLength,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.orange[200],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.network(
                                                      '${cartList.cartItems[index].food_model.foodPicture}',
                                                      height: 75,
                                                      width: 75,
                                                      fit: BoxFit.cover,
                                                      alignment:
                                                          Alignment.center),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      cartList.cartItems[index]
                                                          .food_model.foodName,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.brown[700],
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                        cartList
                                                            .cartItems[index]
                                                            .food_model
                                                            .foodProvider
                                                            .hotelName,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .brown[700],
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Colors.orange[100]),
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
                                                Text(
                                                    '${cartList.cartItems[index].quantity}',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.brown[700],
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Colors.orange[100]),
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  '${cartList.cartItems[index].food_model.foodPrice}x${cartList.cartItems[index].quantity}',
                                                  style: TextStyle(
                                                      color: Colors.brown[700],
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  '${cartList.cartItems[index].food_model.foodPrice * cartList.cartItems[index].quantity}',
                                                  style: TextStyle(
                                                      color: Colors.brown[700],
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 17),
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
                                onTap: () async {
                        
                                  for (int i = 0;
                                      i < cartList.cartItems.length;
                                      i++) {
                                    OrderPost order = OrderPost(
                                      orderedUserId: _userData!.user_id,
                                      orderedFoodId: cartList
                                          .cartItems[i].food_model.foodId,
                                      quantity: cartList.cartItems[i].quantity,
                                      time: cartList.cartItems[i].date,
                                    );

                                    try {
                                      await postOrder(order);
                                      print(
                                          'Order placed successfully for item $i');
                                    } catch (e) {
                                      print(
                                          'Failed to place order for item $i: $e');
                                    }
                                  }
                                  cartList.clearList();
                                },
                              )
                            ]);
                  })
                      
                
        ));
  
  }
}
