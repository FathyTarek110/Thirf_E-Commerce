import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/core/resources/color_manger/color_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/font_manger/font_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/reusable_comp/reusable_comp.dart';
import 'package:ecommerce_clean_arch/core/resources/values_manager/values_manger.dart';
import 'package:ecommerce_clean_arch/user/presentation/controller/cart_payment_cubit/cart_and_payment_cubit.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/cart_and_payment/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartAndPaymentCubit(sl(),sl(),sl(),sl(),sl())..getCartItems()..swiperInit(),
      child: BlocConsumer<CartAndPaymentCubit, CartAndPaymentState>(
        listener: (context, state) {
          if(state is CartAndPaymentGetCartSuccess){
            CartAndPaymentCubit.get(context).getOrderCosts(false, 0);
          }
        },
        builder: (context, state) {
          CartAndPaymentCubit cubit = CartAndPaymentCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon:  Icon(Icons.arrow_back,color: ColorManager.primary,)),
              title: const Text('My Cart'),
            ),
            body: ConditionalBuilder(
                condition: state is! CartAndPaymentGetCartInitial,
                builder: (_)=>cubit.cartItems.isNotEmpty ?Column(
                  children: [
                    Expanded(child: Container(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                          itemCount: cubit.cartItems.length,
                          itemBuilder: (context,index){
                            return buildFavouriteAndCartContainer(context: context, isCart: true, name: cubit.cartItems[index]['product']['name'], price: cubit.cartItems[index]['product']['price'], image: cubit.cartItems[index]['product']['image'], id: cubit.cartItems[index]['product']['id'], crossImageFunction: () {
                              cubit.deleteProductfromCart(cubit.cartItems[index]['product']['id'], index);
                            }, shoppingBagImage: null, plusSignCart: () {
                              cubit.cartItems[index]['quantity']++;
                              cubit.updateCart();
                              },
                              minusSignCart: cubit.cartItems[index]['quantity']! > 1 ?  () {
                                cubit.cartItems[index]['quantity']--;
                                cubit.updateCart();
                              } : (){}, quantity: cubit.cartItems[index]['quantity'], );
                          }),
                    )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: Column(

                          children: [
                            
                            Padding(
                              padding: const EdgeInsets.all(AppPadding.p8),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(AppPadding.p12),
                                    child: Row(
                                      children: [
                                        Text('use Points',style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: FontSize.s18),),
                                        Spacer(),
                                        Switch(
                                            activeColor: ColorManager.primary,
                                            value: cubit.usepoints, onChanged: (value){
                                              cubit.usePointsMethod();
                                              print(cubit.usepoints);
                                        })
                                      ],
                                    ),
                                  ),
                                  Row(

                                    children: [
                                      Expanded(child: Padding(
                                        padding: const EdgeInsets.all(AppPadding.p8),
                                        child: Container(child: myTextFormField(context: context, controller: cubit.promoTextEditingController, label: 'enter your promo code', obscure: false, enableSuggestions: false, autoCorrect: false)),
                                      )),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: ColorManager.primary,
                                          borderRadius: BorderRadius.circular(AppSize.s6)
                                        ),
                                        child: IconButton(
                                            splashColor: Colors.transparent,
                                            style: IconButton.styleFrom(

                                            ),
                                            onPressed: (){}, icon:Icon(Icons.arrow_forward_outlined,color: ColorManager.white,)),
                                      )

                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(AppPadding.p8),
                              child:ConditionalBuilder(
                                  condition: state is EstimateOrderSuccess,
                                  builder: (_)=> Row(

                                    children: [
                                      Row(
                                        children: [
                                          Text('Total',style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.gray),),
                                          Text('(VAT included)',style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.gray,fontSize: FontSize.s12),),

                                        ],
                                      ),
                                      const Spacer(),
                                      Text('${(cubit.estimateOrder?.total)?.toStringAsFixed(2)} EGP',style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: FontSize.s20),),
                                      const SizedBox(width: AppSize.s10,),



                                    ],
                                  ), fallback: (_)=>Center(child: CircularProgressIndicator(color: ColorManager.primary,))
                            ),
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: buildMyButton(context, 'Check out', () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> CheckOutPage(estimateOrder: cubit.estimateOrder!,)));
                                })),
                          ],
                        ),
                      ),
                    )
                  ],
                ): Column(
                  children: [
                    Image.asset('assets/images/Add to Cart.gif'),
                    const Center(child: Text('No Items In Cart Yet'),),
                  ],
                ),
                fallback: (_)=>Center(
                  child: CircularProgressIndicator(color: ColorManager.primary,),
                )),
          );
        },
      ),
    );
  }
}
