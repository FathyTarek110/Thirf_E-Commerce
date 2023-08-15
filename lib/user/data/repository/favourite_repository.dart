import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/exception.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/data/data_source/remote_data_source/favourite_data_source.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/favourite/favourite.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_favourite_repository.dart';

class FavouriteRepository extends BaseFavouriteRepository{
  final BaseFavouriteDataSource baseFavouriteDataSource;

  FavouriteRepository(this.baseFavouriteDataSource);

  @override
  Future<Either<Failure, Favourite>> addFavouriteById(int id)async {
    final result = await baseFavouriteDataSource.postFavouriteWithId(id);
    try{
      return Right(result);
    } on ServerException catch(e){
      return left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, Favourite>> getFavourites() async{
    final result =  await baseFavouriteDataSource.getFavourites();
    try{
      return Right(result);
    } on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }
}