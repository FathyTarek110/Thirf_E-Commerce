import 'package:ecommerce_clean_arch/core/resources/color_manger/color_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/reusable_comp/reusable_comp.dart';
import 'package:flutter/Material.dart';

class FirstTap extends StatelessWidget {
  const FirstTap({super.key});

  @override
  Widget build(BuildContext context) {
    return OrdersCard(orderId: '2135', date: '18/10/2023',price: 2030 ,status: 'Delivered', statusColor: ColorManager.green,details: (){},);
  }
}


