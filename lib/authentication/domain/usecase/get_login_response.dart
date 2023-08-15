import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/authentication/domain/repository/base_login_repository.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';

import '../entities/login.dart';

class GetLoginResponse {
  final BaseLoginRepository baseLoginRepository;

  GetLoginResponse(this.baseLoginRepository);
  Future<Either<Failure, Login>> execute(String email,String password )async{
     return   await baseLoginRepository.postLoginInfo( email, password );
  }
}