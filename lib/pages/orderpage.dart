import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/postorder.dart';
import 'package:hunger/dataModels/orderModel.dart';
import 'package:hunger/globalStates/cartItemProvider.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  OrderPage({super.key, required this.userId,required this.userName, required this.orderLocation});
  int userId;
  String userName;
  String orderLocation;
  @override
  State<OrderPage> createState() => _OrderPage();
}

class _OrderPage extends State<OrderPage> {
  final TextEditingController locationController = TextEditingController();
  @override 
  void initState() {
    super.initState();
    locationController.text = widget.orderLocation;
  }
  @override
  Widget build(BuildContext context) {
    final orderItems = Provider.of<CartItemProvider>(context);
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        title: Text("Order your foods"),
        actions: [
          Icon(Icons.restaurant_outlined),
          SizedBox(
            width: 10,
          ),
        ],
        backgroundColor: Colors.orange[300],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
             // margin: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.orange[200]),
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(widget.userName),
                      TextField(
                        controller: locationController,
                      )
                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text("Item Name"),
                        Text("Quantity"),
                        Text("price"),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true, 
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orderItems.cartLength,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Row(
                          children: [
                            Text(
                                orderItems.cartList[index].food_model.foodName),
                            Text(
                                orderItems.cartList[index].quantity.toString()),
                            Text((orderItems.cartList[index].quantity *
                                    orderItems
                                        .cartList[index].food_model.foodPrice)
                                .toString()),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text("Total"),
                        Text(orderItems.getTotalPrice().toString()),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 17),
                    decoration: BoxDecoration(
                      color: Colors.brown[500],
                      borderRadius: BorderRadius.circular(15),
                      //border: Border.all(width: 3,color: Colors.black)
                    ),
                    child: InkWell(
                      child: const Text(
                                    "Confirm Order",
                                    style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                      onTap: () async {
                                  setState(() {
                                    widget.orderLocation = locationController.text;
                                  });
                        
                                  for (int i = 0;
                                      i < orderItems.cartItems.length;
                                      i++) {
                                    OrderPost order = OrderPost(
                                      orderedUserId: widget.userId,
                                      orderedFoodId: orderItems
                                          .cartItems[i].food_model.foodId,
                                      quantity: orderItems.cartItems[i].quantity,
                                      deliveryLocation: widget.orderLocation,
                                      time: orderItems.cartItems[i].date,
                                    );

                                    try {
                                      await postOrder(order);
                                      print(
                                          'Order placed successfully for item $i');
                                    } catch (e) {
                                      print(
                                          'Failed to place order for item $i: $e');
                                    }
                                  }
                                  orderItems.clearList();
                                  
                                },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
