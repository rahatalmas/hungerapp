import 'package:flutter/material.dart';
import 'package:hunger/pages/customOrderPage.dart';
import 'package:hunger/apiControllers/getfoods.dart';
import 'package:hunger/dataModels/cartItemModel.dart';
import 'package:hunger/dataModels/foodModel.dart';
import 'package:hunger/globalStates/cartItemProvider.dart';
import 'package:hunger/globalStates/foodDataProvider.dart';
import 'package:hunger/pages/foodDetails.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});
  @override
  State<FoodPage> createState() => _FoodPage();
}

class _FoodPage extends State<FoodPage> {
  String categoryFilterValue = "All Foods";
  String hotelFilterValue = "All Hotel";

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    foodListGetter();
  }

  foodListGetter() async {
    _isLoading = true;
    final foodDataProvider =
        Provider.of<FoodListProvider>(context, listen: false);
    foodDataProvider.loadAllFoods();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final foodDataProvider =
        Provider.of<FoodListProvider>(context, listen: false);

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
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
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
                /*
                DropdownMenu(
                    initialSelection: "All Foods",
                    dropdownMenuEntries: <String>[
                      "All Foods",
                      "BreakFast",
                      "Lunch",
                      "Dinner"
                    ].map<DropdownMenuEntry<String>>((String category) {
                      return DropdownMenuEntry<String>(
                        value: category,
                        label: category,
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all((EdgeInsets.all(10))),
                          
                        
                        )
                      );
                    }).toList(),
                    
                    width: MediaQuery.of(context).size.width*30/100,
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                  ),*/
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Foods",
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
                          InkWell(
                            onTap: (){
                              foodDataProvider.filterByCategory("lunch");
                            },
                             child: Text(
                            "Lunch",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.brown[700],
                                fontWeight: FontWeight.w600),
                          ),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          Icon(Icons.arrow_drop_down_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "All Hotel",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.brown[700],
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          Icon(Icons.arrow_drop_down_outlined),
                        ],
                      )
                    ],
                  ),
                ),
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding: EdgeInsets.all(10),
                        //decoration: BoxDecoration(color: Colors.orange[200]),
                        child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.5,
                            children: foodDataProvider.allFoods.map((food) {
                              return InkWell(
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.orange[100]),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.center,
                                        children: [
                                          Flex(
                                            direction: Axis.vertical,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(15),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Colors.orange[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        food.foodName,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 20,
                                                            color: Colors
                                                                .brown[700]),
                                                      ),
                                                      Text(
                                                        food.foodProvider
                                                            .hotelName,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 15,
                                                            color: Colors
                                                                .brown[700]),
                                                      ),
                                                      Text(
                                                        'Price: ${food.foodPrice}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 20,
                                                            color: Colors
                                                                .brown[700]),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Consumer<
                                                              CartItemProvider>(
                                                          builder: (context,
                                                              cartList, child) {
                                                        return InkWell(
                                                          child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                          .brown[
                                                                      700],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Add To Cart",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .add_shopping_cart,
                                                                    color: Colors
                                                                        .white,
                                                                  )
                                                                ],
                                                              )),
                                                          onTap: () {
                                                            print(
                                                                'add to cart');
                                                            CartItemModel item =
                                                                CartItemModel(
                                                              food_model: food,
                                                              quantity: 1,
                                                              date: DateTime
                                                                  .now(),
                                                            );
                                                            cartList
                                                                .addCartItem(
                                                                    item);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                "${food.foodName} Added To Cart",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.brown[
                                                                      800],
                                                              duration:
                                                                  Duration.zero,
                                                            ));
                                                          },
                                                        );
                                                      }),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            top: -70,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.network(
                                                food.foodPicture,
                                                width: 140,
                                                height: 140,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FoodDetails(
                                                data: food,
                                              )));
                                },
                              );
                            }).toList())

                        /* else if(snapshot.hasError) {
              return Text('${snapshot.error}');
            }*/

                        )
              ],
            )
          ],
        ));
  }
}
