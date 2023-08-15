import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/product/product.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base-product-repository.dart';

class GetProductResponse{
  final BaseProductRepository baseProductRepository;

  GetProductResponse(this.baseProductRepository);
  Future<Either<Failure,Product>> execute(int id)async{
    return  await baseProductRepository.getProduct(id);
  }
}