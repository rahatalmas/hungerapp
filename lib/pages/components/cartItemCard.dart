import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  CartItemCard(
    {
      super.key,
      required this.foodName,
      required this.foodPicture,
      required this.date,
      required this.category,
      required this.hotelName,
      required this.price,
      required this.quantity,
      required this.incQuantity,
      required this.decQuantity,
      required this.removeFromCart,
    }
  );
  String foodName;
  String foodPicture;
  DateTime date;
  String category;
  String hotelName;
  int price;
  int quantity;
  Function() incQuantity;
  Function() decQuantity;
  final VoidCallback removeFromCart;
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                foodPicture,
                width: (MediaQuery.of(context).size.width*30)/100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10,),
          Expanded(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(foodName, 
                    style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
              ),
              Text(hotelName),
              Row(
                children: [
                  Text(date.day.toString()+"-"+date.month.toString()+"-"+date.year.toString()+" | ",style: TextStyle(fontSize: 10),),
                  Text(category,style: TextStyle(fontSize: 12),)
                ],),
              Text("Tatal: $price x $quantity = ${price*quantity}"),
            ],
          )),

          //buttons
          Column(
            children: [
              InkWell(
                onTap: incQuantity,
                child: Container(
                  child: Icon(Icons.add),
                ),
              ),
              Text(quantity.toString()),
              InkWell(
                onTap: decQuantity,
                child: Container(
                  child: Icon(Icons.remove),
                ),
              ),
            
            ],
          ),
          SizedBox(width: 10,),
          Column(

            children: [
              InkWell(
                onTap: removeFromCart,
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
          )
        ],
      ),
    );
  }
}
