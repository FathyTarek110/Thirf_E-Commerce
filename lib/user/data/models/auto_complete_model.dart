import 'package:ecommerce_clean_arch/user/domain/entities/addresses/autocomplete.dart';

class PlaceAutoCompleteModel extends PlaceAutoComplete{
  PlaceAutoCompleteModel(super.predictions);

  factory PlaceAutoCompleteModel.fromJson(Map<String,dynamic> json){
    return PlaceAutoCompleteModel(json['predictions']);
  }
}