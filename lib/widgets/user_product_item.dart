import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  String id;
  String imageUrl;
  String title;
  UserProductItem({required this.id,required this.title,required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, EditProductScreen.routeName,arguments: id);
            }, icon: Icon(Icons.edit),),
            IconButton(onPressed: (){
              Provider.of<Products>(context,listen: false).deleteProduct(id);
            }, icon: Icon(Icons.delete,color: Colors.red,),),
          ],
        ),
      ),
    );
  }
}
