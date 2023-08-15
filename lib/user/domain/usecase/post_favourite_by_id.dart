import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/favourite/favourite.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base-product-repository.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_favourite_repository.dart';

import '../../../error/failure.dart';
import '../entities/product/product.dart';

class PostFavouriteProductById{
  final BaseFavouriteRepository baseFavouriteRepository;

  PostFavouriteProductById(this.baseFavouriteRepository);
  Future<Either<Failure, Favourite>> execute(int id)async{
    return  await baseFavouriteRepository.addFavouriteById(id);
  }

}