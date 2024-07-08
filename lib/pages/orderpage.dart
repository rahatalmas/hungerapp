import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget{
  const OrderPage({super.key});
  @override
  State<OrderPage> createState ()=> _OrderPage();
}

class _OrderPage extends State<OrderPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=> Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        title: Text("Order your foods"),
        actions: [
          Icon(Icons.restaurant_outlined),
          SizedBox(width: 10,),
        ],
        backgroundColor: Colors.orange[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("order page")
          ],
        ),
      ),
    );
  }
}