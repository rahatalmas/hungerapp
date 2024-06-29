import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/getfoods.dart';
import 'package:hunger/dataModels/cartItemModel.dart';
import 'package:hunger/dataModels/foodModel.dart';
import 'package:hunger/globalStates/mealprovider.dart';
import 'package:provider/provider.dart';

class CustomOrderFoodsList extends StatefulWidget {
  CustomOrderFoodsList({super.key, this.mealType,required this.date,required this.userId});
  String? mealType;
  DateTime date;
  int userId;

  @override
  State<CustomOrderFoodsList> createState() => _CustomOrderFoodsList();
}

class _CustomOrderFoodsList extends State<CustomOrderFoodsList> {
  late Future<List<FoodModel>> CustomOrderFoodsList;

  @override
  void initState() {
    super.initState();
    CustomOrderFoodsList = getFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.orange[200]),
        child: FutureBuilder(
          future: CustomOrderFoodsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: MediaQuery.of(context).size.height - 100,
                width: MediaQuery.of(context).size.width,
                //padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(15)),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Consumer<MealItemProvider>(builder: (context,cartItem,child){
                          return InkWell(
                        onTap: () {
                          CartItemModel item = CartItemModel(
                              food_model: snapshot.data![index],
                              userId: 1,
                              quantity: 1,
                              date: widget.date);
                              cartItem.addCartItem(item);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 105,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.orange[200],
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 59, 37, 33),
                                  width: 2)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    snapshot.data![index].foodPicture,
                                    width: MediaQuery.of(context).size.width,
                                    height: 95,
                                    fit: BoxFit.cover,
                                    
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(snapshot.data![index].foodName),
                                      Text(snapshot
                                          .data![index].foodProvider.hotelName),
                                      Text(snapshot.data![index].foodPrice
                                          .toString())
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                      },
                      
                      );
                    }),
              );
            }
            /* else if(snapshot.hasError) {
              return Text('${snapshot.error}');
            }*/
            return Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/avo.gif",
                    width: 100,
                  ),
                  Text(
                    "Food is Loading...",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            );
          },
        ));
  }
}
