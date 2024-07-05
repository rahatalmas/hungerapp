

import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/getfoods.dart';
import 'package:hunger/dataModels/foodModel.dart';
import 'package:hunger/dataModels/userModel.dart';
import 'package:hunger/globalStates/foodDataProvider.dart';
import 'package:hunger/globalStates/userAuthProvider.dart';
import 'package:hunger/pages/foodDetails.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

//List<int> l = [1,2,3];

class FoodList extends StatefulWidget {
  const FoodList({super.key});
  @override
  State<FoodList> createState() => _FoodList();
}

class _FoodList extends State<FoodList> {
  @override
  void initState(){
     super.initState();
     Provider.of<FoodDataProvider>(context,listen: false).allFoods();
  }

  @override
  Widget build(BuildContext context) {

    final foodProvider =  Provider.of<FoodDataProvider>(context,listen: false);

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(10),
        //decoration: BoxDecoration(color: Colors.orange[200]),
        child:GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.5,
                children: foodProvider.filterHotel("Ghibli Food Shop").map((food){
                  return Text(food.foodName);
                }).toList()
              )
    );
  }
}


/**
 *  List.generate(snapshot.data!.length, (index) {
                  return InkWell(
                    child:Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(color: Colors.orange[100]),
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
                                        width: MediaQuery.of(context).size.width,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.orange[200],
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${
                                                  snapshot.data![index].foodName
                                              }',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Colors.brown[700]),
                                            ),
                                            Text(
                                              '${snapshot.data![index].foodProvider.hotelName}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  color: Colors.brown[700]),
                                            ),
                                            Text(
                                              'Price: ${snapshot.data![index].foodPrice}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.brown[700]),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Consumer<CartItemProvider>(
                                                builder: (context,cartList,child){
                                                  return InkWell(
                                                    child: Container(
                                                        padding: EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                            color: Colors.brown[700],
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Add To Cart",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w400,
                                                                  fontSize: 15,
                                                                  color: Colors.white),
                                                            ),
                                                            Icon(
                                                              Icons.add_shopping_cart,
                                                              color: Colors.white,
                                                            )
                                                          ],
                                                        )),
                                                    onTap: (){
                                                      print('add to cart');
                                                      CartItemModel item = CartItemModel(
                                                          food_model: snapshot.data![index],
                                                        
                                                          quantity: 1,
                                                          date: DateTime.now(),
                                                        );
                                                      cartList.addCartItem(item);
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text("${snapshot.data![index].foodName} Added To Cart",style: TextStyle(color: Colors.white),),
                                                          backgroundColor: Colors.brown[800],
                                                          duration: Duration.zero,
                                                        )
                                                        );
                                                    },
                                                  );
                                                }
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: -70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child:Image.network(snapshot.data![index].foodPicture,
                                      width: 140, height: 140,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=>FoodDetails(data: snapshot.data![index],)
                        )
                      );
                    },
                  );
                }).reversed.toList(),
              
 * 
 * 
 */