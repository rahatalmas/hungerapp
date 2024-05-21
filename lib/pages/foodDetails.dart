import 'package:flutter/material.dart';
import 'package:hunger/dataModels/cartItemModel.dart';
import 'package:hunger/dataModels/foodModel.dart';

class FoodDetails extends StatefulWidget {
  FoodDetails({super.key,required this.data});
  FoodModel data;
  @override
  State<FoodDetails> createState() => _FoodDetails();
}

class _FoodDetails extends State<FoodDetails> {
  int itemCount = 1;

  void add()
  {
    setState((){
      itemCount++;
    });
  }
  void remove()
  {
    setState((){
      if(itemCount>1){
        itemCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=>Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(widget.data.foodName),
        actions: [
          Icon(Icons.add_shopping_cart),
          SizedBox(width: 10,),
        ],
        backgroundColor: Colors.orange[200],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.network(widget.data.foodPicture,),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.orange[200],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Text(
                      widget.data.foodDescription
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                    child: Text(
                      "${widget.data.foodProvider.hotelName}",
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Text(
                        "Price: ${widget.data.foodPrice} Tk",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                 /* Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "${widget.data.foodReview}",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),*/
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                              child: Row(
                            children: [
                              InkWell(
                                onTap: remove,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Icon(Icons.remove),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                    style: TextStyle(
                                      fontSize: 20,

                                    ),
                                    "${itemCount}"
                                ),
                              ),
                              InkWell(
                                onTap: add,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Icon(Icons.add),
                                ),
                              )
                            ],
                          )
                          ),
                          Expanded(
                            flex: 2,
                              child: InkWell(
                            onTap: (){
                              print('PRETTy');
                              print('PRETTy');
                            },
                            child: Container(
                              //width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.brown[500],
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text(
                                    "Place Order",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1
                                    ),
                                  ),
                                )),
                          )
                          )
                        ],
                      )
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text("Related Items"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
