import '../../domain/entities/product/search.dart';

class ProductSearchModel extends ProductSearch{
  ProductSearchModel(super.status, super.data);

  factory ProductSearchModel.fromJson(Map<String,dynamic> json){
    return ProductSearchModel(json['status'], json['data']['data']);
  }

}