import 'package:ecommerce_clean_arch/user/domain/entities/orders/orders.dart';

class OrdersModel extends Orders{
  OrdersModel({required super.status, required super.orders,});
  
  
  factory OrdersModel.fromJson(Map<String,dynamic> json){
    return OrdersModel(status: json['status'], orders: json['data']['data']);
  }

}