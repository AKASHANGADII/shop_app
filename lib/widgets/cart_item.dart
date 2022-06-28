import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItemCard extends StatelessWidget {
  String id;
  String title;
  double price;
  int quantity;
  CartItemCard({required this.id,required this.title,required this.quantity,required this.price});
  @override
  Widget build(BuildContext context) {
    final cart=Provider.of<Cart>(context);
    return Card(
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 105,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(title,style: TextStyle(fontSize: 20),),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  cart.incrementQuantity(id,title,quantity,price);
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
                              Text(quantity.toString()),
                              SizedBox(width: 8,),
                              GestureDetector(
                                onTap: (){
                                  cart.decrementQuantity(id,title,quantity,price);
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
                          Chip(label: Text("\$ "+(quantity*price).toString(),),),
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
                        borderRadius: BorderRadius.circular(5),
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
