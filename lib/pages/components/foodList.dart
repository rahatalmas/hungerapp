import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/getfoods.dart';
import 'package:hunger/dataModels/cartItemModel.dart';
import 'package:hunger/dataModels/foodModel.dart';
import 'package:hunger/globalStates/cartItemProvider.dart';
import 'package:hunger/globalStates/foodDataProvider.dart';
import 'package:hunger/pages/foodDetails.dart';
import 'package:provider/provider.dart';

List<int> l = [1,3,4];


class FoodList extends StatefulWidget {
  const FoodList({super.key});
  @override
  State<FoodList> createState() => _FoodList();
}

class _FoodList extends State<FoodList> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    foodListGetter();
    //foodList = getFoods();
  }

  foodListGetter() async{
    _isLoading = true;
    final foodDataProvider = Provider.of<FoodListProvider>(context,listen:false);
    foodDataProvider.getAllFoods();
    setState((){
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final foodDataProvider = Provider.of<FoodListProvider>(context,listen:false);
    return _isLoading ? 
    Center(child: CircularProgressIndicator(color: Colors.orange,),)
    :
    Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(10),
        //decoration: BoxDecoration(color: Colors.orange[200]),
        child:
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.5,
                children: foodDataProvider.allFoods.map((food){
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
                                              
                                                  food.foodName
                                              ,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Colors.brown[700]),
                                            ),
                                            Text(
                                              food.foodProvider.hotelName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  color: Colors.brown[700]),
                                            ),
                                            Text(
                                              'Price: ${food.foodPrice}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Colors.brown[700]),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Consumer<CartItemProvider>(
                                                builder: (context,cartList,child){
                                                  return InkWell(
                                                    child: Container(
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                            color: Colors.brown[700],
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                        child:const Row(
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
                                                          food_model: food,
                                                        
                                                          quantity: 1,
                                                          date: DateTime.now(),
                                                        );
                                                      cartList.addCartItem(item);
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text("${food.foodName} Added To Cart",style: TextStyle(color: Colors.white),),
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
                                    child:Image.network(food.foodPicture,
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
                            builder: (context)=>FoodDetails(data: food,)
                        )
                      );
                    },
                  );
                }).toList()
              )
            
           /* else if(snapshot.hasError) {
              return Text('${snapshot.error}');
            }*/

    );
  
  }
}