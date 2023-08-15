import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/cart/cart.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_cart_repository.dart';

class GetCart{
  final BaseCartRepository baseCartRepository;

  GetCart(this.baseCartRepository);

  Future<Either<Failure,Cart>> execute()async{
    return await baseCartRepository.getCart();
  }
}