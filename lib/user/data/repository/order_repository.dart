import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';
import 'package:ecommerce_clean_arch/user/data/data_source/remote_data_source/orders_data_source.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/orders/added_order.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/orders/orders.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_order_repository.dart';

import '../../../error/exception.dart';

class OrderRepository extends BaseOrderRepository{
  final BaseOrdersDataSource baseOrdersDataSource;
  @override
  OrderRepository(this.baseOrdersDataSource);
  Future<Either<Failure, Orders>> getOrders() async{
    final result = await baseOrdersDataSource.getOrders();
    try{
      return Right(result);
    } on ServerException catch(e){
      return left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, AddedOrder>> postOrder(int addressId, int paymentMethod, bool usePoints) async{
    final result = await baseOrdersDataSource.postOrder(addressId, paymentMethod, usePoints);
    try{
      return Right(result);
    }on ServerException catch(e){
      return left(ServerFailure(e.errorMessageModel.message));
    }
  }

}