import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/color_manger/color_manager.dart';
import '../../../../core/resources/reusable_comp/reusable_comp.dart';
import '../../../../core/resources/values_manager/values_manger.dart';
import '../../../../core/services/service_locator.dart';
import '../../controller/signup_cubit/sign_up_cubit.dart';


class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(sl()),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          SignUpCubit cubit = SignUpCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: () {
                Navigator.pop(context);
              },
                icon: Icon(Icons.arrow_back,color: ColorManager.primary,),

              ),
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('WELCOME',style: Theme.of(context).textTheme.bodyLarge,),

                    Padding(
                      padding:  const EdgeInsets.all(AppPadding.p16),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: Form(
                            key: cubit.formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                const SizedBox(
                                  height: AppSize.s16,
                                ),
                                myTextFormField(context: context,textInputType: TextInputType.text ,controller: cubit.nameTextEditingController, label: 'name', obscure: false, enableSuggestions: true, autoCorrect: false,validate: (value){
                                  if(value.isEmpty){
                                    return 'please enter your name';
                                  }
                                }),
                                const SizedBox(
                                  height: AppSize.s16,
                                ),

                                myTextFormField(context: context,textInputType: TextInputType.emailAddress ,controller: cubit.emailTextEditingController, label: 'E-Mail', obscure: false, enableSuggestions: true, autoCorrect: false,validate: (value){
                                  if(value.isEmpty){
                                    return 'please enter your email address';
                                  }
                                }),
                                const SizedBox(
                                  height: AppSize.s16,
                                ),

                                myTextFormField(context: context,textInputType: TextInputType.phone ,controller: cubit.phoneTextEditingController, label: 'Phone', obscure: false, enableSuggestions: true, autoCorrect: false,validate: (value){
                                  if(value.isEmpty){
                                    return 'please enter your Mobile Number';
                                  }
                                }),
                                const SizedBox(
                                  height: AppSize.s16,
                                ),



                                myTextFormField(context: context,
                                    validate: (value){
                                      if(value.isEmpty){
                                        return 'password is too short';
                                      }
                                    }
                                    ,controller: cubit.confirmPasswordTextEditingController,textInputType: TextInputType.visiblePassword ,label: 'Password',obscure: SignUpCubit.obscure, enableSuggestions: false, autoCorrect: false,suffixIcon: IconButton(onPressed: (){
                                      cubit.visibility();
                                    }, icon: SignUpCubit.obscure ?Icon(Icons.visibility,color: ColorManager.primary,) : Icon(Icons.visibility_off,color: ColorManager.primary,))),


                                const SizedBox(
                                  height: AppSize.s16,
                                ),


                                myTextFormField(context: context,
                                    validate: (value){
                                      if(value != cubit.passwordTextEditingController.value.text ){
                                        return 'the two passwords don\'t match';
                                      }
                                    }
                                    ,controller: cubit.passwordTextEditingController,textInputType: TextInputType.visiblePassword ,label: 'Confirm Password',obscure: SignUpCubit.obscure, enableSuggestions: false, autoCorrect: false,suffixIcon: IconButton(onPressed: (){
                                      cubit.visibility();
                                    }, icon: SignUpCubit.obscureConfirmation ? Icon(Icons.visibility,color: ColorManager.primary,) : Icon(Icons.visibility_off,color: ColorManager.primary,))),
                                const SizedBox(
                                  height: AppSize.s30,
                                ),
                                ConditionalBuilder(
                                  condition: state is! UserSignUpLoadingState,
                                  builder:(_)=>buildMyButton(context,'Sign Up',(){
                                    if(cubit.formKey.currentState!.validate()){
                                      cubit.userSignUp(name: cubit.nameTextEditingController.text,phone: cubit.phoneTextEditingController.text,email: cubit.emailTextEditingController.text, password: cubit.passwordTextEditingController.text, context: context);

                                    }
                                  }) ,
                                  fallback:  (BuildContext context) {
                                    return Center(child: CircularProgressIndicator(color: ColorManager.primary,),);
                                  },
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Already Have Account',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.gray),),
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child:  Text('Log In',style: Theme.of(context).textTheme.bodyMedium)),
                                  ],
                                )


                              ],
                            ),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
