import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_category_repository.dart';

import '../entities/category/category.dart';

class GetCategoryResponse{
  final BaseCategoryRepository baseCategoryRepository;

  GetCategoryResponse(this.baseCategoryRepository);
 Future<Either<Failure,Category>> execute()async{
  return await baseCategoryRepository.getCategory();
 }
}