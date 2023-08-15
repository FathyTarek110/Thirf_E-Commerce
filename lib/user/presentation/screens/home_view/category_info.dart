import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/core/resources/font_manger/font_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/values_manager/values_manger.dart';
import 'package:ecommerce_clean_arch/user/presentation/controller/category_info_cubit/category_info_cubit.dart';
import 'package:ecommerce_clean_arch/user/presentation/controller/main_layout_cubit/main_layout_cubit.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/home_view/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/color_manger/color_manager.dart';
import '../../../../core/resources/reusable_comp/reusable_comp.dart';
import '../../../../core/services/service_locator.dart';

class CategoryInfo extends StatelessWidget {
  const CategoryInfo({super.key, required this.category,});
  final Map<String,dynamic> category;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => CategoryInfoCubit(sl(),sl(),sl())..scrollControllerInit()..getCategoryInfoById(category['id'])..getCartBottomSheet(),
  child: BlocConsumer<CategoryInfoCubit, CategoryInfoState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    CategoryInfoCubit cubit = CategoryInfoCubit.get(context);
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: CustomScrollView(
        controller: cubit.scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back),color: ColorManager.primary,splashColor: Colors.transparent,),
            title: Text(category['name'],style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.primary),),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent
            ),
          ),
          SliverToBoxAdapter(
            child:  Container(
              decoration:  BoxDecoration(
                  color: ColorManager.smokeWhite,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(AppSize.s30),bottomRight: Radius.circular(AppSize.s30))
              ),
              height: MediaQuery.of(context).size.height/1.3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConditionalBuilder(
                    condition: cubit.categoryProducts.isNotEmpty,
                    builder: (_)=>GridView.builder(
                        itemCount: cubit.categoryProducts.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1/1.9,
                          crossAxisCount: 2,
                          crossAxisSpacing: AppSize.s3,
                          mainAxisSpacing: AppSize.s3,
                        ), itemBuilder: (context,index){

                          return buildProductCard(context, cubit.categoryProducts[index]['images'], cubit.categoryProducts[index]['name'],cubit.categoryProducts[index]['price'],index,
                                  ()async{print(cubit.categoryProducts[index]['id']);
                              await Navigator.push(context, MaterialPageRoute(builder: (_) {
                                return ProductView(productId:cubit.categoryProducts[index]['id'], tag: 'tag$index', image: cubit.categoryProducts[index]['image'],);
                              },)).then((value) {
                                cubit.getCartBottomSheet();
                              });},
                              'tag$index',cubit.categoryProducts[index]['in_favorites'] ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),(){
                                cubit.postFavouriteById(cubit.categoryProducts[index]['id'], index);
                              });
                    }),
                    fallback: (_)=>Center(child:  CircularProgressIndicator(
                      color: ColorManager.primary,
                    )))
              ),
            ),
          ),
          SliverToBoxAdapter(
            child:  Container(
              height: MediaQuery.of(context).size.height/1.1,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorManager.primary
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Cart',style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.white),),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/10,
                        ),
                        if(cubit.midScroll == false ) Container(
                          width: MediaQuery.of(context).size.width/2.5,
                          height: MediaQuery.of(context).size.height/12,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.cartItems.length,
                              shrinkWrap: true,
                              itemBuilder: (context,index)=>Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: ColorManager.primary,
                                  backgroundImage: NetworkImage(cubit.cartItems[index]['product']['image'],),
                                ),
                              )),
                        ),
                        const Spacer(),
                        if(cubit.midScroll == false ) CircleAvatar(
                          radius: MediaQuery.of(context).size.width/15,
                          backgroundColor: ColorManager.smokeWhite,
                          child: Text('${cubit.cartItems.length}',style: Theme.of(context).textTheme.bodyLarge,),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: AppSize.s16,
                    ),
                    if(cubit.midScroll == true ) Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Container(
                            width:double.infinity,
                            height: MediaQuery.of(context).size.height/1.8,
                            decoration: BoxDecoration(
                              color: ColorManager.smokeWhite,
                              borderRadius: BorderRadius.circular(AppSize.s30)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: cubit.cartItems.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context,index)=>Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: MediaQuery.of(context).size.height/16,
                                            backgroundColor: ColorManager.primary,
                                            backgroundImage: NetworkImage(cubit.cartItems[index]['product']['image'],),
                                          ),
                                          const SizedBox(
                                            width: AppSize.s10,
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(cubit.cartItems[index]['quantity'].toString()),
                                              const SizedBox(
                                                width: AppSize.s10,
                                              ),
                                              Text('x'),
                                              const SizedBox(
                                                width: AppSize.s10,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width/4,
                                                  child: Text(cubit.cartItems[index]['product']['name'],style: Theme.of(context).textTheme.bodySmall?.copyWith( color: ColorManager.primary),maxLines: 3,overflow: TextOverflow.ellipsis,)),
                                              const SizedBox(
                                                width: AppSize.s20,
                                              ),
                                              Text(cubit.cartItems[index]['product']['price'].toString(),style: Theme.of(context).textTheme.bodySmall,)


                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height/15,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text('Total',style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.white),),
                                  Text('(without VAT )',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.white,fontSize: FontSize.s12),),

                                ],
                              ),
                              const Spacer(),
                              Text(cubit.cartTotal.toString(),style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.white),),
                              const SizedBox(width: AppSize.s10,),
                              Text('EGP',style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.white),),

                            ],
                          ),

                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorManager.white,
                                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(AppSize.s30))
                                  ),
                                  onPressed: (){}, child:  Text('Next',style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.primary),)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),



                  ],
                ),
              ),
            ),
          )
        ],
      )

    );
  },
),
);
  }


}

