import 'package:ecommerce_clean_arch/user/domain/entities/addresses/Adresses.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/add_address.dart';

class AddressesModel extends Addresses{
  AddressesModel(super.status, super.addresses);


  factory AddressesModel.fromJson(Map<String,dynamic> json){
    return AddressesModel(json['status'], json['data']['data']);
  }
  
  
}