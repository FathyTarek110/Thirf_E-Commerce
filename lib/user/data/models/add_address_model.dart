import 'package:ecommerce_clean_arch/user/domain/entities/addresses/add_address.dart';

class AddAddressModel extends AddAddress{
  AddAddressModel(super.message);

  factory AddAddressModel.fromJson(Map<String,dynamic> json){
    return AddAddressModel(json['message']);
  }
}