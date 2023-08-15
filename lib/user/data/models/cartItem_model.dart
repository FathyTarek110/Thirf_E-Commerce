import 'package:ecommerce_clean_arch/user/domain/entities/cart/cart_item.dart';

class CartItemModel extends CartItem{
  CartItemModel({ required super.cartId, required super.productId, required super.price, required super.image});


  factory CartItemModel.fromJson(Map<String,dynamic>json){
    return CartItemModel( cartId: json['data']['id'], productId: json['data']['product']['id'], price: json['data']['product']['price'], image: json['data']['product']['image']);
  }

}