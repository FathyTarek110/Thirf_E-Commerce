import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/Adresses.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/add_address.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/address_info.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/autocomplete.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/location_details.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class BaseAddressRepository{
  Future<Either<Failure,AddAddress>> postAddress(String name ,String city,String region,String details,String note,double latitude,double longitude);
  Future<Either<Failure,Addresses>> getAddresses();
  Future<Either<Failure,PlaceAutoComplete>> getAutoComplete(String search);
  Future<Either<Failure,AddressInfo>> getAddressInfoById(String id);
  Future<Either<Failure,LocationDetails>> getLocationDetailsByLatAndLng(LatLng position);

}