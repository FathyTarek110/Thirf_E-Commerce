
import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/exception.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/data/data_source/remote_data_source/category_data_source.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/category/category.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_category_repository.dart';

class CategoryRepository extends BaseCategoryRepository{
  final BaseCategoriesDataSource baseCategoriesDataSource;

  CategoryRepository(this.baseCategoriesDataSource);
  @override
  Future<Either<Failure, Category>> getCategory() async {
   final result =  await baseCategoriesDataSource.getCategoryInfo();
   try{
     return Right(result);
   } on ServerException catch(e){
     return Left(ServerFailure(e.errorMessageModel.message));
   }
  }
  @override
  Future<Either<Failure, Category>> getCategoryInfo(int id) async {
    final result =  await baseCategoriesDataSource.getCategoryProducts(id);
    try{
      return Right(result);
    } on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

}