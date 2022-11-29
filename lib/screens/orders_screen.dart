import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders_provider.dart' as ci;
import 'package:shop_app/widgets/app_drawer.dart';

import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName='/orders-screen';
  OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isinit=true;
  bool isLoading=false;
  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();

    if(isinit){
      setState(() {
        isLoading=true;
      });
      await Provider.of<ci.Orders>(context).fetchAndSetOrders().then((value) {
        setState(() {
          isLoading=false;
        });
      });
    }
    isinit=false;
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ordersList=Provider.of<ci.Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(title: Text("Your Orders"),),
      drawer: AppDrawer(),
      body: isLoading?Center(child: CircularProgressIndicator()):ListView.builder(
          itemCount: ordersList.length,
          itemBuilder: (ctx,i)=>OrderItem(order: ordersList[i],),),
    );
  }
}
