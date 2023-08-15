import 'package:ecommerce_clean_arch/core/resources/color_manger/color_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/reusable_comp/reusable_comp.dart';
import 'package:ecommerce_clean_arch/core/resources/values_manager/values_manger.dart';
import 'package:flutter/material.dart';

class ForgetPassWordView extends StatelessWidget {
  const ForgetPassWordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back),color: ColorManager.primary,splashColor: Colors.transparent,),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              myTextFormField(context: context, controller: TextEditingController(), label: 'enter your email', obscure: false, enableSuggestions: false, autoCorrect: false),
              const SizedBox(height: AppSize.s12,),
              Container(
                width: double.infinity,
                child: buildMyButton(context, 'send code', () { }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
