import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/core/resources/color_manger/color_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/values_manager/values_manger.dart';
import 'package:ecommerce_clean_arch/user/presentation/controller/main_layout_cubit/main_layout_cubit.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/profile_view/Payment_method_screen.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/profile_view/adress/address_screen.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/profile_view/orders/oders_screen.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/profile_view/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/reusable_comp/reusable_comp.dart';
import '../../../../core/services/service_locator.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => MainLayoutCubit(sl(), sl(), sl(), sl(), sl(),sl(),sl(),sl())..getProfileInfo(),
  child: BlocConsumer<MainLayoutCubit, MainLayoutState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    MainLayoutCubit cubit = MainLayoutCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: SafeArea(
        child: ConditionalBuilder(
            condition: state is GetProfileSuccess,
            builder: (_)=>SizedBox(
              child: Column(
                children: [
                  //profile pic and name
                  Row(
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width/9,
                        backgroundImage: NetworkImage(cubit.profile.image),
                        backgroundColor: ColorManager.white,
                      ),
                      SizedBox(
                        width: AppSize.s12,
                      )
                      ,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cubit.profile.name),
                          Text(cubit.profile.email),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.s12,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildProfileSettingsCard(context: context, title: 'my orders', description: 'description', onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>const OrderScreen()));
                        }),
                        buildProfileSettingsCard(context: context, title: 'Shipping Addresses', description: 'description', onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>const AddressScreen()));

                        }),
                        buildProfileSettingsCard(context: context, title: 'Payment Methods', description: 'description', onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>const PaymentMethodScreen()));

                        }),
                        buildProfileSettingsCard(context: context, title: 'Settings', description: 'description', onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> SettingsScreen(email: cubit.profile.email,name: cubit.profile.name,)));

                        }),

                      ],
                    ),
                  )

                ],
              ),
            ),
            fallback: (_)=>Center(
              child:  CircularProgressIndicator(color: ColorManager.primary,),
            ))
      ),
    );
  },
),
);
  }


}
