import 'package:flutter/Material.dart';

import '../../../../../core/resources/color_manger/color_manager.dart';
import '../../../../../core/resources/reusable_comp/reusable_comp.dart';

class ThirdTap extends StatelessWidget {
  const ThirdTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrdersCard(orderId: '2122', date: '18/11/2023',price: 2000 ,status: 'canceled', statusColor: ColorManager.red,details: (){},),
     OrdersCard(orderId: '21212', date: '18/5/2023',price: 3490 ,status: 'canceled', statusColor: ColorManager.red,details: (){},)

    ],
    );
  }
}
