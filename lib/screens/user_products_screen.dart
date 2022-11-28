import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatefulWidget {
  static const routeName='/user-products-screen';

  @override
  State<UserProductsScreen> createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  Future<void> _onReferesh(BuildContext ctx) async {
    await Provider.of<Products>(ctx,listen: false).fetchAndSetProducts();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _onReferesh(context);
  }
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
      body: RefreshIndicator(
        onRefresh: ()=>_onReferesh(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
      ),
    );
  }
}
