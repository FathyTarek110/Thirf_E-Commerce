import 'package:ecommerce_clean_arch/core/cache_helper/cache_helper.dart';
import 'package:ecommerce_clean_arch/core/services/service_locator.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/network_helper/dio_helper.dart.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  ServiceLocator().init();
  DioHelper.init();
  runApp(const MyApp());
}

