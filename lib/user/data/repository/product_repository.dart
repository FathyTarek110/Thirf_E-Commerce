import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/exception.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/data/data_source/remote_data_source/product_data_source.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/product/product.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/product/search.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base-product-repository.dart';

class ProductRepository extends BaseProductRepository{
 final BaseProductDataSource baseProductDataSource;

  ProductRepository(this.baseProductDataSource);
  @override
  Future<Either<Failure, Product>> getProduct(int id) async{
    final result = await baseProductDataSource.getProductInfo(id);
    try{
      return Right(result);
    } on ServerException catch(e){
      return left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, Product>> getAllProducts() async {
    final result = await baseProductDataSource.getAllProducts();
    try{
      return Right(result);
    } on ServerException catch(e){
      return left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, ProductSearch>> searchForProduct(String query) async {
    final result = await baseProductDataSource.getProductSearch(query);
    try{
      return Right(result);
    } on ServerException catch(e){
      return left(ServerFailure(e.errorMessageModel.message));
    }
  }

}