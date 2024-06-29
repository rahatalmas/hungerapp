import 'package:flutter/material.dart';
import 'package:hunger/globalStates/LoginInfoProvider.dart';
import 'package:hunger/apiControllers/getUser.dart';
import 'package:hunger/globalStates/mealprovider.dart';
import 'package:hunger/pages/components/customorderfoodlist.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class CustomOrderPage extends StatefulWidget {
  const CustomOrderPage({super.key});
  @override
  State<CustomOrderPage> createState() => _CustomOrderPage();
}

class _CustomOrderPage extends State<CustomOrderPage> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String? mealType = "BreakFast";

  bool showFood = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[100],
        body: Consumer<LoginInfoProvider>(builder: (context, user, child) {
          return FutureBuilder(
              future: user.loginInfo,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> token =
                      JwtDecoder.decode(snapshot.data!.accessToken);
                  return FutureBuilder(
                      future:
                          getUser(snapshot.data!.accessToken, token["user_id"]),
                      builder: (context, snapshot) {
                        print(snapshot.hasData);
                        if (snapshot.hasData) {
                          return Consumer<MealItemProvider>(
                              builder: (context, item, child) {
                            return SingleChildScrollView(
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: Colors.orange[200],
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Row(
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
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .brown[800])),
                                                    Text(
                                                        "Total ${item.mealItemsLength}",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .brown[800])),
                                                    Text(
                                                        "Selected Days: ${item.numOfUniqueDays()}",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .brown[800])),
                                                    Text(
                                                        "Total Coast: ${item.getTotalPrice()}",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .brown[800]))
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Image.asset(
                                                      "assets/pizza.png",
                                                      width: 75,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Text("Budget ${snapshot.data!.user_budget}")
                                                  ],
                                                )
                                              ],
                                            )),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 45, 25, 25),
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.orange[200]),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons
                                                              .calendar_today),
                                                          Text(
                                                              "Date: ${selectedDate.day.toString()}"),
                                                        ],
                                                      ),
                                                      onTap: () =>
                                                          _selectDate(context),
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
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: Text(
                                                                    value));
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            setState(() =>
                                                                mealType =
                                                                    value);
                                                          },
                                                          underline: SizedBox(
                                                            height: 0,
                                                            width: 0,
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .brown[800]),
                                                          dropdownColor: Colors
                                                              .orange[100],
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
                                                        builder: (BuildContext
                                                            context) {
                                                          return Dialog(
                                                            backgroundColor:
                                                                Colors.orange[
                                                                    200],
                                                            child:
                                                                CustomOrderFoodsList(
                                                              mealType:
                                                                  mealType,
                                                              date:
                                                                  selectedDate,
                                                              userId:snapshot.data!.user_id
                                                            ),
                                                          );
                                                        });
                                                  },
                                                )
                                              ],
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        //items
                                        Container(
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2 -
                                              30,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Colors.orange[200],
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Consumer<MealItemProvider>(
                                            builder:
                                                (context, cartList, child) {
                                              return ListView.builder(
                                                  itemCount:
                                                      cartList.mealItemsLength,
                                                  itemBuilder:
                                                      (context, index) {
                                                    //meal card
                                                    return Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5,
                                                                horizontal: 0),
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .orange[300],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                                          .circular(
                                                                              15),
                                                                  child: Image.network(
                                                                      '${cartList.mealItems[index].food_model.foodPicture}',
                                                                      height:
                                                                          70,
                                                                      width:
                                                                          100,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      alignment:
                                                                          Alignment
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
                                                                          color: Colors.brown[
                                                                              700],
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    Text(
                                                                        cartList
                                                                            .mealItems[
                                                                                index]
                                                                            .food_model
                                                                            .foodProvider
                                                                            .hotelName,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.brown[700],
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 13)),
                                                                    Text(
                                                                        "MealType: ${cartList.mealItems[index].category}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.brown[700],
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 13)),
                                                                    Text(
                                                                        "Date: ${cartList.mealItems[index].date.day.toString()}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.brown[700],
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
                                                                    cartList
                                                                        .subQuantity(
                                                                            index);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        color: Colors
                                                                            .orange[100]),
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      size: 20,
                                                                      weight:
                                                                          500,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                    '${cartList.mealItems[index].quantity}',
                                                                    style: TextStyle(
                                                                        color: Colors.brown[
                                                                            700],
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontSize:
                                                                            20)),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    cartList
                                                                        .addQuantity(
                                                                            index);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        color: Colors
                                                                            .orange[100]),
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      size: 20,
                                                                      weight:
                                                                          500,
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
                                                                              .brown[
                                                                          700],
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                Text(
                                                                  '${cartList.mealItems[index].food_model.foodPrice}x${cartList.mealItems[index].quantity}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .brown[
                                                                          700],
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                Text(
                                                                  '${cartList.mealItems[index].food_model.foodPrice * cartList.mealItems[index].quantity}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .brown[
                                                                          700],
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ));
                                                  });
                                            },
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(15),
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 10, 5, 0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  item.resetList();
                                                },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(15),
                                                    margin: EdgeInsets.fromLTRB(
                                                        5, 10, 0, 0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )));
                          });
                        } else {
                          return Text("no data");
                        }
                      });
                } else {
                  return Text("No accesstoken");
                }
              });
        }));
  }
}
