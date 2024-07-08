import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/postorder.dart';

class OrderStatusCard extends StatelessWidget {
  OrderStatusCard(
    {
      super.key,
      required this.orderId,
      required this.foodName,
      required this.foodPicture,
      required this.date,
      required this.category,
      required this.hotelName,
      required this.price,
      required this.quantity,
      required this.deliveryStatus,
      required this.deliveryLocation,
      required this.fetchData,
    }
  );
  int orderId;
  String foodName;
  String foodPicture;
  DateTime date;
  String category;
  String hotelName;
  int price;
  int quantity;
  String deliveryLocation;
  bool deliveryStatus;
  Function() fetchData;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: MediaQuery.of(context).size.width,
      //height: 110,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(color: Colors.orange[200], borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          //image
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                foodPicture,
                width: (MediaQuery.of(context).size.width*30)/100,
                height: (MediaQuery.of(context).size.width*25)/100,
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(width: 10,),
          //data
          Expanded(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(foodName.length>10?"${foodName.substring(0,7)}..":foodName, 
                    style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text("Pending", 
                    style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500,color: Colors.green),
              ),
              ],),
              
              Text(deliveryLocation,style: TextStyle(fontSize: 13),),
              Text(hotelName,style: TextStyle(fontSize: 10),),
              Row(
                children: [
                  Text(date.day.toString()+"-"+date.month.toString()+"-"+date.year.toString()+" | ",style: TextStyle(fontSize: 10),),
                  Text(category,style: TextStyle(fontSize: 10),)
                ],),
              Text("Tatal: $price x $quantity = ${price*quantity}",style: TextStyle(fontSize: 13),)
            ],
          )
          ),
          //buttons
          SizedBox(width: 10,),
          InkWell(
                onTap: (){
                      updateOrderStatus(orderId,true);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.brown[900],
                            
                            content: Text("Enjoy Your Meal",style: TextStyle(color: Colors.white),)
                        )
                      );
                      fetchData();
                
                },
                child: Container(
                   padding: EdgeInsets.fromLTRB(7, 25, 0, 25),
                  //height: MediaQuery.of(context).size.height,
                  decoration:const BoxDecoration(
                    //color: Colors.red,
                    border: BorderDirectional(start: BorderSide(color:Color.fromARGB(255, 172, 4, 4),width: 2)),
                    //borderRadius: BorderRadius.circular(5)
                    
                  ),
                  child: Icon(Icons.delete_forever_outlined,),
                ),
              )
        ],
      ),
    );
  }
}
