//Currently getting orders data from json later on it will be retrieved from firebasOrdersRepoe firestore database

import 'package:dio/dio.dart';
import 'package:madproject/config/constants/AppConstants.dart';
import 'package:madproject/modules/models/order.dart';

class OrdersRepo {
  final URL =
      "https://raw.githubusercontent.com/mohitleo03/Mobile-Application-Development/main/shopping_seller_app/models%20%26%20fake%20data/orders.json";
  OrdersRepo._();
  static OrdersRepo OrderRepo = OrdersRepo._();
  static OrdersRepo getInstance() {
    return OrderRepo;
  }

  final client = Dio();

  
  Future<dynamic> getOrders() {
    
    Future<Response> response =  client.get(URL);
    return response;
    
    
    
  }
  
}