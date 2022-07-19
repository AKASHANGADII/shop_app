import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName='/user-products-screen';
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData=Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Your products"),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: "aaa");
          }, icon: Icon(Icons.add),),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_,i)=>Column(
            children: [
              UserProductItem(id:productData.items[i].id,title: productData.items[i].title, imageUrl: productData.items[i].imageUrl),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
