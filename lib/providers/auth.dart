import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier{
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  Future<void> _authenticate(String email,String password,String endPoint) async{
    var url=Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:$endPoint?key=AIzaSyDaVp40QOUuW7ZFCMrnpWuheumZfgEuWr0");

    try{
      final response=await http.post(url,body: json.encode({'email':email,'password':password,'returnSecureToken':true}));
      final responseData=json.decode(response.body);
      if(responseData['error']!=null){
        throw responseData['error']['message'];
      }
    }
    catch(error){
      throw error;
    }
  }

  Future<void> signUp(String email,String password) async{
      return _authenticate(email, password, "signUp");
  }
  Future<void> login(String email,String password) async{
    return _authenticate(email, password, "signInWithPassword");
  }
}