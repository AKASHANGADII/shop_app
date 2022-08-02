import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

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
              print(id);
            }, icon: Icon(Icons.edit),),
            IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red,),),
          ],
        ),
      ),
    );
  }
}
