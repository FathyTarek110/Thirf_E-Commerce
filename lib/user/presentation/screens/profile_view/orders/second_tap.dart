import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/core/resources/color_manger/color_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/reusable_comp/reusable_comp.dart';
import 'package:flutter/Material.dart';

import '../../../../domain/entities/orders/orders.dart';

class SecondTap extends StatelessWidget {
  const SecondTap({super.key, this.orders});
  final Orders? orders;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
        condition: orders!.orders!.isNotEmpty ,
        builder: (_)=>ListView.builder(
          itemCount: orders!.orders!.length,
          itemBuilder: (BuildContext context, int index) {
            return OrdersCard(orderId: orders!.orders![index]['id'].toString(), date: orders!.orders![index]['date'], status: orders!.orders![index]['status'], statusColor: ColorManager.yellow,price: orders!.orders![index]['total'],details: (){},);
          },
        ), fallback: (_)=>Center(child: CircularProgressIndicator(color: ColorManager.primary,),));
  }
}
