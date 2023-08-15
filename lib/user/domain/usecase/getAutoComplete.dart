import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/autocomplete.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_address_repository.dart';

import '../../../error/failure.dart';

class GetAutoComplete{
 final BaseAddressRepository baseAddressRepository;

  GetAutoComplete(this.baseAddressRepository);

  Future<Either<Failure, PlaceAutoComplete>> execute(search)async{
    return  await baseAddressRepository.getAutoComplete(search);
  }



}