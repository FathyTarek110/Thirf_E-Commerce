import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/Adresses.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_address_repository.dart';

class GetAddresses{
  final BaseAddressRepository baseAddressRepository;

  GetAddresses(this.baseAddressRepository);

  Future<Either<Failure,Addresses>> execute()async{
    return await baseAddressRepository.getAddresses();
  }
}