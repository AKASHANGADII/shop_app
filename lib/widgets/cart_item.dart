import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItemCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final cart=Provider.of<Cart>(context);
    final cartItem=Provider.of<CartItem>(context);
    return Card(
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(cartItem.title,style: TextStyle(fontSize: 20),),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              cart.incrementQuantity(cartItem.id, cartItem.title, cartItem.quantity, cartItem.price);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5),),
                                color: Colors.orange,
                              ),
                              child: Icon(Icons.remove),
                            ),
                          ),
                          SizedBox(width: 8,),
                          Text(cartItem.quantity.toString()),
                          SizedBox(width: 8,),
                          GestureDetector(
                            onTap: (){
                              cart.decrementQuantity(cartItem.id, cartItem.title, cartItem.quantity, cartItem.price);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5),),
                                color: Colors.orange,
                              ),
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("BUY NOW"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
