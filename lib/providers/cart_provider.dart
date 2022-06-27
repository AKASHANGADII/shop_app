import 'package:flutter/material.dart';

class CartItem{
  String id;
  String title;
  double price;
  int quantity;
  CartItem({required this.id,required this.title,required this.quantity,required this.price});
}

class Cart with ChangeNotifier{
  Map<String,CartItem> _items={};
  
  Map<String,CartItem> get items{
    return {..._items};
  }

  int cartLength(){
    return _items.length;
  }
  void addItem(String id,String title,double price){
    if(_items.containsKey(id)){
      _items.update(id, (value) => CartItem(id: value.id, title: value.title, quantity: value.quantity+1, price: value.price));
    }
    else{
      _items.putIfAbsent(id, () => CartItem(id: DateTime.now().toString(), title: title, quantity: 1, price: price));
    }
    notifyListeners();
  }
}