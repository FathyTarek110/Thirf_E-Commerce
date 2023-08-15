import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/resources/color_manger/color_manager.dart';
import '../../../../core/resources/routes_manger/routes_manager.dart';
import '../../../../core/resources/values_manager/values_manger.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goNext();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.smokeWhite,
        ),
      ),
      body: Center(
        child: Container(
          child: Image.asset('assets/images/Thrift.png'),
        ),
      ),
    );
  }
  goNext(){
    Timer( const Duration(seconds: AppTime.s3), () { Navigator.pushReplacementNamed(context, Routes.onBoardingRoute,); });
  }
}
