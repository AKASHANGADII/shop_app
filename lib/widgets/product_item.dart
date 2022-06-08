import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../providers/product.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: product.id);
        },
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              onPressed: () {
                product.toggleFavoriteButton();
              },
              icon: Icon(product.isFavorite?Icons.favorite:Icons.favorite_border,color: Theme.of(context).primaryColor,),
            ),
            title: Text(product.title,textAlign: TextAlign.center,),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart,
              color: Theme.of(context).primaryColor,),
            ),
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}