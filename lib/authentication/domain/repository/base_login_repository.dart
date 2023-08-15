import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/authentication/domain/entities/login.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';

abstract class BaseLoginRepository{
  Future<Either<Failure,Login>> postLoginInfo(String email, String password);
}