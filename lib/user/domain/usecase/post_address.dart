import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/add_address.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_address_repository.dart';

class PostAddress{
  final BaseAddressRepository baseAddressRepository;

  PostAddress(this.baseAddressRepository);

  Future<Either<Failure,AddAddress>> execute(String name ,String city,String region,String details,String note,double latitude,double longitude)async{
    return await baseAddressRepository.postAddress(name,city, region, details, note, latitude, longitude);
  }
}