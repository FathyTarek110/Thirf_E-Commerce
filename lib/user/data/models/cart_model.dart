import 'package:ecommerce_clean_arch/user/domain/entities/cart/cart.dart';

class CartModel extends Cart {
  CartModel({required super.status, required super.cartItems, required super.total});
  
  factory CartModel.fromJson(Map<String,dynamic> json){
    return CartModel(status: json['status'], cartItems: json['data']['cart_items'], total: json['data']['sub_total'],);
  }
  
}