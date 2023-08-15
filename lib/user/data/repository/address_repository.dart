import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/data/data_source/remote_data_source/address_data_source.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/Adresses.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/add_address.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/address_info.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/autocomplete.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/location_details.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_address_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../error/exception.dart';

class AddressRepository extends BaseAddressRepository{
  final BaseAddressDatasource baseAddressDatasource;

  AddressRepository(this.baseAddressDatasource);


  @override
  Future<Either<Failure, AddAddress>> postAddress(String name ,String city, String region, String details, String note, double latitude, double longitude)async {
    final result = await baseAddressDatasource.postAddress(name,city, region, details, note, latitude, longitude);
    try{
      return Right(result);
    } on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, Addresses>> getAddresses() async{
    final result = await baseAddressDatasource.getAddresses();
    try{
      return Right(result);
    } on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, PlaceAutoComplete>> getAutoComplete(String search) async {
    final result = await baseAddressDatasource.getPlaceAutoComplete(search);
    try{
      return Right(result);
    } on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }

  }

  @override
  Future<Either<Failure, AddressInfo>> getAddressInfoById(String id) async {
    final result = await baseAddressDatasource.getAddressInfoById(id);
    try{
      return Right(result);
    } on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, LocationDetails>> getLocationDetailsByLatAndLng(LatLng position) async {
    final result = await baseAddressDatasource.getLocationDetails(position);
    try{
      return Right(result);
    } on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }


}