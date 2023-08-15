import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/authentication/domain/usecase/get_login_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_clean_arch/core/services/service_locator.dart';
import '../../../../core/resources/color_manger/color_manager.dart';
import '../../../../core/resources/font_manger/font_manager.dart';
import '../../../../core/resources/reusable_comp/reusable_comp.dart';
import '../../../../core/resources/routes_manger/routes_manager.dart';
import '../../../../core/resources/values_manager/values_manger.dart';
import '../../controller/login_cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => LoginCubit(sl()),
  child: BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    LoginCubit cubit = LoginCubit.get(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding:  const EdgeInsets.all(AppPadding.p16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Hello!',style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: FontSize.s26),),
                Text('Welcome To Thrift',style: Theme.of(context).textTheme.bodyLarge,),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height/10,),
                          myTextFormField(context: context,textInputType: TextInputType.emailAddress ,controller: cubit.emailTextEditingController, label: 'E-Mail', obscure: false, enableSuggestions: true, autoCorrect: false,validate: (value){
                          if(value.isEmpty){
                            return 'please enter your email address';
                          }
                          }),



                          const SizedBox(height: AppSize.s18,),
                          myTextFormField(context: context,
                              validate: (value){
                                if(value.isEmpty){
                                  return 'password is too short';
                                }
                              }
                              ,controller: cubit.passwordTextEditingController,textInputType: TextInputType.visiblePassword ,label: 'Password',obscure: LoginCubit.obscure, enableSuggestions: false, autoCorrect: false,suffixIcon: IconButton(onPressed: (){
                            cubit.visibility();
                          }, icon: LoginCubit.obscure ?Icon(Icons.visibility,color: ColorManager.primary,) : Icon(Icons.visibility_off,color: ColorManager.primary,))),



                          const SizedBox(height: AppSize.s18,),



                          TextButton(onPressed: (){
                                Navigator.pushNamed(context, Routes.forgetPasswordRoute);
                          }, child:  Text('Forgot Password',style: Theme.of(context).textTheme.bodyMedium)),
                          const SizedBox(height: AppSize.s8,),



                          ConditionalBuilder(
                            condition: state is! UserLoginLoadingState,
                            builder:(_)=>buildMyButton(context,'Log In',(){
                              if(cubit.formKey.currentState!.validate()){
                                cubit.userLogin(email: cubit.emailTextEditingController.text, password: cubit.passwordTextEditingController.text,context: context);
                              }
                            }) ,
                            fallback:  (BuildContext context) {
                              return Center(child: CircularProgressIndicator(color: ColorManager.primary,),);
                            },
                          ),



                          const SizedBox(height: AppSize.s8,),

                          TextButton(onPressed: (){
                            Navigator.pushNamed(context, Routes.signUpRoute);
                          }, child:  Text('Sign Up',style: Theme.of(context).textTheme.bodyMedium)),

                        ],
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  },
),
);
  }


}
