import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/cart/cart_item.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_cart_repository.dart';

class PostOrDeleteCartItem{
  final BaseCartRepository baseCartRepository;

  PostOrDeleteCartItem(this.baseCartRepository);
  Future<Either<Failure,CartItem>> execute(int id)async{
    return await baseCartRepository.postOrDeleteCartItem(id);
  }
}