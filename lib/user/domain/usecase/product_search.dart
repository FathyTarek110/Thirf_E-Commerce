import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/product/search.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base-product-repository.dart';

class GetProductSearch{
  final BaseProductRepository baseProductRepository;

  GetProductSearch(this.baseProductRepository);

  Future<Either<Failure,ProductSearch>> execute(String query)async{
    return await baseProductRepository.searchForProduct(query);
  }
}