
import 'package:flutter/material.dart';

import '../../../../core/resources/color_manger/color_manager.dart';
import '../../../../core/resources/routes_manger/routes_manager.dart';
import '../../../../core/resources/values_manager/values_manger.dart';


class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  const EdgeInsets.all(AppPadding.p20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/10,),
            Text('Your Shopping Is Way Easier With Thrift',style: Theme.of(context).textTheme.bodyLarge,),
            const SizedBox(height: AppSize.s10,),
            Text('The best simple place to find everything you want at a competitive price',style: Theme.of(context).textTheme.bodySmall,),
            Image.asset('assets/images/Catalogue-bro.png'),

           ElevatedButton(onPressed: (){
             //todo make this page appear only one time
             Navigator.pushReplacementNamed(context, Routes.loginRoute);
           },child: Center(child: Text('Get Started',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.white),),),)


          ],
        ),
      ),
    );
  }
}
