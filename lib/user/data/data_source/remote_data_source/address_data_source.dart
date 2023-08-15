import 'package:dio/dio.dart';
import 'package:ecommerce_clean_arch/authentication/presentation/controller/login_cubit/login_cubit.dart';
import 'package:ecommerce_clean_arch/core/resources/strings_manger/strings_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../authentication/data/data_source/remote_data_source/error_message_model.dart';
import '../../../../core/network_helper/dio_helper.dart.dart';
import '../../../../error/exception.dart';
import '../../models/add_address_model.dart';
import '../../models/addresses_model.dart';
import '../../models/auto_complete_model.dart';
import '../../models/get_address_info_model.dart';
import '../../models/location_details_model.dart';

abstract class BaseAddressDatasource{
  Future<AddAddressModel> postAddress(String name ,String city,String region,String details,String note,double latitude,double longitude);
  Future<AddressesModel> getAddresses();
  Future<PlaceAutoCompleteModel>getPlaceAutoComplete(String search);
  Future<AddressInfoModel> getAddressInfoById(String id);
  Future<LocationDetailsModel> getLocationDetails(LatLng position);
}


class AddressDatasource extends BaseAddressDatasource{
  @override
  Future<AddressesModel> getAddresses() async{
    final response = await DioHelper.getData(url: UrlManager.addresses,token: LoginCubit.token);
    if(response?.statusCode == 200){
      return AddressesModel(response?.data['status'], response?.data['data']['data']);
    }else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }

  @override
  Future<AddAddressModel> postAddress(String name,String city,String region,String details,String note,double latitude,double longitude) async {
    final response = await DioHelper.postData(url: UrlManager.addresses, token: LoginCubit.token,data: {
      'name':name,
      'city':city,
      'region':region,
      'details':details,
      'notes':note,
      'latitude':latitude,
      'longitude':longitude
    });

    if(response?.statusCode ==200 ){
      return AddAddressModel(response?.data['message']);
    }
    else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }

  @override
  Future<PlaceAutoCompleteModel> getPlaceAutoComplete(String search) async{
    final response = await DioHelper.getData(url: 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=${UrlManager.types}&key=${UrlManager.key}');
    if(response?.statusCode == 200){
      return PlaceAutoCompleteModel(response?.data['predictions']);
    }else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }

  @override
  Future<AddressInfoModel> getAddressInfoById(String id) async {
    final response = await DioHelper.getData(url: 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&key=${UrlManager.key}') ;
    if(response?.statusCode == 200){
      return AddressInfoModel.fromJson(response?.data);
    }else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }

  @override
  Future<LocationDetailsModel> getLocationDetails(LatLng position) async{
    final response = await DioHelper.getData(url: 'https://maps.google.com/maps/api/geocode/json?key=${UrlManager.key}&language=en&latlng=${position.latitude},${position.longitude}');
    if(response?.statusCode == 200){
      return LocationDetailsModel.fromJson(response?.data);
    }else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }

}