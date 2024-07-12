import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hunger/dataModels/orderModel.dart';
import 'package:hunger/url.dart';

Future<void> postOrder(OrderPost order) async {
  final url = Uri.parse("http://$baseUrl/order");

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode == 201) {
      print('Order placed successfully');
    } else {
      print('Failed to place order: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception occurred while placing order: $e');
  }
}

Future<List<Order>> fetchOrdersByUserId(int userId) async {
  final url = Uri.parse('http://$baseUrl/order/$userId');

  final response = await http.get(url);

  if(response.statusCode == 200){
    List<dynamic> jsonData = jsonDecode(response.body);
    print(jsonData);
    List<Order> orders = jsonData.map((json)=>Order.fromJson(json)).toList();
    return orders;
  } else {
    throw Exception('Failed to load orders');
  }
}

Future<void> updateOrderStatus(int orderId, bool orderStatus) async {
  final url = Uri.parse('http://$baseUrl/order/update');
  final response = await http.put(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'orderId': orderId,
      'orderStatus': orderStatus,
    }),
  );
   
  if (response.statusCode == 200) {
    print('Order status updated successfully');
  } else {
    print('Failed to update order status');
  }
}
