import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders_provider.dart' as oi;

class OrderItem extends StatefulWidget {
  final oi.OrderItem order;
  OrderItem({required this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${widget.order.amount}"),
                Text(
                    DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
                ),
                IconButton(
                  icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ],
            ),
          ),
          if (_isExpanded)
            Container(
              height: min(widget.order.products.length * 30.0 + 10.0, 200.0),
              child: ListView(
                children: widget.order.products
                    .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e.title),
                              Text("${e.quantity}x \$${e.price}")
                            ],
                          ),
                    ),)
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
