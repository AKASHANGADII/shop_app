import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen.dart';

import '../providers/cart_provider.dart';
import '../providers/product.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/product_item.dart';
import '../widgets/products_grid.dart';

enum productScreen {
  Favorites,
  All,
}

class ProductOverViewScreen extends StatefulWidget {
  static const routeName='/products-screen';
  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  bool showFavs = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
                child: IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, CartScreen.routeName);
                    },
                    icon: Icon(Icons.shopping_cart)),
                value: cart.cartLength().toString(),
                color: Colors.orange,
                ),
          ),
          PopupMenuButton(
              onSelected: (selectedValue) {
                setState(() {
                  if (productScreen.Favorites == selectedValue) {
                    showFavs = true;
                  } else {
                    showFavs = false;
                  }
                });
              },
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text("Favorites"),
                      value: productScreen.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text("Show all"),
                      value: productScreen.All,
                    ),
                  ]),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProductsGrid(showFavs),
      ),
    );
  }
}
