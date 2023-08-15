import 'package:ecommerce_clean_arch/core/resources/reusable_comp/reusable_comp.dart';
import 'package:ecommerce_clean_arch/core/resources/values_manager/values_manger.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/main_layout/main_layout.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/profile_view/orders/oders_screen.dart';
import 'package:flutter/Material.dart';

import '../home_view/home_view.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/Successfulpurchase.gif'),
              const SizedBox(
                height: AppSize.s12,
              ),
              Row(
                children: [
                  buildMyButton(context, 'Back to Home Page ', () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const MainLayout()));

                  }),
                  const Spacer(),
                  buildMyButton(context, 'View Orders ', () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const OrderScreen()));

                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
