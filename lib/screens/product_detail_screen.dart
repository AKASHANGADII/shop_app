import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-details';
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct= Provider.of<Products>(context,listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title),),
    );
  }
}
