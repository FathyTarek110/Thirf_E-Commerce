import 'dart:ffi';

class CartItem{
  final int cartId;
  final int productId;
  final dynamic price;
  final String image;

  CartItem({ required this.cartId, required this.productId, required this.price, required this.image});
}