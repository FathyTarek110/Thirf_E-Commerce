import 'package:ecommerce_clean_arch/authentication/domain/usecase/get_login_response.dart';
import 'package:ecommerce_clean_arch/core/cache_helper/cache_helper.dart';
import 'package:ecommerce_clean_arch/core/resources/color_manger/color_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/reusable_comp/reusable_comp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/routes_manger/routes_manager.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.getLoginResponse) : super(LoginInitial());
  var formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final GetLoginResponse getLoginResponse ;
  static bool obscure = true;
  bool? status;
  Map<String,dynamic>? data;
  String? message;
  static String? token;

  static LoginCubit get(context) => BlocProvider.of(context);

  void visibility() {
    LoginCubit.obscure =! LoginCubit.obscure;
    print(LoginCubit.obscure);
    emit(LoginChangeIcon());
  }
  
  userLogin({required String email,required String password,required BuildContext context})async{
    emit(UserLoginLoadingState());
    final result = await getLoginResponse.execute(email, password);
    result.fold((l) {
      emit(UserLoginErrorState());
      return message = l.message;

    }, (r) {
      data = r.data;
      status = r.status;
      if(status == true){
        token = r.data?['token'];
        print(token);
        CacheHelper.insertText(key: 'token', value: r.data?['token']);
        myToast(r.message,ColorManager.green);
        Navigator.pushReplacementNamed(context, Routes.mainLayout);
      }
      else{
        myToast(r.message,ColorManager.red);
      }
      emit(UserLoginSuccessState());
    });
}
}
