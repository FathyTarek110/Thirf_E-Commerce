import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/product/product.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/product/search.dart';

abstract class BaseProductRepository{
  Future<Either<Failure,Product>> getProduct(int id);
  Future<Either<Failure,Product>> getAllProducts();
  Future<Either<Failure,ProductSearch>> searchForProduct(String query);
}