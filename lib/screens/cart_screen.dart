import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/cart_item.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName="/cart-screen";
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card=Provider.of<Cart>(context);
    final cardList=card.items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("TOTAL",style: TextStyle(fontSize: 16),),
                  Spacer(),
                  Chip(label: Text("\$ ${card.totalAmount}",style: TextStyle(color: Colors.white),),backgroundColor: Colors.purple,),
                  FlatButton(onPressed: (){}, child: Text("ORDER NOW",style: TextStyle(color: Colors.green),))
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cardList.length,
              itemBuilder: (ctx,i)=>ChangeNotifierProvider.value(
                  value:cardList[i],
                  child: CartItemCard(id: cardList.values.toList()[i].id,title: cardList.values.toList()[i].title,quantity: cardList.values.toList()[i].quantity,price: cardList.values.toList()[i].price,),
            ),
          ),),
        ],
      ),
    );
  }
}
