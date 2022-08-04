

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName='/edit-product-screen';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _discriptionFocusNode = FocusNode();
  final _imageUrlFocusNode=FocusNode();
  final _imageUrlController=TextEditingController();
  var _editProduct=Product(id: "", title: "", description: "", price: 0, imageUrl: "");
  final _form=GlobalKey<FormState>();
  bool errorCheck=false;
  var _isLoading=false;

  var _inItvalues={
    'title':'',
    'discription':'',
    'imageUrl':'',
    'price':'',
    'id':'aa',
  };
  @override
  void didChangeDependencies() {
    final productId=ModalRoute.of(context)!.settings.arguments as String;

    if(productId!="aaa") {
      final product =Provider.of<Products>(context,listen: false).findById(productId);
      _inItvalues = {
        'title': product.title,
        'discription': product.description,
        'imageUrl': '',
        'price': product.price.toString(),
        'id': product.id,
      };
      _imageUrlController.text = product.imageUrl;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImage);
    super.initState();
  }
  void _updateImage(){
    if(!_imageUrlFocusNode.hasFocus){
      setState((){});
    }
  }
  Future<void> saveForm() async {
    errorCheck=_form.currentState!.validate();
    if(!errorCheck){
      return;
    }
    _form.currentState!.save();
    setState((){
      _isLoading=true;
    });
    if(_editProduct.id=="aa"){
      try{
        await Provider.of<Products>(context,listen: false).addItem(_editProduct);
      }
      catch(error){
        await showDialog<Null>(
            context: context,
            builder: (_)=>AlertDialog(title: Text("An error occured"),content: Text("Something went wrong!"),actions: [
              TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Okay"))
            ],)
        );
      }
    }
    else{
      await Provider.of<Products>(context,listen: false).updateProduct(_editProduct.id, _editProduct);
    }
    setState((){
      _isLoading=false;
    });
    Navigator.pop(context);
  }
  @override
  void dispose() {
    _discriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Edit product"),actions: [
        IconButton(onPressed: (){
          saveForm();
        }, icon: Icon(Icons.save))
      ],),
      body: _isLoading?Center(child: CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.black12,)):Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _inItvalues['title'],
                  decoration: const InputDecoration(label: Text("Title")),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_){
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Add the title name";
                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (value){
                    _editProduct=Product(id:_inItvalues['id'].toString(),isFavorite: _editProduct.isFavorite, title: value.toString(), description: _editProduct.description, price: _editProduct.price, imageUrl: _editProduct.imageUrl);
                  },
                ),
                TextFormField(
                  initialValue: _inItvalues['price'],
                  decoration: const InputDecoration(label: Text("Price")),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_){
                    FocusScope.of(context).requestFocus(_discriptionFocusNode);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Add the price of the product";
                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (value){
                    _editProduct=Product(id:_inItvalues['id'].toString(),isFavorite: _editProduct.isFavorite,title: _editProduct.title,description: _editProduct.description,price: double.parse(value.toString()),imageUrl: _editProduct.imageUrl);
                  },
                ),
                TextFormField(
                  initialValue: _inItvalues['discription'],
                  decoration: const InputDecoration(label: Text("Discription"),),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _discriptionFocusNode,
                  onSaved: (value){
                    _editProduct=Product(id:_inItvalues['id'].toString(),isFavorite: _editProduct.isFavorite,title: _editProduct.title,description:value.toString(),price: _editProduct.price,imageUrl: _editProduct.imageUrl);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Add the product discription";
                    }
                    else{
                      return null;
                    }
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8,right: 10),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color:Colors.black12)
                      ),
                      child: _imageUrlController.text.isEmpty?Text("Add image url"):FittedBox(child: Image.network(_imageUrlController.text,fit: BoxFit.cover,),),
                    ),
                    Expanded(child: TextFormField(
                      decoration: InputDecoration(label: Text("Image url",),),
                      focusNode: _imageUrlFocusNode,
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      onSaved: (value){
                        _editProduct=Product(id:_inItvalues['id'].toString(),isFavorite: _editProduct.isFavorite,title: _editProduct.title,description: _editProduct.description,price: _editProduct.price,imageUrl: value.toString());
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "Add the image url";
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
