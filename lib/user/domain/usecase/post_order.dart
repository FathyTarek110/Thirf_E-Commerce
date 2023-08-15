import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/orders/added_order.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_order_repository.dart';

class PostOrder{
  final BaseOrderRepository baseOrderRepository;

  PostOrder(this.baseOrderRepository);

  Future<Either<Failure,AddedOrder>> execute(int addressId , int paymentMethod,bool usePoints)async{
    return await baseOrderRepository.postOrder(addressId, paymentMethod, usePoints );
  }

}