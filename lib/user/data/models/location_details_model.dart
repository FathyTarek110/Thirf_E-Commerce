import 'package:ecommerce_clean_arch/user/domain/entities/addresses/location_details.dart';

class LocationDetailsModel extends LocationDetails{
  
  LocationDetailsModel(super.compoundCode, super.formattedAddress);
  
  factory LocationDetailsModel.fromJson(Map<String,dynamic> json){
    return LocationDetailsModel(json['plus_code']['compound_code'], json['results'][0]['formatted_address']);
  }
  
}