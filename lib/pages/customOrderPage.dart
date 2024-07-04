import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/postorder.dart';
import 'package:hunger/dataModels/cartItemModel.dart';
import 'package:hunger/dataModels/orderModel.dart';
import 'package:hunger/dataModels/user.dart';
import 'package:hunger/dataModels/userModel.dart';
import 'package:hunger/globalStates/LoginInfoProvider.dart';
import 'package:hunger/apiControllers/getUser.dart';
import 'package:hunger/globalStates/mealprovider.dart';
import 'package:hunger/globalStates/userAuthProvider.dart';
import 'package:hunger/pages/components/customorderfoodlist.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class CustomOrderPage extends StatefulWidget {
  const CustomOrderPage({super.key});
  @override
  State<CustomOrderPage> createState() => _CustomOrderPage();
}

class _CustomOrderPage extends State<CustomOrderPage> {
  bool _isLoading = true;
  DateTime selectedDate = DateTime.now();
  String? mealType = "BreakFast";
  bool showFood = false;
  UserModel? _userdata;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final loginInfoProvider =
          Provider.of<UserAuthProvider>(context, listen: false);
      final loginInfo = loginInfoProvider.authData.token;
      if (loginInfo != null) {
        Map<String, dynamic> token = JwtDecoder.decode(loginInfo);
        UserModel user = await getUser(loginInfo, token["user_id"]);
        setState(() {
          _userdata = user;
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024, DateTime.now().day),
      lastDate: DateTime(2024, DateTime.now().day + 30),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[100],
        body: _isLoading
            ? CircularProgressIndicator(
                color: Colors.orange,
              )
            : _userdata == null
                ? Center(
                    child: Text("invalid"),
                  )
                : Consumer<MealItemProvider>(
                    builder: (context, cartList, child) {
                    return SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                //dashboard
                                Container(
                                    padding: EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.orange[200],
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Meal Planner",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.brown[800])),
                                            Text(
                                                "Total ${cartList.mealItemsLength}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.brown[800])),
                                            Text(
                                                "Selected Days: ${cartList.numOfUniqueDays()}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.brown[800])),
                                            Text(
                                                "Total Coast: ${cartList.getTotalPrice()}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.brown[800]))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.network(
                                              _userdata!.user_picture!,
                                              width: 75,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                            Text(
                                                "Budget ${_userdata!.user_budget}")
                                          ],
                                        )
                                      ],
                                    )),

                                const SizedBox(
                                  height: 15,
                                ),

                                //picker
                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Color.fromARGB(255, 45, 25, 25),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.orange[200]),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            InkWell(
                                              child: Row(
                                                children: [
                                                  Icon(Icons.calendar_today),
                                                  Text(
                                                      "Date: ${selectedDate.day.toString()}"),
                                                ],
                                              ),
                                              onTap: () => _selectDate(context),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Row(
                                              children: [
                                                DropdownButton(
                                                  value: mealType,
                                                  items: <String>[
                                                    'BreakFast',
                                                    'Lunch',
                                                    'Dinner',
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                            String>(
                                                        value: value,
                                                        child: Text(value));
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(
                                                        () => mealType = value);
                                                  },
                                                  underline: SizedBox(
                                                    height: 0,
                                                    width: 0,
                                                  ),
                                                  alignment: Alignment.center,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.brown[800]),
                                                  dropdownColor:
                                                      Colors.orange[100],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        InkWell(
                                          child: Row(
                                            children: [
                                              Icon(Icons.lunch_dining),
                                              Text("Select Food"),
                                            ],
                                          ),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    backgroundColor:
                                                        Colors.orange[200],
                                                    child: CustomOrderFoodsList(
                                                        mealType: mealType,
                                                        date: selectedDate,
                                                        userId: 1),
                                                  );
                                                });
                                          },
                                        )
                                      ],
                                    )),

                                const SizedBox(
                                  height: 10,
                                ),

                                //items
                                Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2 -
                                            30,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.orange[200],
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListView.builder(
                                        itemCount: cartList.mealItemsLength,
                                        itemBuilder: (context, index) {
                                          //meal card
                                          return Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: EdgeInsets.all(10),
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 0),
                                              decoration: BoxDecoration(
                                                  color: Colors.orange[300],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Image.network(
                                                            '${cartList.mealItems[index].food_model.foodPicture}',
                                                            height: 70,
                                                            width: 100,
                                                            fit: BoxFit.cover,
                                                            alignment: Alignment
                                                                .center),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            cartList
                                                                .mealItems[
                                                                    index]
                                                                .food_model
                                                                .foodName,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .brown[700],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15),
                                                          ),
                                                          Text(
                                                              cartList
                                                                  .mealItems[
                                                                      index]
                                                                  .food_model
                                                                  .foodProvider
                                                                  .hotelName,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .brown[
                                                                      700],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      13)),
                                                          Text("MealType: ${cartList.mealItems[index].food_model.foodCategory}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .brown[
                                                                      700],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      13)),
                                                          Text("Date: ${cartList.mealItems[index].date.day.toString()}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .brown[
                                                                      700],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 13))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          cartList.subQuantity(
                                                              index);
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Colors
                                                                  .orange[100]),
                                                          child: Icon(
                                                            Icons.remove,
                                                            size: 20,
                                                            weight: 500,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                          '${cartList.mealItems[index].quantity}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .brown[700],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 20)),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          cartList.addQuantity(
                                                              index);
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Colors
                                                                  .orange[100]),
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 20,
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
                                                            color: Colors
                                                                .brown[700],
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        '${cartList.mealItems[index].food_model.foodPrice}x${cartList.mealItems[index].quantity}',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .brown[700],
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        '${cartList.mealItems[index].food_model.foodPrice * cartList.mealItems[index].quantity}',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .brown[700],
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ));
                                        })),

                                //buttons
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          for (int i = 0;i < cartList.mealItems.length;i++) {
                                            OrderPost order = OrderPost(
                                              orderedUserId: _userdata!.user_id,
                                              orderedFoodId: cartList.mealItems[i].food_model.foodId,
                                              quantity: cartList.mealItems[i].quantity,
                                              time: cartList.mealItems[i].date,
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
                                          cartList.resetList();
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(15),
                                            margin: EdgeInsets.fromLTRB(0, 10, 5, 0),
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:BorderRadius.circular(10)),
                                            child: const Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  "Order Proceed",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          cartList.resetList();
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(15),
                                            margin: EdgeInsets.fromLTRB(
                                                5, 10, 0, 0),
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  "Reset All",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )));
                  }));
  }
}
