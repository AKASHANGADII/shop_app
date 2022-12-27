import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier{
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth{
    return token!=null;
  }

  String? get token{
    // ignore: unnecessary_null_comparison
    if(_expiryDate!=null&&_expiryDate!.isAfter(DateTime.now())&&_token!=null){
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(String email,String password,String endPoint) async{
    var url=Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:$endPoint?key=AIzaSyDaVp40QOUuW7ZFCMrnpWuheumZfgEuWr0");
    try{
      final response=await http.post(url,body: json.encode({'email':email,'password':password,'returnSecureToken':true}));
      final responseData=json.decode(response.body);
      if(responseData['error']!=null){
        throw responseData['error']['message'];
      }
      _token=responseData['idToken'];
      _userId=responseData['localId'];
      _expiryDate=DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn']),),);
      notifyListeners();
    }
    catch(error){
      rethrow;
    }
  }

  Future<void> signUp(String email,String password) async{
      return _authenticate(email, password, "signUp");
  }
  Future<void> login(String email,String password) async{
    return _authenticate(email, password, "signInWithPassword");
  }
}