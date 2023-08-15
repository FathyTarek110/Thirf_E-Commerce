import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/exception.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/data/data_source/remote_data_source/cart_data_source.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/cart/cart.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/cart/cart_item.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/orders/estimate_order.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_cart_repository.dart';

class CartRepository extends BaseCartRepository{

  final BaseCartDataSource baseCartDataSource;
  CartRepository(this.baseCartDataSource);
  @override
  Future<Either<Failure, CartItem>> postOrDeleteCartItem(int id) async{
    final result  = await baseCartDataSource.addOrDeleteCartItem(id);
    try{
      return Right(result);
    } on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, Cart>> getCart()async {
    final result = await baseCartDataSource.getCart();
    try{
      return Right(result);
    } on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, EstimateOrder>> estimateOrder(bool usePoints, int promoCodeId)async {
    final result = await baseCartDataSource.estimateOrder(usePoints, promoCodeId);
    try{
      return Right(result);
    } on ServerException catch(e){
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }


}