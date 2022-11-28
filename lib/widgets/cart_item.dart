import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItemCard extends StatelessWidget {
  String id;
  String productId;
  String title;
  double price;
  int quantity;
  CartItemCard(
      {required this.productId,
      required this.id,
      required this.title,
      required this.quantity,
      required this.price});
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.dissmissCartItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Are your sure?"),
            content: Text("Do you want remove the item from the cart"),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text("NO"),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(ctx, true);
                  },
                  child: Text("Yes"))
            ],
          ),
        );
      },
      background: Container(
        color: Colors.red,
        margin: EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 35,
          ),
        ),
        alignment: Alignment.centerRight,
      ),
      child: Card(
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
                        Text(
                          title,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    cart.incrementQuantity(
                                        id, title, quantity, price);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                      color: Colors.orange,
                                    ),
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(quantity.toString()),
                                SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cart.decrementQuantity(
                                        id, title, quantity, price);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                                      color: Colors.orange,
                                    ),
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                            Chip(
                              label: Text(
                                "\$ " + (quantity * price).toString(),
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
      ),
    );
  }
}
