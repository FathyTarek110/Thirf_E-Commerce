import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/exception.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/data/data_source/remote_data_source/profile_data_source.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/profile/profile.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_profile_repository.dart';

class ProfileRepository extends BaseProfileRepository{
  final BaseProfileDataSource baseProfileDataSource;

  ProfileRepository(this.baseProfileDataSource);
  @override
  Future<Either<Failure, Profile>> getProfile() async{
    final result = await baseProfileDataSource.getProfile();
    try{
      return Right(result);
    } on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }
  
}