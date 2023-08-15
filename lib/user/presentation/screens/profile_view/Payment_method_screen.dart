import 'package:ecommerce_clean_arch/core/resources/font_manger/font_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/reusable_comp/reusable_comp.dart';
import 'package:ecommerce_clean_arch/core/resources/values_manager/values_manger.dart';
import 'package:ecommerce_clean_arch/user/presentation/controller/payment_method_cubit/payment_method_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../../../core/resources/color_manger/color_manager.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => PaymentMethodCubit(),
  child: BlocConsumer<PaymentMethodCubit, PaymentMethodState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    PaymentMethodCubit cubit = PaymentMethodCubit.get(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20))
            ),
            context: context, 
            builder: (_)=>Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
              myTextFormField(context: context, controller: cubit.name, label: 'Card Holder Name', obscure: false, enableSuggestions: false, autoCorrect: false),
              myTextFormField(context: context, controller: cubit.num, label: 'Card Number', obscure: false, enableSuggestions: false, autoCorrect: false),
              myTextFormField(context: context, controller: cubit.expDate, label: 'Exp Date', obscure: false, enableSuggestions: false, autoCorrect: false),
              myTextFormField(context: context, controller: cubit.cvv, label: 'CVV', obscure: false, enableSuggestions: false, autoCorrect: false),
              Row(
                children: [
                  buildMyButton(context, 'cancel', () { Navigator.pop(context);}),
                  const Spacer(),
                  buildMyButton(context, 'Add Card', () { })
                ],
              )

          ],
        ),
            ));
      },child:Icon(Icons.add),backgroundColor: ColorManager.primary,),
      appBar: AppBar(
        title: const Text('Your Cards'),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:  Icon(Icons.arrow_back,color: ColorManager.primary,)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2,
            child: Swiper(
                layout: SwiperLayout.STACK,
                itemWidth: MediaQuery.of(context).size.width/1.2,
                itemHeight: MediaQuery.of(context).size.height/3.5,
                itemCount: cubit.credits.length,
                loop: true,
              duration: 1200,
              scrollDirection: Axis.vertical,
              itemBuilder: (context,index){
                  return MyCreditCard(name: cubit.credits[index][0], number: cubit.credits[index][1], expDate: cubit.credits[index][2],color: cubit.credits[index][3],);
              },
            ),
          ),
          
          
        ],
      ),
    );
  },
),
);
  }
}

class MyCreditCard extends StatelessWidget {
  const MyCreditCard({
    super.key, required this.name, required this.number, required this.expDate, required this.color,
  });
final String name;
final String number;
final String expDate;
final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(

        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width/ 7,
                      child: Image.asset('assets/images/mastercard.png'))
                ],
              ),
              Text(number,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.white,fontSize: FontSize.s22),),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Card Holder ',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.white,fontSize: FontSize.s16),textAlign: TextAlign.start,),
                      Text(name,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.white,fontSize: FontSize.s16),textAlign: TextAlign.start),

                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Expiry Date ',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.white,fontSize: FontSize.s16),textAlign: TextAlign.start,),
                      Text(expDate,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.white,fontSize: FontSize.s16),textAlign: TextAlign.start),

                    ],
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
