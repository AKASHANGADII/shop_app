import 'package:flutter/material.dart';

import '../providers/product.dart';
import '../widgets/product_item.dart';
import '../widgets/products_grid.dart';

class ProductOverViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProductsGrid(),
      ),
    );
  }
}
