import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_address_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../entities/addresses/location_details.dart';

class GetLocationDetailsByLatAndLng{
  final BaseAddressRepository baseAddressRepository;

  GetLocationDetailsByLatAndLng(this.baseAddressRepository);

  Future<Either<Failure,LocationDetails>> execute(LatLng position)async{
    return await baseAddressRepository.getLocationDetailsByLatAndLng(position);
  }

}