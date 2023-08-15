import 'package:ecommerce_clean_arch/authentication/data/data_source/remote_data_source/error_message_model.dart';
import 'package:ecommerce_clean_arch/authentication/presentation/controller/login_cubit/login_cubit.dart';
import 'package:ecommerce_clean_arch/core/network_helper/dio_helper.dart.dart';
import 'package:ecommerce_clean_arch/core/resources/strings_manger/strings_manager.dart';
import 'package:ecommerce_clean_arch/error/exception.dart';

import '../../models/product_model.dart';
import '../../models/product_search_model.dart';

abstract class BaseProductDataSource{
  Future<ProductModel> getProductInfo(int id);
  Future<ProductModel> getAllProducts();
  Future<ProductSearchModel> getProductSearch(query);
}
class ProductDataSource extends BaseProductDataSource {
  @override
  Future<ProductModel> getProductInfo(int id) async{
    final response = await DioHelper.getData(url: 'products/$id',token: LoginCubit.token) ;
    if(response?.statusCode == 200){
      print(response?.data['data']);
      return ProductModel.fromJson(response?.data);
    }
    else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }


  @override
  Future<ProductModel> getAllProducts()async {
    final response = await DioHelper.getData(url: UrlManager.home,token: LoginCubit.token);
    if(response?.statusCode == 200){
      return ProductModel.fromJson(response?.data);
    }
    else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
    }

  @override
  Future<ProductSearchModel> getProductSearch(query)async {
    final response = await DioHelper.postData(url: '${UrlManager.products}/${UrlManager.search}', data: {
      'text' : query
    },token: LoginCubit.token);
    if(response?.statusCode == 200){
      return ProductSearchModel.fromJson(response?.data);
    }
    else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }

  }
