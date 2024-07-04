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
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(color: Colors.orange[200], borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
            ClipRRect(
              child: Image.network(
                foodPicture,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          Expanded(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(foodName),
              Row(children: [Text("Date"),Text("Category")],),
              Text(hotelName),
              Text("Tatal: ${price} x ${quantity} = ${price*quantity}"),
            ],
          )),
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
          InkWell(
            onTap: removeFromCart,
            child: Container(
              child: Icon(Icons.delete),
            ),
          )
        ],
      ),
    );
  }
}
