import 'package:ecommerce_clean_arch/user/domain/usecase/get_addresses.dart';

import '../../domain/entities/addresses/address_info.dart';

class AddressInfoModel extends AddressInfo{
  AddressInfoModel(super.addressComponents, super.location);
  
  factory AddressInfoModel.fromJson(Map<String,dynamic> json){
    return AddressInfoModel(json['result']['address_components'], json['result']['geometry']['location']);
  }
  
}