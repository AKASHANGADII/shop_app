import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) =>Products(),),
        ChangeNotifierProvider(create: (BuildContext context) =>Cart(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          primaryColor: Colors.deepOrange,
        ),
        initialRoute: '/',
        routes: {
          '/':(ctx)=>ProductOverViewScreen(),
          ProductDetailScreen.routeName:(ctx)=>ProductDetailScreen(),
          CartScreen.routeName:(ctx)=>CartScreen(),
        },
      ),
    );
  }
}
