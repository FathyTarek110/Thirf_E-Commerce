
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/core/resources/color_manger/color_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/font_manger/font_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/values_manager/values_manger.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/cart_and_payment/cart_view.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/search_view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../../controller/main_layout_cubit/main_layout_cubit.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => MainLayoutCubit(sl(),sl(),sl(),sl(),sl(),sl(),sl(),sl())..getUserCart(),
  child: BlocConsumer<MainLayoutCubit, MainLayoutState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    MainLayoutCubit cubit = MainLayoutCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: GestureDetector(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const SearchView()));
            },child: Image.asset('assets/images/icons/ri_search-2-line.png',),
            )),
        title: cubit.titles[cubit.screenIndex],
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: GestureDetector(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const CartView()));
              },child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/icons/bi_cart2.png',),
                  ),

                ],
              ),
            )),
          ),
        ],
      ),
      body: cubit.screens[cubit.screenIndex],
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: cubit.screenIndex,
        selectedItemColor: ColorManager.primary,
        onTap: (index){
          cubit.changeIndex(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),activeIcon: Icon(Icons.home),label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border),activeIcon: Icon(Icons.favorite),label: 'favourites'),
          BottomNavigationBarItem(icon: Icon(Icons.person_3_outlined),activeIcon: Icon(Icons.person),label: 'profile'),

        ],
      ),
    );
  },
),
);
  }


}

