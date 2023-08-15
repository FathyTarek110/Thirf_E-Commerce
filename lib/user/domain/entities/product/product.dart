class Product{
  final bool status;
  final Map<String,dynamic>? data;
  final List? images;

  Product({this.images,required this.status,required this.data});
}