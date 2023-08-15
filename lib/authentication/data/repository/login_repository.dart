import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/authentication/data/data_source/remote_data_source/login_data_source/login_data_source.dart';
import 'package:ecommerce_clean_arch/authentication/domain/entities/login.dart';
import 'package:ecommerce_clean_arch/authentication/domain/repository/base_login_repository.dart';
import 'package:ecommerce_clean_arch/error/exception.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';

class LogInRepository extends BaseLoginRepository{
  final BaseLoginRemoteDataSource baseLoginRemoteDataSource;

  LogInRepository(this.baseLoginRemoteDataSource);
  @override
  Future<Either<Failure, Login>> postLoginInfo(String email,String password) async{
    final result = await baseLoginRemoteDataSource.postLoginInfo(email, password);
    try{
      return Right(result);
    }
    on ServerException catch(e){
      return left(ServerFailure(e.errorMessageModel.message));
    }


  }

}