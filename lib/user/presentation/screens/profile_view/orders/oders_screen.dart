import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/user/presentation/controller/orders_cubit/orders_cubit.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/profile_view/orders/first_tap.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/profile_view/orders/second_tap.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/profile_view/orders/third_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/color_manger/color_manager.dart';
import '../../../../../core/services/service_locator.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => OrdersCubit(sl())..getAllOrders(),
  child: BlocConsumer<OrdersCubit, OrdersState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    OrdersCubit cubit = OrdersCubit.get(context);
    return ConditionalBuilder(
        condition: State is! GetOrdersInitial,
        builder: (_)=>DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('My Orders'),
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon:  Icon(Icons.arrow_back,color: ColorManager.primary,)),
            ),
            body: Column(
              children: [
                TabBar(
                  indicatorColor: ColorManager.primary,
                  tabs: [
                    Tab(
                      child: Text('Delivered',style: Theme.of(context).textTheme.bodyMedium,),

                    ),
                    Tab(
                      child: Text('Processing',style: Theme.of(context).textTheme.bodyMedium,),

                    ),
                    Tab(
                        child: Text('Canceled',style: Theme.of(context).textTheme.bodyMedium,)

                    ),
                  ],),
                Expanded(
                  child: Container(
                    child:  TabBarView(
                        children: [
                          FirstTap(),
                          SecondTap(orders: cubit.orders,),
                          ThirdTap(),
                        ]
                    ),
                  ),
                )
              ],
            ),



          ),
        ),
        fallback: (_)=>Center(child: CircularProgressIndicator(color: ColorManager.primary,),));
  },
),
);
  }
}
