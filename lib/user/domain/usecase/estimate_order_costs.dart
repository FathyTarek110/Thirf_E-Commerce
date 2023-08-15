import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/orders/estimate_order.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_cart_repository.dart';

class EstimateOrderCost{
  final  BaseCartRepository baseCartRepository;

  EstimateOrderCost(this.baseCartRepository);

  Future<Either<Failure,EstimateOrder>> execute(bool usePoints,int promoCodeId) async{
    return await baseCartRepository.estimateOrder(usePoints, promoCodeId);
}
}