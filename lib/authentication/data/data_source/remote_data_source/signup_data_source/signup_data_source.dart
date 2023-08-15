import 'package:ecommerce_clean_arch/authentication/data/models/signup_model.dart';
import 'package:ecommerce_clean_arch/core/network_helper/dio_helper.dart.dart';
import 'package:ecommerce_clean_arch/core/resources/strings_manger/strings_manager.dart';
import '../../../../../error/exception.dart';
import '../error_message_model.dart';
abstract class BaseSignUpDataSource{
  Future<SignUpModel> postSignUpInfo(String name,String email,String password,String phone);
}

class SignUpDataSource extends BaseSignUpDataSource{
  @override
  Future<SignUpModel> postSignUpInfo(String name,String email,String password,String phone)async{
    final response = await DioHelper.postData(url: UrlManager.register, data:
    {
      'name':name,
      'email':email,
      'password':password,
      'phone':phone
    });
    if(response?.statusCode == 200){
      return SignUpModel(message: response?.data['message'], status: response?.data['status']);
    }
    else{
      throw ServerException(ErrorMessageModel.fromJson(response?.data));
    }
  }
}