import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/orders/added_order.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/orders/orders.dart';

abstract class BaseOrderRepository{
   Future<Either<Failure,Orders>> getOrders();
   Future<Either<Failure,AddedOrder>> postOrder(int addressId , int paymentMethod,bool usePoints);


}