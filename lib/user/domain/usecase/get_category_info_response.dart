import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/category/category.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_category_repository.dart';

import '../../../error/failure.dart';

class GetCategoryInfoResponse{
 final BaseCategoryRepository baseCategoryRepository;

  GetCategoryInfoResponse(this.baseCategoryRepository);
  Future<Either<Failure,Category>> execute(int id) async{
    return await baseCategoryRepository.getCategoryInfo(id);
  }
}