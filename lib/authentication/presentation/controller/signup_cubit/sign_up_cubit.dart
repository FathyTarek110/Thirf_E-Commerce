import 'package:ecommerce_clean_arch/authentication/domain/usecase/get_signup_response.dart';
import 'package:ecommerce_clean_arch/core/resources/color_manger/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/reusable_comp/reusable_comp.dart';


part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.getSignUpResponse) : super(SignUpInitial());
  static bool obscure = true;
  static bool obscureConfirmation = true;
  var formKey = GlobalKey<FormState>();
  final GetSignUpResponse getSignUpResponse;
  static SignUpCubit get(context)=>BlocProvider.of(context);
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();



  
  userSignUp({required String name,required String email,required String phone,required String password,required BuildContext context})async{
    emit(UserSignUpLoadingState());
    final response = await getSignUpResponse.execute(name: name, email: email, password: password, phone: phone);
    response.fold((l) {
      myToast(l.message,ColorManager.red);
      emit(UserSignUpErrorState());
    }, (r) {
      if(r.status == true){
        myToast(r.message,ColorManager.green);
        Navigator.pop(context);
        emit(UserSignUpSuccessState());
      } else{
        myToast(r.message,ColorManager.red);
        emit(UserSignUpErrorState());
      }


    });
  }

  void visibility() {
    SignUpCubit.obscure =! SignUpCubit.obscure;
    print(SignUpCubit.obscure);
    emit(SignUpChangeIcon());
  }
  void visibilityConfirmation() {
    SignUpCubit.obscureConfirmation =! SignUpCubit.obscureConfirmation;
    print(SignUpCubit.obscureConfirmation);
    emit(SignUpChangeIcon());
  }
  
}
