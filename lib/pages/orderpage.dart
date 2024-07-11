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
        title:const Text("Order your foods"),
        actions: const [
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
             padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.orange[200],
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.userName),
                      TextField(
                        decoration: InputDecoration(label: Text("Order location")),
                        controller: locationController,
                      )
                    ],
                  ),
                  Container(
                    child:const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex:2,child: Text("Item Name"),),
                        Expanded(flex:1,child: Text("Quantity"),),
                        Expanded(flex:1,child: Text("Price"),),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                orderItems.cartList[index].food_model.foodName),),
                            Expanded(
                              flex: 1,
                              child: Text(
                                orderItems.cartList[index].quantity.toString()),),
                            Expanded(
                              flex: 1,
                              child: Text((orderItems.cartList[index].quantity *
                                    orderItems
                                        .cartList[index].food_model.foodPrice)
                                .toString()),)
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex:2, child:Text("Total")),
                        Expanded(flex:1, child:Text("")),
                        Expanded(flex: 1, child: Text(orderItems.getTotalPrice().toString()),)
                        
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical: 10),
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
