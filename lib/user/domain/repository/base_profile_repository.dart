import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/profile/profile.dart';

abstract class BaseProfileRepository {
  Future<Either<Failure,Profile>> getProfile();
}