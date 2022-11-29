import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders_provider.dart';
import 'package:shop_app/widgets/cart_item.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName="/cart-screen";
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card=Provider.of<Cart>(context);
    final cardList=card.items;
    final orders=Provider.of<Orders>(context,listen: false);
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
                  Chip(
                    label: Text("\$ ${card.totalAmount}",style: TextStyle(color: Colors.white),),backgroundColor: Colors.purple,),
                  OrderButton(orders: orders, card: card)
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cardList.length,
              itemBuilder: (ctx,i)=>ChangeNotifierProvider.value(
                  value:cardList[i],
                  child: CartItemCard(productId:cardList.keys.toList()[i],id: cardList.values.toList()[i].id,title: cardList.values.toList()[i].title,quantity: cardList.values.toList()[i].quantity,price: cardList.values.toList()[i].price,),
            ),
          ),),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  OrderButton({
    Key? key,
    required this.orders,
    required this.card,
  }) : super(key: key);

  final Orders orders;
  final Cart card;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: (widget.card.totalAmount<=0 || isLoading)?null:() async {
          setState(() {
            isLoading=true;
          });
       await widget.orders.addOrder(widget.card.items.values.toList(), widget.card.totalAmount);
          setState(() {
            isLoading=false;
          });
      widget.card.clearCart();
    }, child: isLoading?CircularProgressIndicator():Text("ORDER NOW",style: TextStyle(color: Colors.green),));
  }
}
