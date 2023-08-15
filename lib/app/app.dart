import 'package:flutter/material.dart';

import '../core/resources/routes_manger/routes_manager.dart';
import '../core/resources/theme_manager/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      //todo initial route
      theme: appTheme(),
    );
  }
}
