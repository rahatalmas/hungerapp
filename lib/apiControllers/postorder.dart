import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hunger/dataModels/orderModel.dart';

Future<void> postOrder(OrderPost order) async {
  final url = Uri.parse("http://192.168.243.213:5000/order");

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(order.toJson()),
    );

    if(response.statusCode == 201) {
      print('Order placed successfully');
    } else {
      print('Failed to place order: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception occurred while placing order: $e');
  }
}


Future<List<Order>> fetchOrdersByUserId(int userId) async {
  final url = Uri.parse('http://192.168.243.213:5000/order/$userId');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Iterable jsonResponse = jsonDecode(response.body);
      List<Order> orders = jsonResponse.map((order) => Order.fromJson(order)).toList();
      return orders;
    } else {
      print('Failed to fetch orders: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Exception occurred while fetching orders: $e');
    return [];
  }
}