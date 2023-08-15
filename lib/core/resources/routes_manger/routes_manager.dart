
import 'package:flutter/material.dart';

import '../../../authentication/presentation/screens/forgetpassword_view/forgetpassword_view.dart';
import '../../../authentication/presentation/screens/login_view/login_view.dart';
import '../../../authentication/presentation/screens/onBoadring_view/onBoarding_view.dart';
import '../../../authentication/presentation/screens/signup_view/signup_view.dart';
import '../../../authentication/presentation/screens/splash/splash_view.dart';
import '../../../user/presentation/screens/main_layout/main_layout.dart';


class Routes{
  static const String splashRoute="/";
  static const String onBoardingRoute="/onBoarding_view";
  static const String loginRoute="/login_view";
  static const String forgetPasswordRoute="/forgetpassword_view";
  static const String signUpRoute="/signup_view";
  static const String mainLayout='/main_layout';
}

class RouteGenerator{

  static Route<dynamic> getRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_)=> const SplashView());

      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_)=> const OnBoarding());


      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_)=> const LoginView());


      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_)=> const ForgetPassWordView());

      case Routes.mainLayout:
        return MaterialPageRoute(builder: (_)=> const MainLayout());


      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_)=> const SignUpView());
    }
    return MaterialPageRoute(builder: (_)=> const Scaffold(
      body: Center(child: Text('error occurred  please restart the app'),),
    ));
  }

}