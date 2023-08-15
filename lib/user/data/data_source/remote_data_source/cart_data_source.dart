import 'package:ecommerce_clean_arch/authentication/data/data_source/remote_data_source/error_message_model.dart';
import 'package:ecommerce_clean_arch/authentication/presentation/controller/login_cubit/login_cubit.dart';
import 'package:ecommerce_clean_arch/core/network_helper/dio_helper.dart.dart';
import 'package:ecommerce_clean_arch/core/resources/strings_manger/strings_manager.dart';
import 'package:ecommerce_clean_arch/error/exception.dart';
import 'package:ecommerce_clean_arch/user/data/models/cartItem_model.dart';
import 'package:ecommerce_clean_arch/user/data/models/cart_model.dart';

import '../../models/estimate_order_model.dart';

abstract class BaseCartDataSource{
  Future<CartItemModel> addOrDeleteCartItem(int id);
  Future<CartModel> getCart();
  Future<EstimateOrderModel> estimateOrder(bool usePoints,promoCodeId);
}
class CartDataSource extends BaseCartDataSource{
  @override
  Future<CartItemModel> addOrDeleteCartItem(int id)async {
    final response = await DioHelper.postData(url: UrlManager.carts, data: {
      "product_id": id
    },token: LoginCubit.token);
    if(response?.statusCode ==200){
      return CartItemModel( cartId: response?.data['data']['id'], productId: response?.data['data']['product']['id'], price: response?.data['data']['product']['price'], image: response?.data['data']['product']['image']);
    }else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }

  @override
  Future<CartModel> getCart() async{
    final response =  await DioHelper.getData(url: UrlManager.carts,token: LoginCubit.token);
    if(response?.statusCode == 200){
      return CartModel(status: response?.data['status'], cartItems: response?.data['data']['cart_items'], total: response?.data['data']['sub_total']);
    }
    else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }

  @override
  Future<EstimateOrderModel> estimateOrder(bool usePoints, promoCodeId) async{
    final response = await DioHelper.postData(url: UrlManager.estimateOrder, data: {
      'use_points' : usePoints,
      'promo_code_id': promoCodeId
    },token: LoginCubit.token);
    if(response?.statusCode == 200){
      return EstimateOrderModel.fromJson(response?.data);
    }
    else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }
  
}