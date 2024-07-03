import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/getUser.dart';
import 'package:hunger/apiControllers/postorder.dart';
import 'package:hunger/dataModels/userModel.dart';
import 'package:hunger/dataModels/orderModel.dart';
import 'package:hunger/globalStates/userAuthProvider.dart';
import 'package:hunger/pages/components/orderCard.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
   {
  UserModel? _userData;
  int tabView = 0;
  List<Order> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final loginInfoProvider =
          Provider.of<UserAuthProvider>(context, listen: false);
      final loginInfo = loginInfoProvider.authData.token;
      if (loginInfo != null) {
        Map<String, dynamic> token = JwtDecoder.decode(loginInfo);
        UserModel user = await getUser(loginInfo, token["user_id"]);
        List<Order> orders = await fetchOrdersByUserId(user.user_id);
        setState(() {
          _userData = user;
          _orders = orders;
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

  void handleLogout() {
    final loginInfoProvider =
        Provider.of<UserAuthProvider>(context, listen: false);
    loginInfoProvider.logOut();
  }

  List<Order> getPendingOrders() {
    return _orders.where((order) => !order.orderStatus).toList();
  }

  List<Order> getNotPendingOrders() {
    return _orders.where((order) => order.orderStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    print(_orders.length);
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _userData != null
              ? SingleChildScrollView(
                  child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin:EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.orange[200],
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: _userData!.user_picture != null
                                        ? Image.network(
                                            _userData!.user_picture!,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/anya.jpg",
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          )),
                                Text(_userData!.user_name),
                                Text(_userData!.user_email),
                                InkWell(
                                  onTap: () {
                                    handleLogout();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 235, 191, 111),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Logout",
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 31, 29, 29)),
                                        ), //SizedBox(width: 3,),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text("Pending"),
                                    Text(getPendingOrders().length.toString())
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text("Received"),
                                    Text(
                                        getNotPendingOrders().length.toString())
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text("Total"),
                                    Text(_orders.length.toString())
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(  
                        color: Colors.orange[200],   
                        borderRadius: BorderRadius.circular(15)             
                      ),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [                       
                          Expanded(
                            child: InkWell(
                            onTap: (){
                              setState(() {
                                tabView = 0;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              Icon(Icons.pending),
                              Text("Pending")
                            ],),
                          ),
                          ),
                          Container(
                            height: 20,
                            width: 7,
                            decoration: BoxDecoration(  
                              borderRadius: BorderRadius.circular(5), 
                              color: Colors.orange
                            ), 
                          ),
                          Expanded(
                            child: InkWell(
                            onTap: (){
                              setState(() {
                                tabView = 1;
                              });
                            },
                            child:const Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              Icon(Icons.receipt),
                              Text("Received")
                            ],),
                          ),
                          )
                      ],
                    ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tabView == 0 ? getPendingOrders().length:getNotPendingOrders().length,
                      itemBuilder: (context, index) {
                        Order order = tabView== 0? getPendingOrders()[index]:getNotPendingOrders()[index];
                        return OrderCard(
                            foodImage: order.food.foodPicture,
                            foodName: order.food.foodName,
                            foodQuantity: order.quantity,
                            totalPrice: order.food.foodPrice.toInt(),
                            userName: order.food.foodCategory,
                            userLocation: "Date: " +
                                order.orderTime.month.toString() +
                                " | " +
                                order.orderTime.day.toString(),
                            userContact: _userData!.user_location,
                            orderId: order.orderId,
                            fetchData: fetchData,
                            orderStat: order.orderStatus);
                      },
                    )),
                  ],
                ))
              : Center(
                  child: Text('User data not available'),
                ),
    );
  }
}



/**
 *                     Row(
                      children: [Text("Pending Orders")],
                    ),

                    Container(
                        child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: getPendingOrders().length,
                      itemBuilder: (context, index) {
                        Order order = getPendingOrders()[index];
                        return OrderCard(
                            foodImage: order.food.foodPicture,
                            foodName: order.food.foodName,
                            foodQuantity: order.quantity,
                            totalPrice: order.food.foodPrice.toInt(),
                            userName: order.food.foodCategory,
                            userLocation: "Date: " +
                                order.orderTime.month.toString() +
                                " | " +
                                order.orderTime.day.toString(),
                            userContact: _userData!.user_location,
                            orderId: order.orderId,
                            fetchData: fetchData,
                            orderStat: order.orderStatus);
                      },
                    )),

                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        children: [Text("Received Orders")],
                      ),
                    ),

                    //received
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: getNotPendingOrders().length,
                        itemBuilder: (context, index) {
                          Order order = getNotPendingOrders()[index];
                          return OrderCard(
                              foodImage: order.food.foodPicture,
                              foodName: order.food.foodName,
                              foodQuantity: order.quantity,
                              totalPrice: order.food.foodPrice.toInt(),
                              userName: order.food.foodCategory,
                              userLocation:
                                  "Date: " + order.orderTime.day.toString(),
                              userContact:
                                  order.food.foodDescription.substring(0, 8),
                              orderId: order.orderId,
                              fetchData: fetchData,
                              orderStat: order.orderStatus);
                        },
                      ),
                    ),
                 
 * 
 */


/**
 * Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: getPendingOrders().length,
                        itemBuilder: (context, index) {
                          Order order = getPendingOrders()[index];
                          return Container(
                            height: 150,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.orange[200],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Image.network(
                                        order.food.foodPicture,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                    //
                                    ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order.food.foodName,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.brown[500],
                                            letterSpacing: 1),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            order.orderTime.day.toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.brown[400],
                                                letterSpacing: 0),
                                          ),
                                          Text(order.food.foodCategory)
                                        ],
                                      ),
                                      Text(
                                        order.quantity.toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.brown[400],
                                            letterSpacing: 0),
                                      ),
                                      Text(
                                        (order.quantity * order.food.foodPrice)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.brown[400],
                                            letterSpacing: 0),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          
                                        },
                                        child: Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 5),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.green[500],
                                          ),
                                          child: Text("Received"),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    
 */
