import 'package:ecommerce_clean_arch/authentication/presentation/controller/login_cubit/login_cubit.dart';
import 'package:ecommerce_clean_arch/core/network_helper/dio_helper.dart.dart';
import 'package:ecommerce_clean_arch/core/resources/strings_manger/strings_manager.dart';
import 'package:ecommerce_clean_arch/user/data/models/profile_model.dart';

import '../../../../authentication/data/data_source/remote_data_source/error_message_model.dart';
import '../../../../error/exception.dart';

abstract class BaseProfileDataSource{
  Future<ProfileModel> getProfile();
}

class ProfileDataSource extends BaseProfileDataSource{
  @override
  Future<ProfileModel> getProfile() async{
    final response = await DioHelper.getData(url: UrlManager.profile,token: LoginCubit.token);
    if(response?.statusCode ==200){
      return ProfileModel(status: response?.data['status'], id: response?.data['data']['id'], name: response?.data['data']['name'], email: response?.data['data']['email'], image: response?.data['data']['image']);
    }
    else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }

  }
  
}