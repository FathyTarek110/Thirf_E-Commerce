import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/category/category.dart';

abstract class BaseCategoryRepository{
  Future<Either<Failure,Category>> getCategory();
  Future<Either<Failure,Category>> getCategoryInfo(int id);
}