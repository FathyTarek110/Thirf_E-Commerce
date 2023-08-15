import 'package:ecommerce_clean_arch/authentication/data/data_source/remote_data_source/error_message_model.dart';
import 'package:ecommerce_clean_arch/authentication/data/models/login_model.dart';
import 'package:ecommerce_clean_arch/core/network_helper/dio_helper.dart.dart';
import 'package:ecommerce_clean_arch/core/resources/strings_manger/strings_manager.dart';
import 'package:ecommerce_clean_arch/error/exception.dart';

abstract class BaseLoginRemoteDataSource{
  Future<LoginModel> postLoginInfo(String email,String password);
}
class LoginRemoteDataSource implements BaseLoginRemoteDataSource {
  @override
  Future<LoginModel> postLoginInfo(String email,String password)async{
   final response = await DioHelper.postData(url: UrlManager.login, data: {
     'email' : email,
     'password' : password
   });
   if(response?.statusCode == 200){
     return LoginModel(message: response?.data['message'],  data: response?.data?['data'], status: response?.data['status']);
   }
   else{

     throw ServerException(ErrorMessageModel.fromJson(response?.data));
   }
  }
}