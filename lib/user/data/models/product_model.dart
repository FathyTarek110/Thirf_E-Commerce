import 'package:ecommerce_clean_arch/user/domain/entities/product/product.dart';

class ProductModel extends Product{
  ProductModel({super.images, required super.status, required super.data});
  factory ProductModel.fromJson(Map<String,dynamic> json){
    return ProductModel(images: json['data']['images'],status: json['status'], data: json['data']);
  }

}