import 'dart:convert';

import 'package:madproject/modules/models/order.dart';

class OrderServies{

  List<Order>convertOrders(dynamic orderData)
  {
    late List<Order> orders = [];
    String str  = orderData.data.toString();
    Map temp = jsonDecode(str);
    List<dynamic> list = temp["Orders"];
    orders = list.map((order) => Order.FromJSON(order)).toList();
    return orders;

  }
  
}