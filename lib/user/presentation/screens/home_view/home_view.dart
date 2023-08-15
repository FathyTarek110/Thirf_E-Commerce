import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/user/presentation/controller/main_layout_cubit/main_layout_cubit.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/home_view/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/color_manger/color_manager.dart';
import '../../../../core/resources/font_manger/font_manager.dart';
import '../../../../core/resources/reusable_comp/reusable_comp.dart';
import '../../../../core/resources/values_manager/values_manger.dart';
import '../../../../core/services/service_locator.dart';
import 'category_info.dart';

class ProductsAndCatView extends StatelessWidget {
  const ProductsAndCatView({super.key});
  

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
  create: (context) => MainLayoutCubit(sl(),sl(),sl(),sl(),sl(),sl(),sl(),sl())..getCategories()..getAllProducts()..getUserCart(),
  child: BlocConsumer<MainLayoutCubit, MainLayoutState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    MainLayoutCubit cubit = MainLayoutCubit.get(context);
    return LayoutBuilder(

      builder: (BuildContext , BoxConstraints ) {
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSize.s12,),
                        Text('Categories',style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: FontSize.s22),),
                        const SizedBox(height: AppSize.s12,),

                        CarouselSlider(

                            items: [
                              ...?cubit.categories?.map((e) {
                                return buildCategoryItem(context,e['name'],(){
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>CategoryInfo(category: e,)));
                                },e['image']);
                              }).toList(
                              )
                            ], options: CarouselOptions(
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal
                        )),
                        const SizedBox(height: AppSize.s16,),
                        Text('Our Products',style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: FontSize.s22)),
                        const SizedBox(height: AppSize.s10,),
                        SizedBox(
                          height: BoxConstraints.maxHeight * 0.8,

                          child: ConditionalBuilder(condition: state is UserGetAllProductSuccess ,
                              builder: (context){
                            return GridView.builder(
                                shrinkWrap: true,
                                itemCount: cubit.products.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1/1.9,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: AppSize.s3,
                                  mainAxisSpacing: AppSize.s3,
                                ), itemBuilder: (context,index){
                              if(state is UserGetAllProductInitial){
                                return  Center(child:  CircularProgressIndicator(
                                  color: ColorManager.primary,
                                ));
                              }else{
                                return buildProductCard(context, cubit.products[index]['images'], cubit.products[index]['name'],cubit.products[index]['price'],index,(){
                                  print(cubit.products[index]['id']);
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductView(productId:cubit.products[index]['id'], tag: 'tag$index', image: cubit.products[index]['image'],)));
                                },'tag$index',cubit.products[index]['in_favorites'] ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),(){
                                  cubit.postFavouriteById(cubit.products[index]['id'],index);
                                });
                              }

                            });
                              }, fallback: (context)=>Center(
                                child: CircularProgressIndicator(color: ColorManager.primary,),
                              )
                          )
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
      },

    );
  },
),
);
  }
}