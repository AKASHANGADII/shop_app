import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final String productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct= Provider.of<Products>(context,listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title),),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 300,
              child: Image.network(loadedProduct.imageUrl,fit: BoxFit.cover,),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            child: Text(loadedProduct.description),
          ),
          SizedBox(height: 20,),
          Container(
            child: Text(loadedProduct.price.toString()),
          )
        ],
      ),
    );
  }
}
