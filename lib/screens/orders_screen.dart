import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders_provider.dart' as ci;
import 'package:shop_app/widgets/app_drawer.dart';

import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName='/orders-screen';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersList=Provider.of<ci.Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(title: Text("Your Orders"),),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: ordersList.length,
          itemBuilder: (ctx,i)=>OrderItem(order: ordersList[i],),),
    );
  }
}
