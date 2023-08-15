import 'package:ecommerce_clean_arch/user/domain/entities/category/category.dart';

class CategoryModel extends Category {
  CategoryModel({required super.status, required super.data});
  factory CategoryModel.fromJson(Map<String,dynamic> json){
    return CategoryModel(
        status: json['status'],
        data:  json['data']
        );
  }
}