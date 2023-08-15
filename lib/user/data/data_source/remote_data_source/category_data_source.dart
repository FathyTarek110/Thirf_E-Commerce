import 'package:ecommerce_clean_arch/authentication/data/data_source/remote_data_source/error_message_model.dart';
import 'package:ecommerce_clean_arch/authentication/presentation/controller/login_cubit/login_cubit.dart';
import 'package:ecommerce_clean_arch/core/network_helper/dio_helper.dart.dart';
import 'package:ecommerce_clean_arch/core/resources/strings_manger/strings_manager.dart';
import 'package:ecommerce_clean_arch/error/exception.dart';

import '../../models/category_model.dart';

abstract class BaseCategoriesDataSource{
  Future<CategoryModel> getCategoryInfo();
  Future<CategoryModel> getCategoryProducts(int id);
}
class CategoryDataSource extends BaseCategoriesDataSource{
  @override
  Future<CategoryModel> getCategoryInfo() async{
    final response =  await DioHelper.getData(url: UrlManager.categories,token: LoginCubit.token);
    if(response?.statusCode == 200){
      return CategoryModel(status: response?.data['status'], data: response?.data['data']);
    }
    else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }

  }

  @override
  Future<CategoryModel> getCategoryProducts(int id)async {
    final response =  await DioHelper.getData(url: '${UrlManager.categories}/$id',token: LoginCubit.token);
    if(response?.statusCode == 200){
      return CategoryModel(status:response?.data['status'], data: response?.data['data']);
    }
    else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }
  
}