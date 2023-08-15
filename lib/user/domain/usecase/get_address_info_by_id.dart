import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/address_info.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_address_repository.dart';

class GetAddressInfoById{
  final BaseAddressRepository baseAddressRepository;

  GetAddressInfoById(this.baseAddressRepository);

  Future<Either<Failure,AddressInfo>> execute(String id)async{
    return await baseAddressRepository.getAddressInfoById(id);
  }

}