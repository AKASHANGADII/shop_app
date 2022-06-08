
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/product_item.dart';
import '../providers/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData=Provider.of<Products>(context);
    final products=productsData.items;
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15),
      itemBuilder: (context, i) => ChangeNotifierProvider(
        create: (ctx)=>products[i],
        child: ProductItem(),
      ),
    );
  }
}



