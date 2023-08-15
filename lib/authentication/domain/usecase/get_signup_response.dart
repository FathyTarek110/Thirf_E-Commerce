import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/authentication/domain/entities/signup.dart';
import 'package:ecommerce_clean_arch/authentication/domain/repository/base_sign_up_repository.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';

class GetSignUpResponse{
  final BaseSignupRepository baseSignupRepository;

  GetSignUpResponse(this.baseSignupRepository);

  Future<Either<Failure, SignUp>> execute({required String name, required String email, required String password, required String phone}){
      return baseSignupRepository.postSignUpInfo(name: name, email:email, password: password, phone: phone);
  }
}