import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/core/resources/color_manger/color_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/font_manger/font_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/reusable_comp/reusable_comp.dart';
import 'package:ecommerce_clean_arch/core/resources/values_manager/values_manger.dart';
import 'package:ecommerce_clean_arch/user/presentation/controller/product_cubit/product_cubit.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/home_view/category_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/services/service_locator.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key, required this.productId, required this.tag, required this.image,});
  final int productId ;
  final String tag;
  final String image;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ProductCubit(getProductResponse: sl(), id: productId,postFavouriteProductById: sl(), postOrDeleteCartItem: sl())..getProduct(productId),
  child: BlocConsumer<ProductCubit, ProductState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    ProductCubit cubit = ProductCubit.get(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back,color: ColorManager.primary,),splashColor: Colors.transparent,),
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent),
      ),
      body: ConditionalBuilder(
          condition: state is UserGetProductSuccess || state is UserProductCartPostSuccess,
          builder: (context){
            return  Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height/1.7,
                        child: Swiper(

                          scrollDirection: Axis.horizontal,
                            itemCount: cubit.data!.images!.length,
                            itemWidth: double.infinity,
                            itemHeight: MediaQuery.of(context).size.height/1.7,
                          itemBuilder: (context,index)=>SizedBox(
                            child: Image(
                                fit: BoxFit.scaleDown,
                                image: NetworkImage(cubit.data!.images![index])),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width/2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(cubit.data?.data?['name'],style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: FontSize.s18),maxLines: 3,),
                              )),

                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: AppPadding.p8,right: AppPadding.p20 ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('price',style: Theme.of(context).textTheme.bodyMedium,),
                                SizedBox(height: AppSize.s12,),
                                Text('${cubit.data?.data?['price'].toString()} EGP',style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: FontSize.s18),)
                              ],
                            ),

                          )
                        ],

                      ),
                      const SizedBox(height: AppSize.s10,),
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description',style: Theme.of(context).textTheme.bodySmall,),
                            const SizedBox(
                              height: AppSize.s10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(child: ReadMoreText(cubit.data?.data?['description'],style: Theme.of(context).textTheme.bodySmall,trimLines: 4,trimMode: TrimMode.Line,trimCollapsedText: 'show more',trimExpandedText: 'show less',lessStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: FontSize.s16,color: ColorManager.primary),moreStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: FontSize.s16,color: ColorManager.primary),),),
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){
                      cubit.postFavouriteById(cubit.data?.data?['id']);
                    }, icon: cubit.data?.data?['in_favorites'] ? const Icon(Icons.favorite):const Icon(Icons.favorite_border,),splashColor: Colors.transparent,),
                    Expanded(child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: buildMyButton(

                            context, 'Add To Cart',cubit.data?.data?['in_cart']  ? null : (){
                          cubit.postAddProductToCart(productId);
                          Navigator.pop(context);
                        }
                        )
                    ))
                  ],
                )
              ],
            ) ;
          },
          fallback: (context){
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p22),
                child: CircularProgressIndicator(color: ColorManager.primary,),
              ),
            );
          })
    );
  },
),
);
  }
}
