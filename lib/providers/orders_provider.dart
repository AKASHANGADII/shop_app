import 'package:flutter/cupertino.dart';

import 'cart_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final DateTime dateTime;
  final List<CartItem> products;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.dateTime,
      required this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        "https://shop-app-e09a0-default-rtdb.firebaseio.com/orders.json");
    final timeSpan = DateTime.now().toIso8601String();
    try{
      final response=await http.post(
        url,
        body: json.encode(
          {
            'amount': total,
            'dateTime': timeSpan,
            'products':cartProducts.map((cp) => {
              'title':cp.id,
              'price':cp.price,
              'quantity':cp.quantity,
            }).toList()
          },
        ),
      );
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)[''],
          amount: total,
          dateTime: DateTime.now(),
          products: cartProducts,
        ),
      );          notifyListeners();
    }catch(error){
      print(error.toString());
      return;
    }

  }
}
