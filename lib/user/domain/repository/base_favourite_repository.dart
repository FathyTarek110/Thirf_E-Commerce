import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/favourite/favourite.dart';

import '../../../error/failure.dart';

abstract class BaseFavouriteRepository{
  Future<Either<Failure,Favourite>> addFavouriteById(int id);
  Future<Either<Failure,Favourite>> getFavourites();
}