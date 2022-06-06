class Product{
  final String id;
  final String title;
  final String description;
  final double price;
  bool isFavorite;
  final String imageUrl;

  Product({required this.id, required this.title, required this.description, required this.price,this.isFavorite=false,required this.imageUrl});

}