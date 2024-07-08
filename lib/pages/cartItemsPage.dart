import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/postorder.dart';
import 'package:hunger/dataModels/userModel.dart';
import 'package:hunger/globalStates/cartItemProvider.dart';
import 'package:hunger/globalStates/userAuthProvider.dart';
import 'package:hunger/pages/components/cartItemCard.dart';
import 'package:hunger/pages/components/orderToken.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:hunger/apiControllers/getUser.dart';
import 'package:hunger/dataModels/orderModel.dart';

class CartItems extends StatefulWidget {
  const CartItems({super.key});
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
        const Center(
          child: CircularProgressIndicator(color: Colors.orange,),
        ) 
          :
        _userData == null 
          ?
          const Center(
            child:Text("No Valid User Data")
          )
          :
          SingleChildScrollView(
          child: Consumer<CartItemProvider>(
                      builder: (context, cartList, child) {
                      return Column(children: [
                              OrderToken(
                                userName: _userData!.user_name,
                                userPicture : _userData!.user_picture!,
                                userLocation: _userData!.user_location,
                                totalItem: cartList.cartLength,
                                uniqueItem: cartList.totalItem(),
                                totalPrice: cartList.getTotalPrice().toInt(),
                              ),

                             Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.list,
                                          //size: 25,
                                        ),
                                        SizedBox(width: 5,),
                                        Text("Cart Items",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.brown[900]),)
                                      ],
                                    ),
                                    InkWell(
                                      splashColor: Colors.orange[200],
                                      onTap: cartList.clearList,
                                      child:  Row(
                                        children: [
                                          Text("X ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.brown[900]),),
                                          Text("Clear List",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.brown[900]),)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5,),
                              cartList.cartLength == 0 ?
                              Container(
                                height: MediaQuery.of(context).size.width*65/100,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.orange[200],
                                  borderRadius: BorderRadius.circular(15),
                                  //border: Border.all(color: Colors.brown,width: 2)
                                ),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,   
                                    children: [
                                    Image.asset(
                                      "assets/cart.png",
                                      width: (MediaQuery.sizeOf(context).width*50)/100,
                                      height: MediaQuery.of(context).size.width*50/100,
                                      fit: BoxFit.cover,
                                      
                                    ),
                                    const Text("No Item In Cart",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 53, 30, 21)),),
                                   ],
                                  ),
                              )
                              
                              :
                              Column(children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cartList.cartLength,
                                  itemBuilder: (context, index) {
                                    return CartItemCard(
                                      foodName: cartList.cartItems[index].food_model.foodName, 
                                      foodPicture: cartList.cartItems[index].food_model.foodPicture,
                                      date: DateTime.now(), 
                                      category: cartList.cartItems[index].food_model.foodCategory, 
                                      hotelName: cartList.cartItems[index].food_model.foodProvider.hotelName, 
                                      price: cartList.cartItems[index].food_model.foodPrice.toInt(), 
                                      quantity: cartList.cartItems[index].quantity, 
                                      incQuantity: (){
                                        cartList.addQuantity(index);
                                      }, 
                                      decQuantity: (){
                                        cartList.subQuantity(index);
                                      }, 
                                      removeFromCart: ()=>{print("remove")}
                                    );
                                  }),                              
                              //order button
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
                                      deliveryLocation: _userData!.user_location,
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
                            
],)
                            ]);
                  })
                      
     
        ));
  
  }
}
