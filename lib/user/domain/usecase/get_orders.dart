import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/orders/orders.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_order_repository.dart';

class GetOrders{
  final BaseOrderRepository baseOrderRepository;

  GetOrders(this.baseOrderRepository);

  Future<Either<Failure,Orders>> execute()async{
   return await baseOrderRepository.getOrders();
  }

}