import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  bool isFavorite;
  final String imageUrl;

  Product({required this.id, required this.title, required this.description, required this.price,this.isFavorite=false,required this.imageUrl});
  Future<void> toggleFavoriteButton() async{
    bool prevVal=isFavorite;
    try{
      final url=Uri.parse("https://shop-app-e09a0-default-rtdb.firebaseio.com/products/$id.json");

      isFavorite=!isFavorite;
      var response=await http.patch(url,body: jsonEncode({'isFavorite':isFavorite}));
      if(response.statusCode>=400){
        isFavorite=prevVal;

        throw("Something went wrong");
      }
      notifyListeners();

    }catch(error){
      isFavorite=prevVal;
      throw("Something went wrong");
    }

  }
}