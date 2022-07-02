import 'package:flutter/material.dart';

class CartItem with ChangeNotifier{
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
  
  double get totalAmount{
    var total=0.0;
    _items.forEach((key, value) {total+=value.price*value.quantity;});
    return total;
  }
  void incrementQuantity(String id,String title,int quantity,double price){
    _items.update(id, (value) => CartItem(id: value.id, title: value.title, quantity: value.quantity+1, price: value.price));
    notifyListeners();
}
void dissmissCartItem(String id){
    _items.remove(id);
    notifyListeners();
}

  void decrementQuantity(String id,String title,int quantity,double price){
    if(quantity>1){
    _items.update(id, (value) => CartItem(id: value.id, title: value.title, quantity: value.quantity-1, price: value.price));
    notifyListeners();
    }
  }

  void clearCart(){
    _items={};
    notifyListeners();
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