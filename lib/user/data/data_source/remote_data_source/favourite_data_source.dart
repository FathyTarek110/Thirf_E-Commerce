import 'package:ecommerce_clean_arch/authentication/data/data_source/remote_data_source/error_message_model.dart';
import 'package:ecommerce_clean_arch/authentication/presentation/controller/login_cubit/login_cubit.dart';
import 'package:ecommerce_clean_arch/error/exception.dart';
import 'package:ecommerce_clean_arch/user/data/models/favourite_model.dart';

import '../../../../core/network_helper/dio_helper.dart.dart';
import '../../../../core/resources/strings_manger/strings_manager.dart';

abstract class BaseFavouriteDataSource{
  Future<FavouriteModel> postFavouriteWithId(int id);
  Future<FavouriteModel> getFavourites();
}

class FavouriteDataSource extends BaseFavouriteDataSource{
  @override
  Future<FavouriteModel> postFavouriteWithId(int id) async{
    final response = await DioHelper.postData(url: UrlManager.favorites, data: {
      'product_id' : id
    },token: LoginCubit.token);
    if(response?.statusCode == 200){
      return FavouriteModel(response?.data['data'], response?.data['status'], response?.data['message']);
    }
    else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }

  @override
  Future<FavouriteModel> getFavourites() async{
    final response = await DioHelper.getData(url: UrlManager.favorites,token: LoginCubit.token);
    if(response?.statusCode == 200){
      return FavouriteModel(response?.data['data'], response?.data['status'], response?.data['message']);;
    }
    else {
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }



}