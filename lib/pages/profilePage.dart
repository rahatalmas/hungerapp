import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/getUser.dart';
import 'package:hunger/apiControllers/postorder.dart';
import 'package:hunger/dataModels/userModel.dart';
import 'package:hunger/dataModels/orderModel.dart';
import 'package:hunger/globalStates/LoginInfoProvider.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? _userData;
  
  List<Order> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final loginInfoProvider = Provider.of<LoginInfoProvider>(context, listen: false);
      final loginInfo = await loginInfoProvider.loginInfo;
      print("loginInfo Profile page ${loginInfo}");
      if (loginInfo != null) {
        Map<String, dynamic> token = JwtDecoder.decode(loginInfo.accessToken);
        UserModel user = await getUser(loginInfo.accessToken, token["user_id"]);
        print("profile page user ${user.user_id}");
        List<Order> orders = await fetchOrdersByUserId(user.user_id);
        print("orders ${orders}");
        setState(() {
          _userData = user;
          _orders = orders;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Order> getPendingOrders() {
    return _orders.where((order) => !order.orderStatus).toList();
  }

  List<Order> getNotPendingOrders() {
    return _orders.where((order) => order.orderStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _userData != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userData!.user_name,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              _userData!.user_email,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Pending Orders:',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: getPendingOrders().length,
                              itemBuilder: (context, index) {
                                Order order = getPendingOrders()[index];
                                return ListTile(
                                  title: Text('Order ID: ${order.orderId}'),
                                  subtitle: Text('Food ID: ${order.orderedFoodId}, Quantity: ${order.quantity}'),
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Not Pending Orders:',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: getNotPendingOrders().length,
                              itemBuilder: (context, index) {
                                Order order = getNotPendingOrders()[index];
                                return ListTile(
                                  title: Text('Order ID: ${order.orderId}'),
                                  subtitle: Text('Food ID: ${order.orderedFoodId}, Quantity: ${order.quantity}'),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text('User data not available'),
                ),
    );
  }
}
