import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/cart/cart.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/cart/cart_item.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/orders/estimate_order.dart';

abstract class BaseCartRepository{
  Future<Either<Failure,CartItem>> postOrDeleteCartItem(int id);
  Future<Either<Failure,Cart>> getCart();
  Future<Either<Failure,EstimateOrder>> estimateOrder(bool usePoints,int promoCodeId);
}