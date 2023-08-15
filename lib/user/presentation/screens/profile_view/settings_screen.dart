import 'package:ecommerce_clean_arch/core/resources/font_manger/font_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/values_manager/values_manger.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/color_manger/color_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.email, required this.name});
  final String email;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:  Icon(Icons.arrow_back,color: ColorManager.primary,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( 'Personal Information',style:Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: FontSize.s20,color: ColorManager.gray),),
                  const Spacer(),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.edit))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyContainer(string: name , title: 'name', isHelpCenter: false,),
                    SizedBox(height: 10,),
                    MyContainer(string: email , title: 'email', isHelpCenter: false,),
                    SizedBox(height: 10,),
                    const MyContainer(string: '********' , title: 'Password', isHelpCenter: false,),
                    SizedBox(height: 10,),

                    MyContainer(string: '', title: 'Logout', isHelpCenter: true)

                  ],
                ),


              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( 'Help Center',style:Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: FontSize.s20,color: ColorManager.gray),),],
              ),
               const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyContainer(string: '', title: 'FAQ', isHelpCenter: true),
                    SizedBox(height: 10,),

                    MyContainer(string:'' , title: 'Contact US', isHelpCenter: true),
                    SizedBox(height: 10,),

                    MyContainer(string: '', title: 'Privacy Terms', isHelpCenter: true),


                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}

class MyContainer extends StatelessWidget {

  final String string;
  final String title;
  final bool isHelpCenter;

  const MyContainer({super.key, required this.string, required this.title, required this.isHelpCenter});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s16)
      ),
      width: double.infinity,
      child: isHelpCenter ?  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text( title,style:Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: FontSize.s16,color: ColorManager.primary),),
            const Spacer(),
            IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_right_rounded,color: ColorManager.primary,),splashColor: Colors.transparent,)

          ],
        ),
      ) :Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text( title,style:Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: FontSize.s16,color: ColorManager.gray),),
            Text( string,style:Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: FontSize.s20,color: ColorManager.primary),),

          ],
        ),
      ),
    );
  }
}
