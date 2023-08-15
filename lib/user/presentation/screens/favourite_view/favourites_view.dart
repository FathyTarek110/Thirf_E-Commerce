import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/core/resources/font_manger/font_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/reusable_comp/reusable_comp.dart';
import 'package:ecommerce_clean_arch/core/resources/values_manager/values_manger.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/home_view/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/color_manger/color_manager.dart';
import '../../../../core/services/service_locator.dart';
import '../../controller/main_layout_cubit/main_layout_cubit.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => MainLayoutCubit(sl(),sl(),sl(),sl(),sl(),sl(),sl(),sl())..getFavourite(),
  child: BlocConsumer<MainLayoutCubit, MainLayoutState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    MainLayoutCubit cubit = MainLayoutCubit.get(context);
    return ConditionalBuilder(
        condition: state is GetFavouriteSuccess,
        builder: (context)=> cubit.favourites.isNotEmpty ?ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: cubit.favourites.length,
            itemBuilder: (context,index){
              return buildFavouriteAndCartContainer( context: context,isCart: false, name: cubit.favourites[index]['product']['name'], price: cubit.favourites[index]['product']['price'], image: cubit.favourites[index]['product']['image'],id:cubit.favourites[index]['product']['id'], crossImageFunction: () {
                cubit.deleteFavouriteById(cubit.favourites[index]['product']['id'], index);
              }, shoppingBagImage: () {
                cubit.favourites[index]['product']['in_cart'] == false? cubit.postAddProductToCart(cubit.favourites[index]['product']['id']):myToast('Item Already in Cart', ColorManager.primary);
              }, plusSignCart: null, minusSignCart: null, quantity: null, );
            }):Center(child: Column(
              children: [
                Image.asset('assets/images/Online wishes list.gif'),
                Text('No Items In Your Favourites List Yet')
              ],
            ),),
        fallback: (context)=>Center(child: CircularProgressIndicator(color: ColorManager.primary,)));
  },
),
);
  }


}