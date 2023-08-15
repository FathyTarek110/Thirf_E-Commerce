import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/profile/profile.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_profile_repository.dart';

class GetProfileData{
  final BaseProfileRepository baseProfileRepository;

  GetProfileData(this.baseProfileRepository);

  Future<Either<Failure,Profile>> execute()async{
    return await baseProfileRepository.getProfile();
  }
}