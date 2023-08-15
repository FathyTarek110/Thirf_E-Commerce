import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/product/product.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base-product-repository.dart';

class GetAllProductsResponse{
  final BaseProductRepository baseProductRepository;

  GetAllProductsResponse(this.baseProductRepository);
  Future<Either<Failure,Product>> execute(){
    return baseProductRepository.getAllProducts();
  }

}