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

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        "https://shop-app-e09a0-default-rtdb.firebaseio.com/orders.json");
    try {
      final response = await http.get(url);
      final loadedData = await jsonDecode(response.body) as Map<String, dynamic>;
      List<OrderItem> loadedOrders = [];
      loadedData.forEach(
        (key, value) {
          loadedOrders.add(
            OrderItem(
              id: key,
              amount: value['amount'],
              dateTime: DateTime.parse(value['dateTime']),
              products: (value['products'] as List<dynamic>)
                  .map((element) => CartItem(
                id: element['id'],
                      title: element['title'],
                      quantity: element['quantity'],
                      price: element['price']))
                  .toList(),
            ),
          );
        },
      );
      _orders = loadedOrders;
      print(_orders);
      notifyListeners();
    } catch (error) {
      print(error.toString()+"som");
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        "https://shop-app-e09a0-default-rtdb.firebaseio.com/orders.json");
    final timeSpan = DateTime.now().toIso8601String();
    try {
      final response = await http
          .post(
        url,
        body: json.encode(
          {
            'amount': total,
            'dateTime': timeSpan,
            'products': cartProducts
                .map((cp) => {
                  'id':timeSpan,
                      'title': cp.title,
                      'price': cp.price,
                      'quantity': cp.quantity,
                    })
                .toList()
          },
        ),
      );
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: DateTime.now(),
          products: cartProducts,
        ),
      );

      notifyListeners();
    } catch (error) {
      print(error.toString());
      return;
    }
  }
}
