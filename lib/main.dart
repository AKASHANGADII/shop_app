import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>Products(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          primaryColor: Colors.deepOrange,
        ),
        initialRoute: '/',
        routes: {
          '/':(ctx)=>ProductOverViewScreen(),
          ProductDetailScreen.routeName:(ctx)=>ProductDetailScreen(),
        },
      ),
    );
  }
}
