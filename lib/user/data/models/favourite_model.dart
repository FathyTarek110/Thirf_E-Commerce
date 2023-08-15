import 'package:ecommerce_clean_arch/user/domain/entities/favourite/favourite.dart';

class FavouriteModel extends Favourite{
  FavouriteModel(super.data, super.status, super.message);
  factory FavouriteModel.fromJson(Map<String,dynamic> json){
    return FavouriteModel(json['data'], json['status'], json['message']);
  }

}