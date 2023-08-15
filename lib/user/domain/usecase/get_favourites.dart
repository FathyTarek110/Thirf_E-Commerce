import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_favourite_repository.dart';

import '../../../error/failure.dart';
import '../entities/favourite/favourite.dart';

class GetFavourites{
  final BaseFavouriteRepository baseFavouriteRepository;

  GetFavourites(this.baseFavouriteRepository);

  Future<Either<Failure, Favourite>> execute(){
    return baseFavouriteRepository.getFavourites();
  }
}