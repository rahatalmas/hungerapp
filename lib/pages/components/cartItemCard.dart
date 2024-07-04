import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key});
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
              child: Image.asset(
                "assets/pizza.png",
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
              Text("name"),
              Row(children: [Text("Date"),Text("Category")],),
              Text("Hotel Name"),
              Text("Quantity"),
            ],
          )),
          Column(
            children: [
              InkWell(
                child: Container(
                  child: Icon(Icons.add),
                ),
              ),
              Text("2"),
              InkWell(
                child: Container(
                  child: Icon(Icons.add),
                ),
              ),
            
            ],
          ),
          InkWell(
            child: Container(
              child: Icon(Icons.delete),
            ),
          )
        ],
      ),
    );
  }
}
