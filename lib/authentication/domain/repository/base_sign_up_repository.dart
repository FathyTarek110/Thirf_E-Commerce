import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/authentication/domain/entities/signup.dart';

import '../../../error/failure.dart';

abstract class BaseSignupRepository{
  Future<Either<Failure,SignUp>> postSignUpInfo({required String name, required String email, required String password, required String phone});
}