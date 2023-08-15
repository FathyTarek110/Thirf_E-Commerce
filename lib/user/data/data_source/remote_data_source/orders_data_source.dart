import 'package:ecommerce_clean_arch/authentication/data/data_source/remote_data_source/error_message_model.dart';
import 'package:ecommerce_clean_arch/authentication/presentation/controller/login_cubit/login_cubit.dart';
import 'package:ecommerce_clean_arch/core/network_helper/dio_helper.dart.dart';
import 'package:ecommerce_clean_arch/core/resources/strings_manger/strings_manager.dart';
import 'package:ecommerce_clean_arch/error/exception.dart';

import '../../models/added_order_model.dart';
import '../../models/orders_model.dart';

abstract class BaseOrdersDataSource{
  Future<OrdersModel> getOrders();
  Future<AddedOrderModel> postOrder(int addressId , int paymentMethod,bool usePoints);
}


class OrdersDataSource extends BaseOrdersDataSource{
  @override
  Future<OrdersModel> getOrders() async{
    final response = await DioHelper.getData(url: UrlManager.orders,token: LoginCubit.token );
    if(response?.statusCode == 200){
      return OrdersModel.fromJson(response?.data);
    }
    else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }

  @override
  Future<AddedOrderModel> postOrder(int addressId , int paymentMethod,bool usePoints) async{
    final response = await DioHelper.postData(url: UrlManager.orders, data: {
      'address_id':addressId,
      'payment_method':paymentMethod,
      'use_points':usePoints,
    },token: LoginCubit.token);
    if(response?.statusCode == 200){
      return AddedOrderModel.fromJson(response?.data);
    }
    else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }
  
}