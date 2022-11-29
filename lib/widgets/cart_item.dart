import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItemCard extends StatefulWidget {
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
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(widget.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.dissmissCartItem(widget.productId);
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
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.orange)
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cart.decrementQuantity(
                                      widget.id, widget.title, widget.quantity, widget.price);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
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
                              Text(widget.quantity.toString()),
                              SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  cart.incrementQuantity(
                                      widget.id, widget.title, widget.quantity, widget.price);

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
                        ),
                        Chip(
                          label: Text(
                            "\$ " + double.parse((widget.quantity * widget.price).toStringAsFixed(3)).toString(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: InkWell(onTap: (){},
                //         child: Container(
                //           decoration: BoxDecoration(
                //             color: Colors.orange,
                //             borderRadius: BorderRadius.circular(5),
                //           ),
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Center(child: Text("BUY NOW")),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
