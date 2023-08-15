import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/core/resources/font_manger/font_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/values_manager/values_manger.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/orders/estimate_order.dart';
import 'package:ecommerce_clean_arch/user/presentation/controller/cart_payment_cubit/cart_and_payment_cubit.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/cart_and_payment/payment_success.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/profile_view/adress/address_screen.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../../../core/resources/color_manger/color_manager.dart';
import '../../../../core/resources/reusable_comp/reusable_comp.dart';
import '../../../../core/services/service_locator.dart';
import '../profile_view/Payment_method_screen.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key, required this.estimateOrder,});
  final EstimateOrder estimateOrder;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => CartAndPaymentCubit(sl(), sl(), sl(),sl(),sl())..getAllAddresses(),
  child: BlocConsumer<CartAndPaymentCubit, CartAndPaymentState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    CartAndPaymentCubit cubit = CartAndPaymentCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check out'),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:  Icon(Icons.arrow_back,color: ColorManager.primary,)),
      ),


      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                CheckOutTitleAndButton(title: 'Shipping Address',function: ()  async{
                  bool refresh = await Navigator.push(context, MaterialPageRoute(
                      builder: (_)=> const AddressScreen()));
                  print(refresh);
                  if(refresh == true){
                    cubit.getAllAddresses();
                  }
                }, iShippingAddress: true,),
                ConditionalBuilder(
                    condition: state is! GetAddressesInitial,
                    builder: (_)=> Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/5,
                      child: Swiper(
                        onIndexChanged: (index){
                          cubit.currentSwiperIndex = index;
                          print(index);
                        },
                        controller: cubit.addressSwiperController,
                        layout: SwiperLayout.STACK,
                        itemCount: cubit.addresses!.addresses.length,
                        itemWidth: MediaQuery.of(context).size.width/1.2,
                        loop: true,
                        scrollDirection: Axis.horizontal,
                        duration: 1200,
                        itemBuilder: (context,index) {
                          return CheckoutLocationContainer(name: cubit.addresses?.addresses[index]['name'], locationDetails: cubit.addresses?.addresses[index]['city'],notes: cubit.addresses?.addresses[index]['notes'], details: cubit.addresses?.addresses[index]['details'],);
                        },
                      ),
                    ),
                    fallback: (_)=>Center(child: CircularProgressIndicator(color: ColorManager.primary,),)),
                const SizedBox(height: AppSize.s16,),
                CheckOutTitleAndButton(title: 'Payment Methods',function: (){}, iShippingAddress: false,),
                DropdownButton(
                    isExpanded: true,
                    value: cubit.dropDownValue,
                    items: const [
                      DropdownMenuItem<int>(value: 1,child: Text('cash on Delivery'),),
                      DropdownMenuItem<int>(value: 2,child: Text('Credit/Debit Card'),),
                    ], onChanged: (value){
                  cubit.changeDropDownValue(value!);
                }),

                if(cubit.dropDownValue == 2) Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/3.5,
                  child: Swiper(
                    controller: cubit.addressSwiperController,
                    layout: SwiperLayout.STACK,
                    itemCount: cubit.credits.length,
                    itemWidth: MediaQuery.of(context).size.width/1.2,
                    loop: false,
                    scrollDirection: Axis.horizontal,
                    duration: 1200,
                    itemBuilder: (context,index) {
                      print(cubit.addressSwiperController.index);
                      return MyCreditCard(name: cubit.credits[index][0], number: cubit.credits[index][1], expDate: cubit.credits[index][2],color: cubit.credits[index][3],);
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s16,),

                CheckOutTitleAndButton(title: 'Shipping Method',function: (){}, iShippingAddress: false,),
                const SizedBox(height: AppSize.s10,),

                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: ColorManager.white,borderRadius: BorderRadius.circular(AppSize.s16),),
                    child: Row(
                      children: [
                          Container(
                            child: Image.asset('assets/images/dhl.png'),
                          width: MediaQuery.of(context).size.width/3.5,),
                        Text('Fast (2-3 days)')
                      ],
                    )),
                const SizedBox(height: AppSize.s16,),

                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: ColorManager.white,borderRadius: BorderRadius.circular(AppSize.s16),),
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [


                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('points : ${(estimateOrder.points ).toStringAsFixed(2)} EGP',style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: FontSize.s20),)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('discount : ${(estimateOrder.discount).toStringAsFixed(2) } EGP',style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: FontSize.s20),)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Sub Total : ${(estimateOrder.subTotal).toStringAsFixed(2) } EGP',style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: FontSize.s20),)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Total : ${(estimateOrder.total).toStringAsFixed(2) } EGP',style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: FontSize.s20),)
                            ],
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: AppSize.s16,),



              ],
            )),

            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  width:double.infinity ,
                  child: ConditionalBuilder(
                      condition: state is! AddOrderInitial,
                      builder: (_)=>buildMyButton(context, 'Submit Order', () {
                         cubit.addOrder(cubit.addresses?.addresses[cubit.currentSwiperIndex]['id'], 1, false,context);
                      }),
                      fallback: (BuildContext context) {
                        return Center(child: CircularProgressIndicator(color: ColorManager.primary,),);
                      })),
            ),

          ],
        ),
      ),
    );
  },
),
);
  }
}



class CheckoutLocationContainer extends StatelessWidget {
  const CheckoutLocationContainer({super.key, required this.name, required this.locationDetails, this.notes, required this.details});


  final String name;
  final String locationDetails;
  final String details;
  final String? notes;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: FontSize.s18,),),
            const MySpacer(),
            Text(locationDetails,style: Theme.of(context).textTheme.bodySmall,),
            Text(details,style: Theme.of(context).textTheme.bodySmall,overflow: TextOverflow.ellipsis,maxLines: 2,),

            Text(notes ?? '',style: Theme.of(context).textTheme.bodySmall,overflow: TextOverflow.ellipsis,maxLines: 2,),


          ],
        ),
      ),
    );
  }
}


